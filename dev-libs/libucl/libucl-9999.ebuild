# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Universal configuration library parser"
HOMEPAGE="https://github.com/vstakhov/libucl"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vstakhov/libucl.git"
else
	SRC_URI="https://github.com/vstakhov/libucl/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD-2"
SLOT="0"

IUSE="lua luajit urlinclude urlsign "
REQUIRED_USE="luajit? ( lua )"

DEPEND="!!dev-libs/ucl
	lua? ( >=dev-lang/lua-5.1:= )
	luajit? ( dev-lang/luajit )
	urlinclude? ( net-misc/curl )
	urlsign? ( dev-libs/openssl:0 )
"
BDEPEND="${DEPEND}"
RDEPEND="${DEPEND}"

DOCS=( README.md doc/api.md )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconf=(
		$(cmake_use_enable lua)
		$(cmake_use_enable luajit)
		$(cmake_use_enable urlinclude url_include)
		$(cmake_use_enable urlsign url_sign )
	)
	cmake_src_configure
}

src_install() {
	default
	use lua && DOCS+=( doc/lua_api.md )
	einstalldocs
	# no .a's it seems
	use static-libs || find "${ED}" -name "*.la" -delete
}
