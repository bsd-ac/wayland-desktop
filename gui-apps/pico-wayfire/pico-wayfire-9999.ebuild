# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="Opinionated dotfiles for a consistent look on wayfire"
HOMEPAGE="https://github.com/bsd-ac/pico-wayfire"

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bsd-ac/pico-wayfire"
else
	SRC_URI="https://github.com/bsd-ac/pico-wayfire/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="CC-BY-NC-ND-3.0 GPL-3 ISC"
SLOT="0"
IUSE="+recommended"

RDEPEND="
	media-fonts/fira-code
	media-fonts/fontawesome[otf,ttf]
	media-fonts/joypixels
	media-fonts/noto[cjk]
	media-fonts/powerline-symbols
	x11-themes/bibata-cursor-theme[modern]
	x11-themes/pico-wayfire-icon-theme
	x11-themes/sweet-dark-gtk-theme
	recommended? (
		dev-libs/light
		gui-apps/grim
		gui-apps/mako
		gui-apps/nwg-launchers[bar,dmenu,grid]
		gui-apps/slurp
		gui-apps/swappy
		gui-apps/swaylock-effects[gdk-pixbuf]
		gui-apps/waybar[network,popups,pulseaudio,tray,wifi]
		gui-apps/wayland-logout
		gui-apps/wcm
		gui-apps/wf-shell
		gui-apps/wl-clipboard
		gui-libs/wayfire-plugins-extra
		x11-terms/kitty
	)
"

src_configure() {
	export VERSION="${PV}"
}
