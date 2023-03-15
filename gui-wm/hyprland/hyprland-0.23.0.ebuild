# Copyright 2022 Aisha Tammy <floss@bsd.ac>
# Distributed under the terms of the ISC License

EAPI=8

inherit toolchain-funcs meson systemd

DESCRIPTION="Dynamic tiling Wayland compositor that doesn't sacrifice on its looks."
HOMEPAGE="https://github.com/hyprwm/Hyprland"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hyprwm/Hyprland"
else
	MY_PV="${PV}beta"
	SRC_URI="https://github.com/hyprwm/Hyprland/releases/download/v${MY_PV}/source-v${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/hyprland-source"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="system-wlroots systemd X"

DEPEND="
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/wayland
	gui-libs/gtk-layer-shell
	media-libs/glm
	media-libs/mesa:=[gles2,wayland,X?]
	media-libs/libglvnd[X?]
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/freetype:=[X?]
	>=x11-libs/libdrm-2.4.114:=
	x11-libs/gtk+:3=[wayland,X?]
	x11-libs/cairo:=[X?,svg(+)]
	x11-libs/libxkbcommon:=[X?]
	x11-libs/pixman
	systemd? (
		sys-apps/systemd
	)
	X? (
		x11-libs/libxcb
		x11-base/xwayland
	)
	gui-libs/wlroots:=[X?]
"

RDEPEND="
	${DEPEND}
	x11-misc/xkeyboard-config
"

BDEPEND="
	app-misc/jq
	>=dev-libs/wayland-protocols-1.27
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/${PN}-0.10.3beta-system-wlroots.patch" )

src_configure() {
	tc-is-gcc && [[ $(gcc-major-version) -ge 12 ]]  && [[ $(gcc-minor-version) -ge 1 ]] || die "hyprland needs gcc version >= 12.1 for C++23"
	local emesonargs=(
		$(meson_feature system-wlroots use_system_wlroots)
		$(meson_feature systemd)
		$(meson_feature X xwayland)
	)
	meson_src_configure
}

src_install() {
	meson_src_install --skip-subprojects
}
