
EAPI=7

inherit cmake

DESCRIPTION="lightweight immediate mode GUI for love games"
HOMEPAGE="https://github.com/keharriso/love-nuklear"

SRC_URI="https://github.com/keharriso/love-nuklear/archive/v${PV}.tar.gz -> ${P}.tar.gz"

# C89 and ANSI C library
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
LICENSE="MIT Unlicense"
SLOT="0"
IUSE="doc +extras"

RDEPEND="dev-lang/luajit"
DEPEND="${RDEPEND}
	gui-libs/nuklear:=
"

PATCHES=( "${FILESDIR}"/${PN}-2.6.1-nuklear.patch )
