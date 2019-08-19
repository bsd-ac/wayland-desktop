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
	SRC_URI="https://github.com/WayfireWM/wayfire/releases/download/v${PV}/${P}.tar.xz -> ${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+wcm +wfshell +wfrecorder +wf-sound-control +wf-osk +elogind systemd"

DEPEND="
		media-libs/glm
		x11-libs/gtk+
		x11-libs/cairo
		x11-libs/libxkbcommon
		x11-libs/pixman
		media-libs/libjpeg-turbo
		media-libs/libpng
		wcm? ( =gui-apps/wcm-9999 )
		wfshell? ( =gui-apps/wf-shell-9999 )
		wfrecorder? ( =gui-apps/wf-recorder-9999 )
		wf-sound-control? ( =gui-apps/wf-sound-control-9999 )
		wf-osk? ( =gui-apps/wf-osk-9999 )
		elogind? ( >=sys-auth/elogind-239 )
		systemd? ( >=sys-apps/systemd-239 )
		"
BDEPEND="
		virtual/pkgconfig
		=dev-libs/wayland-protocols-9999
		"

if [[ ${PV} == 9999 ]]; then
	DEPEND+="=gui-libs/wlroots-9999[elogind=,systemd=,X]"
else
	DEPEND+=">=gui-libs/wlroots-0.6.0[elogind=,systemd=]"
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
