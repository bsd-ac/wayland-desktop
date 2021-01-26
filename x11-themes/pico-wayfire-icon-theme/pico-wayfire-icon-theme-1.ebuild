
EAPI="7"

inherit xdg-utils

DESCRIPTION="meta icon theme for pico-wayfire"
HOMEPAGE="https://github.com/bsd-ac/pico-wayfire-icon-theme"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bsd-ac/pico-wayfire-icon-theme"
else
	SRC_URI="https://github.com/bsd-ac/pico-wayfire-icon-theme/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"

src_install() {
	insinto /usr/share/icons/PicoWayfire
	doins -r index.theme scalable
}

pkg_postinst(){
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
