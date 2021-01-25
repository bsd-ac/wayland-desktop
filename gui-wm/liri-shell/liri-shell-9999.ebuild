EAPI=7

inherit cmake

DESCRIPTION="QtQuick and Wayland shell for convergence"
HOMEPAGE="https://github.com/lirios/shell"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/shell"
else
	COMMIT=b12ce290305abda2cc06994109902f45dc23d177
	SRC_URI="https://github.com/lirios/shell/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/shell-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	dev-libs/qtgsettings
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtsvg:5
	dev-qt/qtwayland:5
	gui-libs/libliri
	gui-libs/liri-fluid
	gui-libs/liri-wayland
	kde-frameworks/solid:5
	sys-auth/polkit-qt
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"
