
EAPI=7

inherit meson

DESCRIPTION="VNC server for wlroots based Wayland compositors"
HOMEPAGE="https://github.com/any1/wayvnc"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/any1/wayvnc.git"
else
	COMMIT="4f1bca55c3bf19a58e9d892a5141fdfc5159bf01"
	SRC_URI="https://github.com/any1/wayvnc/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="ISC"
SLOT="0"

RDEPEND="
	dev-libs/aml
	dev-libs/wayland
	gui-libs/neatvnc
	media-libs/mesa:=[egl,gles2]
	x11-libs/libxkbcommon
	x11-libs/pixman
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-libs/wayland-protocols
"
