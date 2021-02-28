# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="QtQuick and Wayland shell for convergence"
HOMEPAGE="https://github.com/lirios/xdg-desktop-portal-liri"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/xdg-desktop-portal-liri"
else
	COMMIT=22ebac8f7f760071d7e1c4f39cf0707d5ab48929
	SRC_URI="https://github.com/lirios/xdg-desktop-portal-liri/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/xdg-desktop-portal-liri-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="pipewire systemd"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtdeclarative:5[localstorage]
	dev-qt/qtquickcontrols2:5
	dev-qt/qtwayland:5
	gnome-base/dconf
	gui-liri/libliri
	gui-liri/liri-platformtheme
	gui-liri/liri-qml-xwayland
	gui-liri/liri-qtaccountsservice
	gui-liri/liri-qtgsettings
	gui-liri/liri-wayland
	kde-frameworks/solid:5
	sys-auth/polkit-qt
	pipewire? (
		media-video/pipewire
		x11-libs/libdrm
	)
"
DEPEND="${RDEPEND}
	gui-liri/liri-cmake-shared
"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}"/${PN}-0-optional_pipewire.patch )

src_configure() {
	local mycmakeargs=(
		-DLIRI_ENABLE_PIPEWIRE=$(usex pipewire)
		-DLIRI_ENABLE_SYSTEMD=$(usex systemd)
	)
	cmake_src_configure
}
