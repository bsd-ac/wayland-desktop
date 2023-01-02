# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit ecm

DESCRIPTION="QtQuick and Wayland shell for convergence"
HOMEPAGE="https://github.com/lirios/shell"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/session"
else
	COMMIT=bfae9be74ba57dc3e9c8467799e3b94a1ed3ae0d
	SRC_URI="https://github.com/lirios/session/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/session-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="systemd"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/linguist-tools:5
	gui-liri/libliri
	gui-liri/liri-qtgsettings
	gui-liri/liri-shell[systemd=]
"
DEPEND="${RDEPEND}
	gui-liri/liri-cmake-shared
"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}"/${PN}-0-systemd.patch )

src_configure() {
	local mycmakeargs=(
		-DLIRI_ENABLE_SYSTEMD=$(usex systemd)
	)
	ecm_src_configure
}
