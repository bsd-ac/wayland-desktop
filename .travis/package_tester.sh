#!/bin/bash
if ! test -d "${PACKAGE}"; then
	echo "WARNING: ${PACKAGE} not found in repository"
	exit 0
fi

case ${TRAVIS_CPU_ARCH} in
	amd64)
		ARCH1="amd64"
		#No image available yet
		#ARCH2="x86"
		;;
	arm64)
		ARCH1="arm64"
		#No image available yet
		#ARCH2="arm"
		;;
	#ppc64le)
		#No image available yet
		#ARCH1="ppc64"
		#ARCH2="ppc"
		#;;
	#s390x)
		#No image available yet
		#ARCH1="s390"
		#;;
	*)
		echo "ERROR: unknown TRAVIS_CPU_ARCH: ${TRAVIS_CPU_ARCH}"
		exit 1
		;;
esac

FILES=$(git --no-pager diff --name-only --diff-filter=ACMR "${TRAVIS_BRANCH}"...HEAD | grep -e "${PACKAGE}.*\.ebuild")
if [ "${FILES}" = "" ]; then
	echo "SUCCESS: ${PACKAGE} not modified"
	exit 0
fi

function iskeyword(){
        KEYWORDS=$(grep -Po "^${KEYWORDS}=\K.*" "${1}")
	if [[ KEYWORDS =~ ${2} ]]; then
		true
		return
	fi
}

REPONAME=$(basename "$(readlink -f .)")
mkdir -p .tmpfiles/distfiles
tar cf .travis/overlay.tar .
echo \
"[${REPONAME}]
location = /var/db/repos/${REPONAME}
priority = 100
masters = gentoo
auto-sync = no" > ".travis/overlay.conf"
if docker build --build-arg REPOPATH="/var/db/repos/${REPONAME}" -t dev .travis; then
	echo "INFO: runner for ${REPONAME} ready"
else
	echo "ERROR: failed to build runner for ${REPONAME}"
	exit 1
fi

for ebuild in ${FILES}; do
	atom="=$(dirname "$(dirname "${ebuild}")")/$(basename "${ebuild}")"
        atom=${atom%.ebuild}
        name=$(basename "${ebuild}")
        name=${name%.ebuild}
	distpath=$(readlink -f .tmpfiles/distfiles)
	if iskeyword "${ebuild}" "${ARCH1}"; then
		if docker run --mount type=bind,src="${distpath}",dst=/var/cache/distfiles \
		--rm --name "${name}" dev \
		/bin/bash -c "emerge -ou ${atom} && export FEATURES=test && emerge -f ${atom} && emerge --quiet n ${atom}"; then
			echo "INFO: ${atom} passed"
		else
			echo "ERROR: ${atom} failed"
			exit 1
		fi
	else
		echo "INFO: ${atom} not keyworded for ${ARCH1}"
	fi
	#ARCH2 runs not implemented yet
done

echo "SUCCESS: ${PACKAGE} passed"
