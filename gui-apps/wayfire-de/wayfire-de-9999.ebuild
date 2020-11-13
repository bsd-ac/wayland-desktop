EAPI=7

inherit xdg-utils

DESCRIPTION="meta package for a simple wayfire DE"
HOMEPAGE="https://github.com/"

if [[ "${PV}" != *9999 ]]; then
KEYWORDS="~amd64"
fi

S="${WORKDIR}"
LICENSE="ISC"
SLOT="0"

RDEPEND="
	dev-libs/light
	gui-apps/oguri
	gui-apps/grim
	gui-apps/mako
	gui-apps/nwg-launchers[bar,dmenu,grid]
	gui-apps/slurp
	gui-apps/swaylock-effects[gdk-pixbuf]
	gui-apps/wl-clipboard
	gui-apps/wayland-logout
	gui-wm/wayfire
	media-fonts/fontawesome[otf,ttf]
	x11-themes/bibata-cursor-theme[modern]
	x11-themes/beautyline-icon-theme
	x11-themes/candy-icon-theme
	x11-themes/oie-icon-theme
	x11-themes/sweet-folders-icon-theme
	x11-themes/sweet-dark-gtk-theme
"

src_install() {
	local sdir="${FILESDIR}"/${PV}

	dobin "${sdir}"/wayfire-de-setup

	insinto /usr/share/icons/
	doins -r "${sdir}"/wayfire-de

	insinto /usr/share/wayfire-de
	doins -r "${sdir}"/wayfire-de_configs/.
	doins "${FILESDIR}"/default_wallpaper
	exeinto /usr/share/wayfire-de
	doexe "${sdir}"/wallpaper_rotate
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
