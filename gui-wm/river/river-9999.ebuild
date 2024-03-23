# Copyright 2021-2022 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

# NOTE: zig is weird it is doing the install during
#       the compile phase for some reason, so we
#       first do the install to a temporary directory

DESCRIPTION="Dynamic tiling wayland compositor"
HOMEPAGE="https://codeberg.org/river/river"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/river/river"
else
	SRC_URI="https://codeberg.org/river/river/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/wayland
	>=gui-libs/wlroots-0.17.0:0/17[X]
	x11-libs/cairo[X]
	x11-libs/libxkbcommon:=[X]
	x11-libs/pixman
"
DEPEND="${RDEPEND}"
BDEPEND="
	|| ( dev-lang/zig:0.11 dev-lang/zig-bin:0.11 )
	dev-libs/wayland-protocols
	virtual/pkgconfig
	app-text/scdoc
"

src_configure() {
	export zigoptions=(
		--verbose
		-Doptimize=ReleaseSafe
		-Dxwayland=true
		-Dman-pages=true
		"${EXTRA_ECONF[@]}"
	)
	export CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"
}

src_compile() {
	zig build "${zigoptions[@]}" --prefix "${T}/temp_install" || die
}

src_test() {
	zig build test "${zigoptions[@]}" --prefix "${T}/temp_install" || die
}

src_install() {
	zig build install "${zigoptions[@]}" --prefix "${ED}/usr" || die
	mkdir "${ED}"/usr/etc || die
	mv "${ED}"/usr/etc "${ED}" || die
}
