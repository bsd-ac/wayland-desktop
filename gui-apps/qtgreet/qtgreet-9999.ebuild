# Copyright 2021-2023 Aisha Tammy
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
	COMMIT="6234ab0920cb7e9a4baefc9da2ee32c21a2d04c1"
	SRC_URI="https://gitlab.com/marcusbritanicus/QtGreet/-/archive/${COMMIT}/QtGreet-${COMMIT}.tar.bz2 -> ${P}.tar.bz2"
	S="${WORKDIR}"/QtGreet-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+qt5 qt6"
REQUIRED_USE="^^ ( qt5 qt6 )"

CDEPEND="
	dev-libs/json-c
	dev-libs/wayland
	>=gui-libs/wlroots-0.16.0:0/16
	x11-libs/libxkbcommon:=
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtwayland:5
		dev-qt/qtwidgets:5
		gui-dfl/dfl-applications:=[qt5]
		gui-dfl/dfl-ipc:=[qt5]
		gui-dfl/dfl-login1:=[qt5]
		gui-dfl/dfl-utils:=[qt5]
		gui-libs/wayqt:=[qt5]
	)
	qt6? (
		dev-qt/qtbase:6=[dbus,gui,widgets]
		dev-qt/qtwayland:6
		gui-dfl/dfl-applications:=[qt6]
		gui-dfl/dfl-ipc:=[qt6]
		gui-dfl/dfl-login1:=[qt6]
		gui-dfl/dfl-utils:=[qt6]
		gui-libs/wayqt:=[qt6]
	)
"
DEPEND="
	dev-libs/wayland-protocols
	${CDEPEND}
"
RDEPEND="
	${CDEPEND}
	gui-libs/greetd
"
BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		"-Duse_qt_version=$(usex qt5 qt5 qt6)"
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	keepdir "/var/lib/qtgreet"
}
