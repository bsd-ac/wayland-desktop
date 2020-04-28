# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Simple, secure & standards compliant web I/O for the most demanding of applications"
HOMEPAGE="https://github.com/uNetworking/uSockets"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/uNetworking/uSockets.git"
else
	SRC_URI="https://github.com/uNetworking/uSockets/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="+ssl +libuv gcd debug"
DEPEND="ssl? ( >=dev-libs/openssl-1.1.0 )
	libuv? ( dev-libs/libuv )
	gcd? ( dev-libs/libdispatch )
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_configure() {
	local myeconfargs=(
		"$(use_with ssl openssl)" \
		"$(use_with libuv)" \
		"$(use_with gcd)" \
		"$(use_with debug asan)"
	)
	autotools-utils_src_configure
}
