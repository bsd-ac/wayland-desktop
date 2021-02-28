# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit meson

DESCRIPTION="Openbox alternative for wayland"
HOMEPAGE="https://github.com/johanmalm/labwc"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/johanmalm/labwc"
else
	COMMIT=64b6c37e7c2f6057000b36d530046b2b084283df
	SRC_URI="https://github.com/johanmalm/labwc/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+X"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libinput
	dev-libs/libxml2:2
	gui-libs/wlroots[X?]
	x11-libs/cairo[X?]
	x11-libs/libxkbcommon:=[X?]
	x11-libs/pango[X?]
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		$(meson_feature X xwayland)
	)
	meson_src_configure
}
