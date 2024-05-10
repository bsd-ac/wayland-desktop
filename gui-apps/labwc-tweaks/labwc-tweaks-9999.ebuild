# Copyright 2024 Daniella 'tfemby' Kicsak
# Distributed under the terms of the ISC License

EAPI=8

inherit cmake xdg-utils

DESCRIPTION="A GUI 'Settings' application for labwc"
HOMEPAGE="https://github.com/labwc/labwc-tweaks"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/labwc/labwc-tweaks.git"
else
	GIT_COMMIT="7d385ec32a529d3e1f3b525d1dbbcad6eb4d535b"
	SRC_URI="https://github.com/labwc/labwc-tweaks/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/labwc-tweaks-${GIT_COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2 BSD"
SLOT="0"

RDEPEND="
	dev-libs/libxml2
	dev-libs/glib:2
	dev-qt/qtbase:6
"
DEPEND="${RDEPEND}"

BDEPEND="
	dev-lang/perl
	dev-qt/qttools:6
	virtual/pkgconfig
	x11-libs/libxkbcommon
"

src_configure() {
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
