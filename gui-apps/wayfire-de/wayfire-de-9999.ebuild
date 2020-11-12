EAPI=7

DESCRIPTION="meta package for a simple wayfire DE"
HOMEPAGE="https://github.com/"

LICENSE="ISC"
SLOT="0"

RDEPEND="
	dev-libs/light
	gui-apps/azote
	gui-apps/grim
	gui-apps/mako
	gui-apps/nwg-launchers
	gui-apps/slurp
	gui-apps/swaylock-effects
	gui-apps/wl-clipboard
	gui-apps/wayland-logout
	gui-wm/wayfire
	x11-themes/beautyline-icon-theme
	x11-themes/candy-icon-theme
	x11-themes/oie-icon-theme
	x11-themes/sweet-folders-icon-theme
	x11-themes/sweet-dark-gtk-theme
	virtual/cron
"

src_install() {
	local sdir="${FILESDIR}"/${PV}

	dobin "${sdir}"/wayfire-de-setup

	insinto /usr/share/icons/
	doins -r "${sdir}"/wayfire-de

	insinto /usr/share/wayfire-de
	doins -r "${sdir}"/wayfire-de_configs/.
}
