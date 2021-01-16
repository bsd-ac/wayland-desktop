EAPI=7

inherit cmake

DESCRIPTION="Liri core library"
HOMEPAGE="https://github.com/lirios/libliri"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/libliri"
else
	COMMIT=6e47eb9030575a7c6eee0310bb64a935ae320757
	SRC_URI="https://github.com/lirios/libliri/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${COMMIT}
	KEYWORDS="~amd64"
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
BDEPEND="
	dev-libs/wayland-protocols
"
