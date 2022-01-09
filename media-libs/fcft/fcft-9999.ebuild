# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

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
IUSE="examples +grapheme-shaping +run-shaping test test-text-shaping"
REQUIRED_USE="test-text-shaping? ( run-shaping ) run-shaping? ( grapheme-shaping )"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/libutf8proc
	media-libs/harfbuzz
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/pixman
"
DEPEND="${RDEPEND}
	dev-libs/tllist
"
BDEPEND="
	app-text/scdoc
	test? ( dev-libs/check )
"

src_configure() {
	local emesonargs=(
		-Dwerror=false
		-Ddocs=enabled
		$(meson_feature grapheme-shaping)
		$(meson_feature run-shaping)
		$(meson_use examples)
		$(meson_use test-text-shaping)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	rm -r "${ED}/usr/share/doc/fcft" || die
	local -x DOCS=( LICENSE README.md CHANGELOG.md )
	einstalldocs
}
