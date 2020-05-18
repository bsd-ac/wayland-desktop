# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="wayland kiosk"
HOMEPAGE="https://www.hjdskes.nl/projects/cage/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Hjdskes/cage"
else
	SRC_URI="https://github.com/Hjdskes/cage/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="X"

RDEPEND="
	gui-libs/wlroots[X=]
	x11-libs/pixman
	x11-libs/libxkbcommon
"
BDEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		"$(meson_use X xwayland)"
	)
	meson_src_configure
}
