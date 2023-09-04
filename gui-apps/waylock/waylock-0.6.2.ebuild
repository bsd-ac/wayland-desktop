# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the ISC License

EAPI=8

inherit edo

DESCRIPTION="Small screenlocker for Wayland compositors"
HOMEPAGE="https://github.com/ifreund/waylock"

SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="ISC"
SLOT="0"
IUSE="+man pie test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/wayland
	sys-libs/pam
	x11-libs/libxkbcommon:=
"
DEPEND="${RDEPEND}"
EZIG_VISION="0.10*"
BDEPEND="
	|| ( =dev-lang/zig-${EZIG_VISION} =dev-lang/zig-bin-${EZIG_VISION} )
	dev-libs/wayland-protocols
	virtual/pkgconfig
	man? ( app-text/scdoc )
"

QA_FLAGS_IGNORED="usr/bin/waylock"

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
		-Drelease-safe
		-Dman-pages=$(usex man true false)
		-Dpie=$(usex pie true false)
		${ZIG_FLAGS[@]}
	)

	DESTDIR="${T}" ezig build "${zigoptions[@]}" --prefix /usr || die
}

src_test() {
	ezig build test || die
}

src_install() {
	cp -r "${T}"/{etc,usr} "${ED}"/ || die

	dodoc README.md || die
}
