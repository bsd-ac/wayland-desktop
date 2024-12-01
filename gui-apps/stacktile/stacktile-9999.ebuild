# Copyright 2023 Niklaus 'vimja' Hofer
# Distributed under the terms of the ISC License

EAPI=8

inherit git-r3 edo

DESCRIPTION="stacktile is a layout generator for the river Wayland compositor."
HOMEPAGE="https://git.sr.ht/~leon_plickat/stacktile"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPLv3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
"
DEPEND="${RDEPEND}"

EZIG_VISION="0.13*"

BDEPEND="
	|| ( =dev-lang/zig-${EZIG_VISION} =dev-lang/zig-bin-${EZIG_VISION} )
	dev-util/wayland-scanner
"

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
		${ZIG_FLAGS[@]}
	)

	DESTDIR="${T}" ezig build "${zigoptions[@]}" --prefix /usr || die
}

src_test() {
	ezig build test || die
}

src_install() {
	dobin ${T}/usr/bin/${PN}
	doman ${T}/usr/share/man/man1/${PN}.1
}
