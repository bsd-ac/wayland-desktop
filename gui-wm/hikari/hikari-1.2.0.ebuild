# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="wayland compositor inspired by CWM"
HOMEPAGE="https://hikari.acmelabs.space/"

SRC_URI="https://hikari.acmelabs.space/releases/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE="gamma layershell screencopy X"

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
		x11-misc/xkeyboard-config
"

BDEPEND="
		${DEPEND}
		>=dev-libs/wayland-protocols-1.14
		virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/patch-gnu-make.patch"
)

src_compile() {
	emake WITH_POSIX_C_SOURCE=1 \
		  WITH_GAMMACONTROL=$(usex gamma 1 0) \
		  WITH_LAYERSHELL=$(usex layershell 1 0) \
		  WITH_SCREENCOPY=$(usex screencopy 1 0) \
		  WITH_XWAYLAND=$(usex X 1 0) \
		  all
}

src_install() {
	emake PREFIX=${D}/usr ETC_PREFIX=${D}/etc install
}
