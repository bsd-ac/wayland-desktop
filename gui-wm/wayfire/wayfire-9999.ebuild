# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 fcaps meson eutils

DESCRIPTION="A compiz like 3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wayfire"
EGIT_REPO_URI="https://github.com/WayfireWM/wayfire.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="+wfshell wfsoundcontrol"

S="${WORKDIR}"

DEPEND="
		=gui-libs/wlroots-9999
		media-libs/glm
		x11-libs/gtk+
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
		echo "we are configuring"
		echo $S
		ls
		meson_src_install
		newdoc wayfire.ini.default wayfire.ini
}

#srs_postinst() {
#
#}
