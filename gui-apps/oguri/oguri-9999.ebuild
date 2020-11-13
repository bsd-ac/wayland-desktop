
EAPI=7

inherit meson

DESCRIPTION="animated wallpaper daemon for Wayland compositors"
HOMEPAGE="https://github.com/vilhalmer/oguri"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vilhalmer/oguri"
else
	COMMIT=d6f195acca5de465532cba3efd4b0c592ca542d9
	SRC_URI="https://github.com/vilhalmer/oguri/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"

DEPEND="
	dev-libs/wayland
	gui-libs/gtk-layer-shell
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"
