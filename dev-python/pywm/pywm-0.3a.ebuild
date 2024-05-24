# Copyright 2022 Aisha Tammy <floss@bsd.ac>
# Distributed under the terms of the ISC License

EAPI=8

# can't enable yet, meson inherit implies in source build
# https://github.com/bsd-ac/wayland-desktop/issues/49
#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

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

	PATCHES="${FILESDIR}/pywm-wlroots-wrap.patch"
	RESTRICT="network-sandbox"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+X"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	$(python_gen_cond_dep '
		dev-python/imageio[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/evdev[${PYTHON_USEDEP}]
	')
	dev-libs/libinput:=
	dev-libs/wayland
	x11-libs/libdrm
	x11-libs/libxkbcommon[X?]
	gui-libs/egl-wayland
	media-libs/mesa:=[wayland,X?]
	x11-libs/pixman
"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

PATCHES=(
	${PATCHES}
	"${FILESDIR}/pywm-0.3-meson.patch"
	"${FILESDIR}/pywm-wlroots-no-examples.patch"
)

python_prepare() {
	sed -e "s:@MESON_BUILD_ROOT@:${BUILD_DIR}:g" -i setup.py || die
}

python_configure_all() {
	if [[ "${PV}" != 9999 ]]; then
		cd "${S}" && meson subprojects update --reset
	fi
	local emesonargs=(
		$(meson_feature X xwayland)
	)
	meson_src_configure
}

python_compile() {
	meson_src_compile
	distutils-r1_python_compile
}
