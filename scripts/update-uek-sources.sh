#!/bin/bash

set -o errexit
set -o nounset

: ${PATH_GURU:="../guru"}
: ${PATH_GENTOO:="../gentoo"}
: ${PATH_DISTFILES:="/var/cache/distfiles"}
: ${PATH_OVERLAY_DISTFILES:="DISTDIR"}

: ${UEK_SOURCES_URL:="https://github.com/oracle/linux-uek"}
: ${UEK_BRANCH:="5.15"}

echo "Updating gentoo git tree..."
pushd ${PATH_GENTOO}
git stash || true
git pull gentoo master
git stash pop || true
popd
echo "Done."

echo "Updating guru git tree..."
pushd ${PATH_GURU}
git stash || true
git pull
git stash pop || true
popd
echo "Done."

echo "Finding latest gentoo patches..."
pushd ${PATH_GENTOO}/sys-kernel/gentoo-sources
latest_gentoo_kernel=$(ls -1 gentoo-sources-${UEK_BRANCH}*.ebuild | tail -n 1)
echo "Latest gentoo kernel for branch ${UEK_BRANCH}: ${latest_gentoo_kernel}"
latest_genpatches_version=$(grep -oP "K_GENPATCHES_VER=\"([0-9]*)\"" ${latest_gentoo_kernel} | grep -oP "([0-9]*)")
echo "Latest genpatches version: ${latest_genpatches_version}"
echo "Fetching latest genpatches..."
ebuild ${latest_gentoo_kernel} fetch
echo "Done."
popd

echo "Copying latest genpatches to wayland-desktop..."
cp -v ${PATH_DISTFILES}/genpatches-${UEK_BRANCH}-${latest_genpatches_version}.* ${PATH_OVERLAY_DISTFILES}
echo "Done."

echo "Fetching latest tags from ${UEK_SOURCES_URL}..."
latest_uek_tag=$(git ls-remote --sort='version:refname' --tags ${UEK_SOURCES_URL} | grep -oP "${UEK_BRANCH}\.[0-9]+-[0-9]+\.[0-9]+\.[0-9]+" | tail -n 1)
echo "Latest tag: ${latest_uek_tag}"
ebuild_version=$(echo ${latest_uek_tag} | sed -e "s/\-/./")
echo "Ebuild version: ${ebuild_version}"

ebuild_revision=$(ls -1 ${PATH_GURU}/sys-kernel/uek-sources/uek-sources-${ebuild_version}*.ebuild | wc -l)
if [[ ${ebuild_revision} -gt 0 ]]; then
    echo "Ebuild with tag ${latest_uek_tag} already exists."
    echo "Checking if latest ebuild for tag has the same genpatches version..."
    latest_revision=$(ls -1 ${PATH_GURU}/sys-kernel/uek-sources/uek-sources-${ebuild_version}*.ebuild | tail -n 1)
    echo "Latest ebuild: $(basename ${latest_revision})"
    if [[ $(grep -oP "K_GENPATCHES_VER=\"([0-9]*)\"" ${latest_revision} | grep -oP "([0-9]*)") -eq ${latest_genpatches_version} ]]; then
	echo "Latest ebuild has the same genpatches version."
	echo "Nothing to do."
	exit 0
    fi
    echo "Latest ebuild has a different genpatches version."
    ebuild_version="${ebuild_version}-r${ebuild_revision}"
    echo "Creating a new revision: ${ebuild_version}"
fi

echo "Creating new uek-sources ebuild..."
sed -e "s/@K_GENPATCHES_VER@/${latest_genpatches_version}/g" \
    scripts/uek-sources.ebuild.template > ${PATH_GURU}/sys-kernel/uek-sources/uek-sources-${ebuild_version}.ebuild
pushd ${PATH_GURU}/sys-kernel/uek-sources
echo "Updating Manifest..."
ebuild uek-sources-${ebuild_version}.ebuild manifest
echo "Done."
echo "Committing changes..."
git add .
pkgdev commit --signoff
git push
echo "Done."
popd

echo "Uploading patches to floss.bsd.ac"
sh scripts/distmirror-upload
echo "Done."
