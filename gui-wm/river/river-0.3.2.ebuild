# Copyright 2021-2022 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit edo

DESCRIPTION="Dynamic tiling wayland compositor"
HOMEPAGE="https://codeberg.org/river/river"

_zig_global_cache_dir="${WORKDIR}/.zig-global-cache/p"

SRC_URI="
	https://codeberg.org/river/river/releases/download/v${PV}/${P}.tar.gz
	https://codeberg.org/ifreund/zig-pixman/archive/v0.1.0.tar.gz -> zig-pixman.tar.gz
	https://codeberg.org/ifreund/zig-wayland/archive/v0.1.0.tar.gz -> zig-wayland.tar.gz
	https://codeberg.org/ifreund/zig-wlroots/archive/v0.17.0.tar.gz -> zig-wlroots.tar.gz
	https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.1.0.tar.gz -> zig-xkbcommon.tar.gz
"
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
EZIG_VISION="0.12*"
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

src_prepare() {
	default
	mkdir -p "${_zig_global_cache_dir}" || die

	declare -A pkgs=(
		["zig-pixman"]="122014eeb4600a059bdcfe1c864862f17e6d5e4237e3bb7d6818f2a5583f6f4eb843"
		["zig-wayland"]="1220b0f8f822c1625af7aae4cb3ab2c4ec1a4c0e99ef32867b2a8d88bb070b3e7f6d"
		["zig-wlroots"]="1220714d1cc39c3abb1d9c22a0b838d847ead099cb7d9931821490483f30c022e827"
		["zig-xkbcommon"]="1220840390382c88caf9b0887f6cebbba3a7d05960b8b2ee6d80567b2950b71e5017"
	)

	for p in "${!pkgs[@]}"; do
		mv "../${p}" "${_zig_global_cache_dir}/${pkgs[$p]}" || die
	done
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

	DESTDIR="${T}" ezig build "${zigoptions[@]}" --system "${_zig_global_cache_dir}" --prefix /usr || die
}

src_test() {
	ezig build --system "${_zig_global_cache_dir}" test || die
}

src_install() {
	cp -a "${T}"/usr "${ED}"/usr || die

	dodoc -r README.md example || die
}
