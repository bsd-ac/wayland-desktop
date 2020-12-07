EAPI=7

inherit cmake

DESCRIPTION="Qt wrapper for GSettings for Liri"
HOMEPAGE="https://github.com/lirios/qtgsettings"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/qtgsettings"
else
	COMMIT=7215f4102072f4a242c05c0d197840df57f54b8b
	SRC_URI="https://github.com/lirios/qtgsettings/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/qtgsettings-${COMMIT}
	KEYWORDS="~amd64 ~arm64 ~x86"
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
