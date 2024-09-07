# Copyright 2024 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

DESCRIPTION="A GUI 'Settings' application for labwc"
HOMEPAGE="https://github.com/labwc/labwc-tweaks"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/labwc/labwc-tweaks.git"
else
	GIT_COMMIT="3181374481638b0ba8a5e37d94b0bfd8884ca3bb"
	SRC_URI="https://github.com/labwc/labwc-tweaks/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	MY_PN="${PN/0/}"
	S="${WORKDIR}/${MY_PN}-${GIT_COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2 BSD"
SLOT="0"

RDEPEND="
	dev-qt/qtbase:6
	dev-libs/libxml2
	dev-libs/glib:2
"
DEPEND="${RDEPEND}"

BDEPEND="
	dev-lang/perl
	dev-qt/qttools:6
	x11-libs/libxkbcommon
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=None
		-DCMAKE_INSTALL_PREFIX=/usr
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
