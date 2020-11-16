
EAPI=7

inherit font

DESCRIPTION="joypixels font for better emoji and unicode support"
HOMEPAGE="https://www.joypixels.com/"

SRC_URI="https://cdn.joypixels.com/arch-linux/font/${PV}/joypixels-android.ttf -> ${P}.ttf"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
S="${WORKDIR}"

LICENSE="JoyPixel.pdf"
SLOT="0"

FONT_CONF=( "${FILESDIR}"/75-joypixels.conf )

src_prepare() {
	default
	cp "${DISTDIR}"/${P}.ttf "${S}"/${P}.ttf || die
}

src_install() {
	FONT_SUFFIX=ttf font_src_install
	font_fontconfig
}

pkg_postinst() {
	font_pkg_postinst
	eselect fontconfig enable 75-joypixels.conf
}
