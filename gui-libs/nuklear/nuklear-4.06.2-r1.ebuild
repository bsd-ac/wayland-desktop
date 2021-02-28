# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit font

DESCRIPTION="single-header ANSI C cross platform GUI library"
HOMEPAGE="https://immediate-mode-ui.github.io/Nuklear/"

COMMIT=74a4df4eb965150ede86fefa6c147476541078a4
SRC_URI="https://github.com/Immediate-Mode-UI/Nuklear/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/Nuklear-${COMMIT}
SLOT="0/$(ver_rs 1-2)"

# C89 and ANSI C library
KEYWORDS="~amd64"
LICENSE="MIT Unlicense"

HTML_DOCS=( "doc/nuklear.html" )

src_install() {
	doheader nuklear.h
	dosym ../nuklear.h /usr/include/nuklear/nuklear.h
	FONT_SUFFIX="ttf" FONT_S="${S}/extra_font/" font_src_install
	einstalldocs
}
