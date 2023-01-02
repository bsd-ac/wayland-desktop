# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit ecm

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
# needs to be installed to test
RESTRICT="test"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtsvg:5
	dev-qt/qtwayland:5
"
DEPEND="${RDEPEND}
	gui-liri/liri-cmake-shared
	dev-libs/wayland
"
BDEPEND="
	dev-libs/wayland-protocols
"

src_configure() {
	mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DFLUID_USE_SYSTEM_LCS:BOOL=ON
		-DFLUID_WITH_DEMO:BOOL=ON
		-DFLUID_WITH_QML_MODULES:BOOL=ON
		-DFLUID_INSTALL_ICONS:BOOL=ON
		-DFLUID_WITH_DOCUMENTATION:BOOL=OFF
	)
	ecm_src_configure
}
