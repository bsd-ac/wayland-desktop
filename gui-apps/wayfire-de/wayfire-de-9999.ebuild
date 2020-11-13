EAPI=7

inherit xdg-utils

DESCRIPTION="meta package for a simple wayfire DE"
HOMEPAGE="https://github.com/"

TTCOMMIT=ad56120e88be2125e26cdf5c55fde3a3c5499054
SRC_URI="https://raw.githubusercontent.com/EliverLara/terminator-themes/${TTCOMMIT}/plugin/terminator-themes.py"

if [[ "${PV}" != *9999 ]]; then
KEYWORDS="~amd64"
fi

S="${WORKDIR}"
LICENSE="ISC"
SLOT="0"

RDEPEND="
	dev-libs/light
	gui-apps/grim
	gui-apps/mako
	gui-apps/nwg-launchers[bar,dmenu,grid]
	gui-apps/oguri
	gui-apps/slurp
	gui-apps/swaylock-effects[gdk-pixbuf]
	gui-apps/waybar[network,popups,pulseaudio,tray]
	gui-apps/wayland-logout
	gui-apps/wl-clipboard
	gui-wm/wayfire
	media-fonts/fontawesome[otf,ttf]
	media-fonts/anonymous-pro
	media-fonts/fira-core
	x11-terms/terminator
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
	doins "${DISTDIR}"/terminator-themes.py
	exeinto /usr/share/wayfire-de
	doexe "${sdir}"/wallpaper_rotate
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
