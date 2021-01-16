
EAPI=7

DESCRIPTION="openbox clone on wayland"
HOMEPAGE="https://github.com/johanmalm/labwc"

inherit meson

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

RDEPEND="
	dev-libs/glib:2
	dev-libs/libxml2:2
	gui-libs/wlroots[X]
	x11-libs/cairo[X]
	x11-libs/libxkbcommon:=[X]
	x11-libs/pango[X]
"

BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"
