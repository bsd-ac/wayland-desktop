# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

LUA_COMPAT=( lua5-3 )
inherit lua-single meson

DESCRIPTION="dynamic wayland compositor"
HOMEPAGE="https://github.com/taiwins/taiwins"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/taiwins/taiwins"
else
	SRC_URI="https://github.com/taiwins/taiwins/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc profile"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="${LUA_DEPS}
	dev-libs/libinput
	gnome-base/librsvg
	gui-libs/wlroots[X]
	media-libs/freetype
	sys-libs/pam
	virtual/opengl
	x11-libs/cairo
	x11-libs/libxcb[xkb]
	x11-libs/libxkbcommon:=[X]
	x11-libs/pixman
"
DEPEND="${RDEPEND}"
BDEPEND="
	${RDEPEND}
	>=dev-libs/wayland-protocols-1.14
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

src_prepare() {
	default
	grep --include="meson.build" -Rl "werror" "${S}" | \
		xargs -I{} sed -e "/werror/d" -i {} || die
}

src_configure() {
	lua_setup
	local emesonargs=(
		$(meson_use doc build-doc)
		$(meson_use profile enable-profiler)
	)
	meson_src_configure
}
