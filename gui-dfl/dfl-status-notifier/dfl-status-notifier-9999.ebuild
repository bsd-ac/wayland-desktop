# Copyright 2023 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="XDG Status Notification implementation for DFL project applications"
HOMEPAGE="https://gitlab.com/desktop-frameworks/status-notifier"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/desktop-frameworks/status-notifier"
else
	COMMIT="5212af79e026b7f2e8586350c613297cf7e098a1"
	SRC_URI="https://gitlab.com/desktop-frameworks/status-notifier/-/archive/${COMMIT}/status-notifier-${COMMIT}.tar.bz2 -> ${P}.tar.bz2"
	S="${WORKDIR}/status-notifier-${COMMIT}"
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
