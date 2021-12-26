# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit font

DESCRIPTION="single-header ANSI C cross platform GUI library"
HOMEPAGE="https://immediate-mode-ui.github.io/Nuklear/"

SRC_URI="https://github.com/Immediate-Mode-UI/Nuklear/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/Nuklear-${PV}
SLOT="0"

KEYWORDS="~amd64"
LICENSE="MIT Unlicense"

HTML_DOCS=( "doc/nuklear.html" )

src_install() {
	doheader nuklear.h
	dosym ../nuklear.h /usr/include/nuklear/nuklear.h
	FONT_SUFFIX="ttf" FONT_S="${S}/extra_font/" font_src_install
	einstalldocs
}
