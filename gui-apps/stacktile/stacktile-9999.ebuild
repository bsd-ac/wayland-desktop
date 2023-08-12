# Copyright 2023 Niklaus 'vimja' Hofer
# Distributed under the terms of the ISC License

EAPI=8

inherit git-r3

DESCRIPTION="Small screenlocker for Wayland compositors"
HOMEPAGE="https://git.sr.ht/~leon_plickat/stacktile"
EGIT_REPO_URI="${HOMEPAGE}"
#SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

#S="${WORKDIR}"/${PN}-v${PV}

LICENSE="GPLv3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

KEYWORDS="~arm64 ~amd64"

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
	cp -r "${T}"/usr "${ED}"/ || die
}
