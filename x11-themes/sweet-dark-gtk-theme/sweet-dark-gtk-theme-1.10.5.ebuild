
EAPI="7"

DESCRIPTION="Sweet (dark) gtk theme"
HOMEPAGE="https://github.com/EliverLara/Sweet"
SRC_URI="https://github.com/EliverLara/Sweet/releases/download/v${PV}/Sweet-Dark.zip -> ${P}.zip"
S="${WORKDIR}/Sweet-Dark"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	app-arch/unzip
"

src_install() {
	insinto /usr/share/themes/Sweet
	doins -r assets gnome-shell gtk-{2,3}.0 \
		  metacity-1 xfwm4 index.theme
}
