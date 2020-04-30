# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit eutils

DESCRIPTION="wayland compositor inspired by CWM"
HOMEPAGE="https://hikari.acmelabs.space/"

if [[ ${PV} == 9999 ]]; then
	inherit darcs
	EDARCS_REPOSITORY="https://hub.darcs.net/raichoo/${PN}"
else
	SRC_URI="https://hikari.acmelabs.space/releases/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="elogind systemd"

DEPEND="
		dev-libs/glib
		dev-libs/libevdev
		dev-libs/libinput
		dev-libs/libucl
		media-libs/glm
		media-libs/mesa:=[gles2,wayland,X]
		media-libs/libjpeg-turbo
		media-libs/libpng
		media-libs/freetype:=[X]
		x11-libs/libdrm
		x11-libs/gtk+:3=[wayland,X]
		x11-libs/cairo:=[X,svg]
		x11-libs/libxkbcommon:=[X]
		x11-libs/pango:=[X]
		x11-libs/pixman
		gui-libs/gtk-layer-shell
		gui-libs/wlroots
"

RDEPEND="
		${DEPEND}
		elogind? ( sys-auth/elogind )
		systemd? ( sys-apps/systemd )
		x11-misc/xkeyboard-config
"

BDEPEND="
		${DEPEND}
	sys-devel/bmake
		virtual/pkgconfig
		>=dev-libs/wayland-protocols-1.14
"

src_compile() {
	bmake CFLAGS="${CFLAGS} -I/usr/include" WITH_POSIX_C_SOURCE=YES
}

src_install() {
  bmake CFLAGS="${CFLAGS} -I/usr/include" PREFIX=${D}/usr ETC_PREFIX=${D}/etc install
}

pkg_preinst() {
	#if ! use systemd && ! use elogind; then
		fowners root:0 /usr/bin/hikari{,-unlocker}
		fperms 4511 /usr/bin/hikari{,-unlocker}
	#fi
}
