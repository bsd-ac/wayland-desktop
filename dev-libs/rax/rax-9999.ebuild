# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit toolchain-funcs

DESCRIPTION="radix tree implementation in ANSI C"
HOMEPAGE="https://github.com/antirez/rax"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/antirez/rax"
else
	COMMIT="23f31ca89c669841a4dc9dda73fe09aa6f014f28"
	SRC_URI="https://github.com/antirez/rax/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}"/${PN}-1.2-Makefile.patch )

src_configure() {
	tc-export CC
	export LIBDIR="/usr/$(get_libdir)"
}
