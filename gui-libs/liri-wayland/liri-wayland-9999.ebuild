EAPI=7

inherit cmake

DESCRIPTION="Liri wayland client and server extensions"
HOMEPAGE="https://github.com/lirios/wayland"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/wayland"
else
	COMMIT=ff9e88882a7da05b31713722f08e81d7b842c882
	SRC_URI="https://github.com/lirios/wayland/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/wayland-${COMMIT}
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtwayland:5
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/liri-cmake-shared
	dev-libs/wayland-protocols
	kde-frameworks/extra-cmake-modules
"
