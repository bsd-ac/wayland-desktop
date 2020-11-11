# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="main user interface shell for DesQ"

HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/Shell"
else
	COMMIT=29820a7f4723df9933aa6752704f1574ee1a9406
	SRC_URI="https://gitlab.com/DesQ/Shell/-/archive/${COMMIT}/Shell-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/Shell-${COMMIT}
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/libdbusmenu-qt
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtsvg:5
	gui-libs/libdesq:=
	gui-libs/libdesqwl:=
	gui-libs/libdesqui:=
"
RDEPEND="${DEPEND}
	x11-misc/qt5ct
"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}"/${P}-build.patch )

src_compile() {
	eqmake5 SNI_sub.pro
	emake
	eqmake5 Shell.pro
	emake
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
}
