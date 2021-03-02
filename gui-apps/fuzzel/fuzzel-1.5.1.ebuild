# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit meson xdg

DESCRIPTION="Application launcher similar to rofi's 'drun' mode"
HOMEPAGE="https://codeberg.org/dnkl/yambar"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/fuzzel"
else
	SRC_URI="https://codeberg.org/dnkl/fuzzel/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="cairo png svg"

RDEPEND="
	dev-libs/wayland
	media-libs/fcft
	x11-libs/libxkbcommon
	cairo? ( x11-libs/cairo )
	png? ( media-libs/libpng )
	svg? ( gnome-base/librsvg )
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
		$(meson_feature cairo enable-cairo)
		$(meson_feature png enable-png)
		$(meson_feature svg enable-svg)
	)
	meson_src_configure
}
