# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit meson

DESCRIPTION="xdotool type for wayland"
HOMEPAGE="https://github.com/atx/wtype"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/atx/wtype"
else
	SRC_URI="https://github.com/atx/wtype/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="modules"

DEPEND="
	dev-libs/wayland
	x11-libs/libxkbcommon
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"
