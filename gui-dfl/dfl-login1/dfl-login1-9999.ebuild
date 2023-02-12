# Copyright 2022 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="systemd/elogin functionality for DFL"
HOMEPAGE="https://gitlab.com/desktop-frameworks/login1"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/desktop-frameworks/login1"
else
	COMMIT="2f8335a98c3052517235303441147a1db295b609"
	SRC_URI="https://gitlab.com/desktop-frameworks/login1/-/archive/${COMMIT}/login1-${COMMIT}.tar.bz2 -> ${P}.tar.bz2"
	S="${WORKDIR}/login1-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+qt5 qt6"
REQUIRED_USE="^^ ( qt5 qt6 )"

DEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
	)
	qt6? (
		dev-qt/qtbase:6[dbus]
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
