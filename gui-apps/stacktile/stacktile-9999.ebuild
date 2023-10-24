# Copyright 2023 Niklaus 'vimja' Hofer
# Distributed under the terms of the ISC License

EAPI=8

inherit git-r3

DESCRIPTION="stacktile is a layout generator for the river Wayland compositor."
HOMEPAGE="https://git.sr.ht/~leon_plickat/stacktile"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPLv3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

KEYWORDS="~amd64"

RDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
"
DEPEND="${RDEPEND}"
BDEPEND="
	|| ( >=dev-lang/zig-0.10.0 >=dev-lang/zig-bin-0.10.0 )
	dev-util/wayland-scanner
"

src_compile() {
	local zigoptions=(
		--verbose
		-Drelease-safe
		${ZIG_FLAGS[@]}
	)

	DESTDIR="${T}" zig build "${zigoptions[@]}" --prefix /usr || die
}

src_test() {
	zig build test || die
}

src_install() {
	dobin ${T}/usr/bin/${PN}
	doman ${T}/usr/share/man/man1/${PN}.1
}
