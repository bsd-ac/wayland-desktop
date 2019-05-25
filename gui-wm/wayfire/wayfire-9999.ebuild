# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fcaps meson eutils

DESCRIPTION="A compiz like 3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wayfire"
EGIT_REPO_URI="https://github.com/WayfireWM/wayfire.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+wfshell wfsoundcontrol"

DEPEND="
		=gui-libs/wlroots-9999
		media-libs/glm
		x11-libs/gtk3
		x11-libs/cairo
		x11-libs/libxkbcommon
		x11-libs/pixman
		media-libs/libjpeg-turbo
		media-libs/libpng
		"
#		=gui-libs/wf-config-9999
#		wfshell? (gui-libs/wf-shell-9999)
#		wfsoundcontrol? (gui-libs/wf-soundcontrol-9999)
#		"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-util/meson
		dev-util/ninja
		dev-util/cmake
		virtual/pkgconfig
		>=dev-libs/wayland-protocols-9999
		"

FILECAPS=( cap_sys_admin usr/bin/wayfire )

src_configure() {
		meson_src_configure
}

src_install() {
		meson_src_install
		newdoc wayfire.ini.default wayfire.ini
}

#srs_postinst() {
#
#}
