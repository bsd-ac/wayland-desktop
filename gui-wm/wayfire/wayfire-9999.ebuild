# Copyright 2019 Gentoo Authors
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
	SRC_URI="https://github.com/WayfireWM/${PN}/releases/download/${PV}/${P}.tar.xz -> ${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+wcm +wf-shell +wf-recorder +elogind systemd"

DEPEND="
		media-libs/glm
		x11-libs/gtk+
		x11-libs/cairo
		x11-libs/libxkbcommon
		x11-libs/pixman
		media-libs/libjpeg-turbo
		media-libs/libpng
		>=dev-libs/gtk-layer-shell-0.1
    =gui-apps/wf-config-9999
		wcm? ( =gui-apps/wcm-9999 )
		wf-shell? ( =gui-apps/wf-shell-9999 )
		wf-recorder? ( =gui-apps/wf-recorder-9999 )
		elogind? ( sys-auth/elogind )
		systemd? ( sys-apps/systemd )
		"
BDEPEND="
		virtual/pkgconfig
		dev-libs/wayland-protocols
		"

if [[ ${PV} == 9999 ]]; then
	DEPEND+="=gui-libs/wlroots-9999[elogind=,systemd=,X]"
else
	DEPEND+=">=gui-libs/wlroots-0.8.0[elogind=,systemd=]"
fi

RDEPEND="
	x11-misc/xkeyboard-config
	${DEPEND}
"

pkg_preinst() {
	if ! use systemd && ! use elogind; then
		fowners root:0 /usr/bin/wayfire
		fperms 4511 /usr/bin/wayfire
	fi
}
