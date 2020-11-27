
EAPI=7

inherit font

DESCRIPTION="single-header ANSI C cross platform GUI library"
HOMEPAGE="https://desq-project.org/"

COMMIT=74a4df4eb965150ede86fefa6c147476541078a4
SRC_URI="https://github.com/Immediate-Mode-UI/Nuklear/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/Nuklear-${COMMIT}
SLOT="$(ver_rs 1)/$(ver_rs 2)"

# C89 and ANSI C library
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
LICENSE="MIT Unlicense"
IUSE="+extras"

HTML_DOCS=( "doc/nuklear.html" )

src_install() {
	doheader nuklear.h
	use extras && \
		FONT_SUFFIX="ttf" \
		FONT_S="${S}/extra_font/" font_src_install
	einstalldocs
}
