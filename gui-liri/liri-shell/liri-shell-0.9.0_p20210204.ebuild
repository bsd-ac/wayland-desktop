# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="QtQuick and Wayland shell for convergence"
HOMEPAGE="https://github.com/lirios/shell"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/shell"
else
	COMMIT=ded359509328211e74346cdbfc6d67470b0fd872
	SRC_URI="https://github.com/lirios/shell/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/shell-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="systemd"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5[localstorage]
	dev-qt/qtgraphicaleffects:5
	dev-qt/linguist-tools:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtsvg:5
	dev-qt/qtwayland:5
	gnome-base/dconf
	gui-liri/libliri
	gui-liri/liri-eglfs
	gui-liri/liri-fluid
	gui-liri/liri-platformtheme
	gui-liri/liri-qml-xwayland
	gui-liri/liri-qtaccountsservice
	gui-liri/liri-qtgsettings
	gui-liri/liri-wayland
	kde-frameworks/solid:5
	sys-auth/polkit-qt
"
DEPEND="${RDEPEND}
	gui-liri/liri-cmake-shared
"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DLIRI_ENABLE_SYSTEMD=$(usex systemd)
	)
	cmake_src_configure
}
