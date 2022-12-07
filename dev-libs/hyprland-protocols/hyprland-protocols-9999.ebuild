# Copyright 2022 Julien Roy <julien@jroy.ca>
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="Wayland protocol extensions for Hyprland"
HOMEPAGE="https://github.com/hyprwm/hyprland-protocols"

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/hyprwm/${PN}.git/"
	inherit git-r3
else
	SRC_URI="https://github.com/hyprwm/${PN}/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD"
SLOT="0"
IUSE=""
RESTRICT=""

DEPEND=""
RDEPEND=""
BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"
