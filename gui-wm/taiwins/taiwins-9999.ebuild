
EAPI=7

inherit meson

DESCRIPTION="dynamic wayland compositor"
HOMEPAGE="https://github.com/taiwins/taiwins"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/taiwins/taiwins"
else
	SRC_URI="https://github.com/taiwins/taiwins/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	gui-libs/wlroots
	x11-libs/libxkbcommon:=[X]
"

BDEPEND="
	${RDEPEND}
	>=dev-libs/wayland-protocols-1.14
	virtual/pkgconfig
"
