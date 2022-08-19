# Copyright 2022 Aisha Tammy <floss@bsd.ac>
# Distributed under the terms of the ISC License

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

inherit meson distutils-r1

DESCRIPTION="wlroots-based Wayland compositor with Python frontend."
HOMEPAGE="https://github.com/jbuchermn/pywm"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jbuchermn/pywm.git"
else
	MY_VER="0.3alpha"
	SRC_URI="https://github.com/jbuchermn/pywm/archive/refs/tags/v${MY_VER}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_VER}"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+X"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	$(python_gen_cond_dep '
		dev-python/imageio[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/python-evdev[${PYTHON_USEDEP}]
	')
	dev-libs/libinput:=
	dev-libs/wayland
	x11-libs/libdrm
	x11-libs/libxkbcommon[X?]
	gui-libs/egl-wayland
	>=gui-libs/wlroots-0.14.1:=[X?]
	media-libs/mesa:=[gles2,wayland,X?]
	x11-libs/pixman
"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/pywm-0.3-meson.patch" )

python_prepare() {
	sed -e "s:@MESON_BUILD_ROOT@:${BUILD_DIR}:g" -i setup.py || die
}

python_configure_all() {
	local emesonargs=(
		$(meson_feature X xwayland)
	)
	meson_src_configure
}

python_compile() {
	meson_src_compile
	distutils-r1_python_compile
}
