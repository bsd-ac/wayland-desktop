# Copyright 2021 Aisha Tammy
# Copyright 2021 Ichika Omamori
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="QT based greeter for greetd"
HOMEPAGE="https://gitlab.com/marcusbritanicus/QtGreet"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/marcusbritanicus/QtGreet"
else
	SRC_URI="https://gitlab.com/marcusbritanicus/QtGreet/-/archive/v${PV}/QtGreet-v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/QtGreet-v${PV}
	KEYWORDS="~amd64"
fi

CMAKE_USE_DIR="${S}"/src

LICENSE="GPL-3"
SLOT="0"

CDEPEND="
	dev-libs/json-c
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwayland:5
	dev-qt/qtwidgets:5
	gui-libs/wlroots
"
DEPEND="${CDEPEND}
	kde-frameworks/extra-cmake-modules
"
RDEPEND="
	${CDEPEND}
	gui-libs/greetd
"
