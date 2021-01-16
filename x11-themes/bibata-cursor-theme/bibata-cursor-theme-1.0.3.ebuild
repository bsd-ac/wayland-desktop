
EAPI="7"

inherit xdg-utils

DESCRIPTION="material based cursor theme"
HOMEPAGE="https://github.com/ful1e5/Bibata_Cursor"
SRC_URI="https://github.com/ful1e5/Bibata_Cursor/releases/download/v${PV}/Bibata.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE="+modern original"
REQUIRED_USE="?? ( modern original )"

src_install() {
	local flavors_modern=(
		Bibata-Modern-Amber
		Bibata-Modern-Classic
		Bibata-Modern-Ice
	)
	if use modern; then
		for flavor in ${flavors_modern[@]}; do
			insinto /usr/share/cursors/xorg-x11/${flavor}
			doins -r ${flavor}/.
		done
	fi
	local flavors_original=(
		Bibata-Original-Amber
		Bibata-Original-Classic
		Bibata-Original-Ice
	)
	if use original; then
		for flavor in ${flavors_original[@]}; do
			insinto /usr/share/cursors/xorg-x11/${flavor}
			doins -r ${flavor}/.
		done
	fi
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
