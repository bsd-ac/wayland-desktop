# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="minimalistic commanline pastebin"
HOMEPAGE="https://bsd.ac"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PurritoBin/PurritoBin.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/PurritoBin/PurritoBin/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
	S="${WORKDIR}/PurritoBin-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="libuv static-libs"

DEPEND="dev-cpp/usockets:=[libuv?,static-libs?]
	dev-cpp/uwebsockets
	libuv? ( >=dev-libs/libuv-1.35.0[static-libs?] )
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s:.ifdef:ifdef:g" \
		   -e "s:.else:else:g" \
		   -e "s:.endif:endif:g" \
		   Makefile
	default
}

src_compile() {
	emake $(usex libuv -DUSE_DLIBUV '') \
		  $(usex static-libs -DUSE_STATIC '') \
		  all
}

src_install() {
	emake prefix="/usr" \
		  DESTDIR="${D}" \
		  $(usex libuv -DUSE_LIBUV '') \
		  $(usex static-libs -DUSE_STATIC '') \
		  install
	einstalldocs
}
