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
	COMMIT=309ccd2faf08079e698104b19eff32b3a255b947
	SRC_URI="https://github.com/wizbright/waybox/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/waybox-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=gui-libs/wlroots-0.13.0
	x11-libs/libxkbcommon:=[X]
"

BDEPEND="
	${RDEPEND}
	>=dev-libs/wayland-protocols-1.14
	virtual/pkgconfig
"
