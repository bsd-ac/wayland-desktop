# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the ISC License

EAPI=8

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
BDEPEND="
	|| ( >=dev-lang/zig-0.10.0 >=dev-lang/zig-bin-0.10.0 )
	dev-libs/wayland-protocols
	virtual/pkgconfig
	man? ( app-text/scdoc )
"

QA_FLAGS_IGNORED="usr/bin/waylock"

src_compile() {
	local zigoptions=(
		--verbose
		-Drelease-safe
		-Dman-pages=$(usex man true false)
		-Dpie=$(usex pie true false)
		${ZIG_FLAGS[@]}
	)

	DESTDIR="${T}" zig build "${zigoptions[@]}" --prefix /usr || die
}

src_test() {
	zig build test || die
}

src_install() {
	cp -r "${T}"/{etc,usr} "${ED}"/ || die

	dodoc README.md || die
}
