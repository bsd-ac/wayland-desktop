EAPI=7

inherit xdg-utils

DESCRIPTION="dotfiles for creating a consistent look on wayfire"
HOMEPAGE="https://github.com/bsd-ac/pico-wayfire"

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bsd-ac/pico-wayfire"
else
	SRC_URI="https://github.com/bsd-ac/pico-wayfire/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"

RDEPEND="
	dev-libs/light
	gui-apps/grim
	gui-apps/mako
	gui-apps/nwg-launchers[bar,dmenu,grid]
	gui-apps/slurp
	gui-apps/swappy[libnotify]
	gui-apps/swaylock-effects[gdk-pixbuf]
	gui-apps/waybar[network,popups,pulseaudio,tray]
	gui-apps/wayland-logout
	gui-apps/wcm
	gui-apps/wf-shell
	gui-apps/wl-clipboard
	gui-wm/wayfire
	media-fonts/anonymous-pro
	media-fonts/fira-code
	media-fonts/fontawesome[otf,ttf]
	media-fonts/joypixels
	x11-terms/terminator
	x11-themes/bibata-cursor-theme[modern]
	x11-themes/beautyline-icon-theme
	x11-themes/candy-icon-theme
	x11-themes/oie-icon-theme
	x11-themes/sweet-folders-icon-theme
	x11-themes/sweet-dark-gtk-theme
"

src_install() {
	emake DESTDIR="${ED}" LIBDIR="/usr/$(get_libdir)" VERSION="${PV}" install
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
