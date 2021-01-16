
EAPI=7

inherit font

DESCRIPTION="single-header ANSI C cross platform GUI library"
HOMEPAGE="https://immediate-mode-ui.github.io/Nuklear/"

COMMIT=fc5dc44d8ebdd2a712c680aa9b628258baa93b4f
SRC_URI="https://github.com/Immediate-Mode-UI/Nuklear/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/Nuklear-${COMMIT}
SLOT="$(ver_rs 1)/$(ver_rs 2)"

# C89 and ANSI C library
KEYWORDS="~amd64"
LICENSE="MIT Unlicense"
IUSE="+extras"

HTML_DOCS=( "doc/nuklear.html" )

src_install() {
	doheader nuklear.h
	dosym ../nuklear.h /usr/include/nuklear/nuklear.h
	use extras && \
		FONT_SUFFIX="ttf" \
		FONT_S="${S}/extra_font/" font_src_install
	einstalldocs
}
