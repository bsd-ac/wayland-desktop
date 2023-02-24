# Copyright 2023 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit meson xdg

DESCRIPTION="Awesome Desktop Environment built on top of Qt/Wayland and Wayfire"
HOMEPAGE="https://gitlab.com/cubocore/paper/paperde"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/paper/paperde.git"
else
	COMMIT="d206d46dd826bfe71185e5fc2255cfb6fafa28f0"
	SRC_URI="https://gitlab.com/cubocore/paper/paperde/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.bz2 -> ${P}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/libdbusmenu-qt
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-qt/designer:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5[X]
	gui-dfl/dfl-applications[qt5]
	gui-dfl/dfl-ipc[qt5]
	gui-dfl/dfl-login1[qt5]
	gui-dfl/dfl-settings[qt5]
	gui-dfl/dfl-status-notifier[qt5]
	gui-libs/libcprime
	gui-libs/libcsys
	gui-libs/wayqt[qt5]
"
RDEPEND="
	${DEPEND}
	gui-wm/wayfire[X]
	x11-misc/qt5ct
	|| (
		gui-libs/xdg-desktop-portal-wlr
		sys-apps/xdg-desktop-portal
		kde-plasma/xdg-desktop-portal-kde
		sys-apps/xdg-desktop-portal-gtk
	)
"
