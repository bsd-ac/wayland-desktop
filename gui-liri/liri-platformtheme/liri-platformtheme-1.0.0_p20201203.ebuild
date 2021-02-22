# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="QtQuick and Wayland shell for convergence"
HOMEPAGE="https://github.com/lirios/shell"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/platformtheme"
else
	COMMIT=3d74bbce60abf9ce918029ae51259e5efeba963d
	SRC_URI="https://github.com/lirios/platformtheme/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/platformtheme-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtquickcontrols2:5[widgets]
	dev-qt/qtwayland:5
	gui-liri/liri-qtgsettings
	gui-liri/liri-wayland
"
DEPEND="${RDEPEND}
	gui-liri/liri-cmake-shared
"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"
