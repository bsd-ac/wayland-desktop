# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A compiz like 3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wayfire"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WayfireWM/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/WayfireWM/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+wcm +wf-recorder +wf-shell +wf-config +wlroots +elogind systemd debug"

DEPEND="
		media-libs/glm
		x11-libs/gtk+:3
		x11-libs/cairo
		x11-libs/libxkbcommon
		x11-libs/pixman
		media-libs/libjpeg-turbo
		media-libs/libpng
		>=dev-libs/gtk-layer-shell-0.1.0
		wcm? ( >=gui-apps/wcm-0.3.1 )
		wf-shell? ( >=gui-apps/wf-shell-0.3 )
		wf-recorder? ( >=gui-apps/wf-recorder-0.2 )
		wf-config? ( >=gui-apps/wf-config-0.3 )
		wlroots? ( >=gui-libs/wlroots-0.9.1[elogind=,systemd=,X] )
		elogind? ( sys-auth/elogind )
		systemd? ( sys-apps/systemd )
"

RDEPEND="
		${DEPEND}
		x11-misc/xkeyboard-config
"

BDEPEND+="
		virtual/pkgconfig
		dev-libs/wayland-protocols
"

src_configure(){
	local emsonargs=(
		-Duse_system_wfconfig=$(usex wf-config true false)
		-Duse_system_wlroots=$(usex wlroots true false)
	)
	if use debug; then
		emesonargs+=(
			"--buildtype=debug"
			"-Denable_debug_output=true"
			"-Denable_graphics_debug=true"
			"-Db_sanitize=address,undefined"
		)
	else
		emesonargs+=(
			"--buildtype=release"
		)
	fi
	meson_src_configure
}

pkg_preinst() {
	if ! use systemd && ! use elogind; then
		fowners root:0 /usr/bin/wayfire
		fperms 4511 /usr/bin/wayfire
	fi
}

src_install() {
	default;
	meson_src_install;

	insinto "/usr/share/wayland-sessions/";
	insopts -m644;
	doins wayfire.desktop;

	insinto "/usr/share/doc/${P}/";
	insopts -m644;
	doins wayfire.ini.default;
}

pkg_postinst() {
	elog "Wayfire has been installed but the session cannot be used"
	elog "until you install a configuration file. The default config"
	elog "file is installed at \"/usr/share/doc/${P}/wayfire.default.ini.bz2\""
	elog "To install the file execute"
	elog "\$ mkdir -p ~/.config && bzcat /usr/share/doc/${P}/wayfire.ini.default.bz2 > ~/.config/wayfire.ini"
}
