# Copyright 2023 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="DesQ library for UI elements"

HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/libdesqui"
else
	SRC_URI="https://gitlab.com/DesQ/libdesqui/-/archive/v${PV}/libdesqui-v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/libdesqui-v${PV}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+qt5 qt6"
REQUIRED_USE="^^ ( qt5 qt6 )"

DEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5[wayland,X]
		dev-qt/qtwidgets:5[X]
	)
	qt6? (
		dev-qt/qtbase:6[dbus,gui,X]
	)
	gui-desq/libdesq[qt5?,qt6?]
	gui-dfl/dfl-layouts[qt5?,qt6?]
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		"-Duse_qt_version=$(usex qt5 qt5 qt6)"
	)
	meson_src_configure
}
