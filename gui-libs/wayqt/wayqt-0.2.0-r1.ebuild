# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="Qt-based wrapper for various wayland protocols"
HOMEPAGE="https://gitlab.com/desktop-frameworks/wayqt"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/desktop-frameworks/wayqt"
else
	SRC_URI="https://gitlab.com/desktop-frameworks/wayqt/-/archive/v${PV}/wayqt-v${PV}.tar.bz2 -> ${P}.tar.bz2"
	S="${WORKDIR}/wayqt-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT Unlicense"
SLOT="0"
IUSE="qt5 +qt6"
REQUIRED_USE="^^ ( qt5 qt6 )"

DEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtwayland:5
		dev-qt/qtwidgets:5
	)
	qt6? (
		dev-qt/qtbase:6=[dbus,gui,widgets]
		dev-qt/qtwayland:6
	)
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	dev-libs/wayland-protocols
	dev-qt/linguist-tools:5
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		"-Duse_qt_version=$(usex qt5 qt5 qt6)"
	)
	meson_src_configure
}
