# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit meson xdg

DESCRIPTION="Modular status panel for X11 and Wayland"
HOMEPAGE="https://codeberg.org/dnkl/yambar"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/yambar"
else
	SRC_URI="https://codeberg.org/dnkl/yambar/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="modules"

RDEPEND="
	dev-libs/libyaml
	dev-libs/wayland
	media-libs/fcft
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libxcb
	x11-libs/pango
	x11-libs/xcb-util
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-wm
"
DEPEND="${RDEPEND}
	dev-libs/tllist
"
BDEPEND="
	app-text/scdoc
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		-Dwerror=false
		-Dbackend-x11=enabled
		-Dbackend-wayland=enabled
		$(meson_use modules core-plugins-as-shared-libraries)
	)
	meson_src_configure
}
