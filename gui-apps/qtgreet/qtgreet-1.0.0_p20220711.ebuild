# Copyright 2021 Aisha Tammy
# Copyright 2021 Ichika Zou
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="QT based greeter for greetd"
HOMEPAGE="https://gitlab.com/marcusbritanicus/QtGreet"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/marcusbritanicus/QtGreet"
else
	COMMIT=b40b7c8e22fb814950ea402c52e6f63c50e30343
	SRC_URI="https://gitlab.com/marcusbritanicus/QtGreet/-/archive/${COMMIT}/QtGreet-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/QtGreet-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/json-c
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwayland:5
	dev-qt/qtwidgets:5
	gui-libs/wayqt
"
RDEPEND="
	${DEPEND}
	gui-libs/greetd
"
