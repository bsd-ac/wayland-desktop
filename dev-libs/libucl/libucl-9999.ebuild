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

IUSE="lua +regex signatures static-libs urlfetch utils"
DEPEND="!!dev-libs/ucl
	lua? ( >=dev-lang/lua-5.1:= )
	signatures? ( dev-libs/openssl:0 )
	urlfetch? ( net-misc/curl )"
RDEPEND="${DEPEND}"

DOCS=( README.md doc/api.md )

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure() {
	local myeconf=""
	use urlfetch && myeconf="--with-urls"
	econf \
		$(use_enable lua) \
		$(use_enable regex) \
		$(use_enable signatures) \
		$(use_enable utils) \
		${myeconf}
}

src_install() {
	default
	use lua && DOCS+=( doc/lua_api.md )
	# no .a's it seems
	use static-libs || find "${ED}" -name "*.la" -delete
}
