EAPI=7

inherit cmake

DESCRIPTION="Qt-style API for AccountsService DBus service"
HOMEPAGE="https://github.com/lirios/qtaccountsservice"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/qtaccountsservice"
else
	COMMIT=cc8bbdcb42feaa456bfef1aff1f1e67c2d67a786
	SRC_URI="https://github.com/lirios/qtaccountsservice/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/qtaccountsservice-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/glib
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/liri-cmake-shared
"
