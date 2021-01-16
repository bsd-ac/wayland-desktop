
EAPI=7

inherit font

DESCRIPTION="joypixels font for better emoji and unicode support"
HOMEPAGE="https://www.joypixels.com/"

SRC_URI="https://cdn.joypixels.com/arch-linux/font/${PV}/joypixels-android.ttf -> ${P}.ttf"
KEYWORDS="~amd64"
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
