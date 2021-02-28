# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

FONT_SUFFIX=ttf
inherit font

DESCRIPTION="joypixels font for better emoji and unicode support"
HOMEPAGE="https://www.joypixels.com/"

SRC_URI="https://cdn.joypixels.com/distributions/gentoo-linux/font/${PV}/joypixels-android.ttf -> ${P}.ttf"
KEYWORDS="~amd64"
S="${WORKDIR}"

#https://cdn.joypixels.com/distributions/gentoo-linux/appendix/joypixels-license-appendix.txt
#https://cdn.joypixels.com/distributions/gentoo-linux/license/free-license.txt
LICENSE="JoyPixels"
SLOT="0"

src_prepare() {
	default
	cp "${DISTDIR}"/${P}.ttf "${S}"/${P}.ttf || die
}
