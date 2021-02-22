# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit ecm

DESCRIPTION="shared cmake configuration utils for liri"
HOMEPAGE="https://github.com/lirios/cmake-shared"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/qml-xwayland"
else
	COMMIT=f33df7385d1bb099a1b3e7eeceaa7f9dc55d3ad8
	SRC_URI="https://github.com/lirios/qml-xwayland/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/qml-xwayland-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtwayland:5
	x11-libs/xcb-util-cursor
"
DEPEND="${RDEPEND}
	gui-liri/liri-cmake-shared
"
