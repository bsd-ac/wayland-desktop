# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="VNC server for wlroots based Wayland compositors"
HOMEPAGE="https://github.com/any1/wayvnc"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/any1/wayvnc"
else
	SRC_URI="https://github.com/any1/wayvnc/archive/v${PV} -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="doc"

RDEPEND="
	dev-libs/wayland
	x11-libs/pixman
	dev-libs/libuv
	media-libs/mesa:=[egl,gles2]
	x11-libs/libxkbcommon
"
BDEPEND="
	${RDEPEND}
	virtual/pkgconfig
	dev-libs/wayland-protocols
"

src_configure() {
	local emesonargs=(
		$(meson_feature doc man-pages)
	)
	meson_src_configure
}
