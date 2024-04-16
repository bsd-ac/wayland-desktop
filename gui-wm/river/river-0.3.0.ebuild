# Copyright 2021-2022 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit edo

DESCRIPTION="Dynamic tiling wayland compositor"
HOMEPAGE="https://codeberg.org/river/river"

SRC_URI="https://codeberg.org/river/river/releases/download/v${PV}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="+man pie test +X"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/wayland
	=gui-libs/wlroots-0.17*:=[X?]
	x11-libs/libxkbcommon:=[X?]
	x11-libs/pixman
"
DEPEND="${RDEPEND}"
EZIG_VISION="0.11*"
BDEPEND="
	|| ( =dev-lang/zig-${EZIG_VISION} =dev-lang/zig-bin-${EZIG_VISION} )
	dev-libs/wayland-protocols
	man? ( app-text/scdoc )
	virtual/pkgconfig
"

QA_FLAGS_IGNORED="usr/bin/river(ctl|tile)?"

# : refer to sys-fs/ncdu :
zig-set_EZIG() {
	[[ -n ${EZIG} ]] && return

	grep_version=$(echo ${EZIG_VISION} | sed -E 's/\./\\./g; s/\*/.*/g')
	EZIG=$(compgen -c | grep 'zig.*-'$grep_version | head -n 1) || die
}

ezig() {
	zig-set_EZIG
	edo "${EZIG}" "${@}"
}

src_compile() {
	local zigoptions=(
		--verbose
		-Doptimize=ReleaseSafe
		-Dman-pages=$(usex man true false)
		-Dpie=$(usex pie true false)
		-Dxwayland=$(usex X true false)
		${ZIG_FLAGS[@]}
	)

	DESTDIR="${T}" ezig build "${zigoptions[@]}" --prefix /usr || die
}

src_test() {
	ezig build test || die
}

src_install() {
	cp -a "${T}"/usr "${ED}"/usr || die

	dodoc -r README.md example || die
}
