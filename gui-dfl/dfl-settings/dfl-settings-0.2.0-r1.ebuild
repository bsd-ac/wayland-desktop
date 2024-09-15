# Copyright 2023 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="QSettings wrapper for DFL project applications"
HOMEPAGE="https://gitlab.com/desktop-frameworks/settings"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/desktop-frameworks/settings"
else
	SRC_URI="https://gitlab.com/desktop-frameworks/settings/-/archive/v${PV}/settings-v${PV}.tar.bz2 -> ${P}.tar.bz2"
	S="${WORKDIR}/settings-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="qt5 +qt6"
REQUIRED_USE="^^ ( qt5 qt6 )"

DEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
	)
	qt6? (
		dev-qt/qtbase:6[gui]
	)
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		"-Duse_qt_version=$(usex qt5 qt5 qt6)"
	)
	meson_src_configure
}
