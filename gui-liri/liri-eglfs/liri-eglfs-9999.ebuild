# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="shared cmake configuration utils for liri"
HOMEPAGE="https://github.com/lirios/cmake-shared"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/eglfs"
else
	COMMIT=d55225b4edcfebabef3b2f2ff0f338ab31bad68a
	SRC_URI="https://github.com/lirios/eglfs/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/eglfs-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-libs/libinput
	dev-qt/qtcore:5
	gui-liri/libliri
	gui-liri/liri-qtudev
	x11-libs/libdrm
	media-libs/mesa[gbm,egl]
"
DEPEND="${RDEPEND}
	media-libs/libglvnd
"
