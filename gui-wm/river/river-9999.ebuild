# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

DESCRIPTION="Openbox alternative for wayland"
HOMEPAGE="https://github.com/johanmalm/labwc"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ifreund/river"
else
	COMMIT=26b0acddb7c56311b9d476c059d1e9af9d27dfbf
	SRC_URI="https://github.com/ifreund/river/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc +X"

RDEPEND="
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/wayland
	gui-libs/wlroots[X]
	x11-libs/cairo[X]
	x11-libs/libxkbcommon:=[X]
	x11-libs/pixman
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lang/zig-0.7.1
	dev-libs/wayland-protocols
	virtual/pkgconfig
	doc? ( app-text/scdoc )
"

src_compile() {
	local -x CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"
	zig build -Drelease-safe || die
}

src_install() {
	zig --prefix="${ED}/usr" install || die
}
