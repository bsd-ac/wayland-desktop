EAPI=7

inherit cmake xdg-utils

DESCRIPTION="Liri library for QtQuick apps with Material Design"
HOMEPAGE="https://github.com/lirios/fluid"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/fluid"
else
	COMMIT=1bb3ad879611b50c22cb9933dcff02243e5992d3
	SRC_URI="https://github.com/lirios/fluid/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/fluid-${COMMIT}
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
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/liri-cmake-shared
	dev-libs/wayland-protocols
	kde-frameworks/extra-cmake-modules
"

src_configure() {
	mycmakeargs=(
		-DFLUID_USE_SYSTEM_LCS:BOOL=ON
		-DFLUID_WITH_DOCUMENTATION:BOOL=OFF
		-DFLUID_WITH_DEMO:BOOL=ON
		-DFLUID_WITH_QML_MODULES:BOOL=ON
		-DFLUID_INSTALL_ICONS:BOOL=OFF
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
