# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

LUA_COMPAT=( lua5-{1..3} luajit )
inherit lua-single meson

DESCRIPTION="fully programmable wayland compositor"
HOMEPAGE="https://github.com/buffet/kiwmi"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/buffet/kiwmi"
else
	COMMIT=86e0f5b3fa9de1fa1ff58c431b32dbe48c5d3df8
	SRC_URI="https://github.com/buffet/kiwmi/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MPL-2.0"
SLOT="0"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	${LUA_DEPS}
	dev-libs/libinput
	dev-libs/wayland
	gui-libs/wlroots:=[X]
	x11-libs/libxkbcommon:=[X]
	x11-libs/pixman
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-libs/wayland-protocols-1.14
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

src_configure() {
	lua-single_pkg_setup
	local emesonargs=(
		-Dlua-pkg="${LUA##*/}"
	)
	meson_src_configure
}
