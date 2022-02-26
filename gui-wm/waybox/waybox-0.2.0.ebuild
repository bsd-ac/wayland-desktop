# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

DESCRIPTION="openbox clone on wayland"
HOMEPAGE="https://github.com/wizbright/waybox"

inherit meson

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/wizbright/waybox.git"
else
	SRC_URI="https://github.com/wizbright/waybox/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=gui-libs/wlroots-0.15.0
	x11-libs/libxkbcommon:=[X]
"
DEPEND="${RDEPEND}"
BDEPEND="
	${RDEPEND}
	>=dev-libs/wayland-protocols-1.14
	virtual/pkgconfig
"
