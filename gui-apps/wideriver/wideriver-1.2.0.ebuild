# Copyright 2023 Niklaus 'vimja' Hofer
# Distributed under the terms of the ISC License

EAPI=8
 
DESCRIPTION="Tiling window manager for the river wayland compositor"
HOMEPAGE="https://github.com/alex-courtis/wideriver"
SRC_URI="https://github.com/alex-courtis/wideriver/archive/refs/tags/${PV}.tar.gz"
 
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
 
RDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-libs/libinput
	gui-libs/wlroots
"
RDEPEND="${DEPEND}"
