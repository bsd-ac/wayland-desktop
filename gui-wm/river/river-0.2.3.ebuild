# Copyright 2021-2022 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="Dynamic tiling wayland compositor"
HOMEPAGE="https://github.com/riverwm/river"

SRC_URI="https://github.com/riverwm/river/releases/download/v${PV}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="+man pie test +X"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/wayland
	>=gui-libs/wlroots-0.16.0:=[X?]
	x11-libs/libxkbcommon:=[X?]
	x11-libs/pixman
"
DEPEND="${RDEPEND}"
BDEPEND="
	|| ( dev-lang/zig:0.10 dev-lang/zig-bin:0.10 )
	dev-libs/wayland-protocols
	man? ( app-text/scdoc )
	virtual/pkgconfig
"

QA_FLAGS_IGNORED="usr/bin/river(ctl|tile)?"

src_compile() {
	local zigoptions=(
		--verbose
		-Drelease-safe
		-Dman-pages=$(usex man true false)
		-Dpie=$(usex pie true false)
		-Dxwayland=$(usex X true false)
		${ZIG_FLAGS[@]}
	)

	DESTDIR="${T}" zig build "${zigoptions[@]}" --prefix /usr || die
}

src_test() {
	zig build test || die
}

src_install() {
	cp -r "${T}"/usr "${ED}"/usr || die

	dodoc -r README.md example || die
}
