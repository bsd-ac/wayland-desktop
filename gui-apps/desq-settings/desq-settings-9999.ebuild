
EAPI=7

inherit qmake-utils

DESCRIPTION="main user interface shell for DesQ"

HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/DesQUtils/SettingsDaemon"
else
	COMMIT=5f0b22059106685078f18cfcff4ab1bb9e60e488
	SRC_URI="https://gitlab.com/DesQ/DesQUtils/SettingsDaemon/-/archive/${COMMIT}/SettingsDaemon-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/SettingsDaemon-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/libdbusmenu-qt
	dev-qt/qtcore:5
	dev-qt/qtgui:5
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_compile() {
	eqmake5 daemon.pro
	emake
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
}
