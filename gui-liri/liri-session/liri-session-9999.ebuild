# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="QtQuick and Wayland shell for convergence"
HOMEPAGE="https://github.com/lirios/shell"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/session"
else
	COMMIT=ded359509328211e74346cdbfc6d67470b0fd872
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
	cmake_src_configure
}
