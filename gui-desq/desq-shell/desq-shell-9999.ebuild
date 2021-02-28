# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="main user interface shell for DesQ"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/Shell"
else
	COMMIT=3e3c2dab8f89bc4ce9dcd8845ce3fc526e83b027
	SRC_URI="https://gitlab.com/DesQ/Shell/-/archive/${COMMIT}/Shell-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/Shell-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/libdbusmenu-qt
	dev-qt/qtcore:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtsvg:5
	gui-desq/libdesq
	gui-desq/libdesqwl
	gui-desq/libdesqui
"
RDEPEND="${DEPEND}
	gui-wm/wayfire
	x11-misc/qt5ct
"
