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
IUSE="libuv"

DEPEND=">=dev-cpp/usockets:=[libuv?,static-libs]
	>=dev-cpp/uwebsockets
	libuv? ( >=dev-libs/libuv-1.35.0 )
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_compile() {
	emake WITH_LIBUV=$(usex libuv 1 0)\
		  all
}

src_install() {
	emake prefix="/usr" \
		  DESTDIR="${D}" \
		  WITH_LIBUV=$(usex libuv 1 0) \
		  install
	einstalldocs
}
