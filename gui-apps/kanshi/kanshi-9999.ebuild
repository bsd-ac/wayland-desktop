# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="dynamic display configuration (autorandr for wayland)"
HOMEPAGE="https://github.com/emersion/kanshi"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/emersion/kanshi"
else
	SRC_URI="https://github.com/emersion/kanshi/releases/download/v${PV}/${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="doc"

RDEPEND="
	dev-libs/wayland
"
BDEPEND="
	${RDEPEND}
	virtual/pkgconfig
	dev-libs/wayland-protocols
"

src_configure() {
	local emesonargs=(
		$(meson_feature doc man-pages)
	)
	meson_src_configure
}
