# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit meson

DESCRIPTION="Library for font loading and glyph rasterization"
HOMEPAGE="https://codeberg.org/dnkl/fcft"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/fcft"
else
	SRC_URI="https://codeberg.org/dnkl/fcft/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+text-shaping"

RDEPEND="
	dev-libs/tllist
	media-libs/harfbuzz
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/pixman
"
BDEPEND="
	app-text/scdoc
"

src_prepare() {
	default
	sed -e "/werror/d" -i meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature text-shaping)
	)
	meson_src_configure
}
