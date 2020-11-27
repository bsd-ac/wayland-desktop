
EAPI=7

inherit cmake

DESCRIPTION="lightweight immediate mode GUI for love games"
HOMEPAGE="https://github.com/keharriso/love-nuklear"

SRC_URI="https://github.com/keharriso/love-nuklear/archive/v${PV}.tar.gz -> ${P}.tar.gz"

# C89 and ANSI C library
KEYWORDS="~amd64 ~x86"
LICENSE="MIT Unlicense"
SLOT="0"
IUSE="doc +extras"

RDEPEND="dev-lang/luajit"
DEPEND="${RDEPEND}
	gui-libs/nuklear:=
"

PATCHES=( "${FILESDIR}"/${PN}-2.6.1-nuklear.patch )
