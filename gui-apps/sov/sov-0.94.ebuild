# SPDX-License-Identifier: GPL-2.0 or ISC
# Copyright 2024 Jason André Charles Gantner
# Distributed under the terms of the ISC License

EAPI=8

inherit meson optfeature

DESCRIPTION="Sway app that shows schemas for all workspaces to make navigation in sway easier"
HOMEPAGE="https://github.com/milgra/sov"
SRC_URI="https://github.com/milgra/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	media-libs/freetype
	media-libs/libglvnd
	media-libs/libpng
	x11-libs/libxkbcommon
	"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
	"

pkg_postinst(){
	optfeature "upstream recommends installing this font" media-fonts/terminus-font
}
