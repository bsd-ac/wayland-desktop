# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson eutils

DESCRIPTION="A compiz like 3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wf-shell"
EGIT_REPO_URI="https://github.com/WayfireWM/wf-shell.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="
		=gui-wm/wayfire-9999
		media-libs/glm
		x11-libs/gtk+
		"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-util/meson
		dev-util/ninja
		dev-util/cmake
		virtual/pkgconfig
		>=dev-libs/wayland-protocols-9999
		"


src_configure() {
		meson_src_configure
}


src_install() {
		meson_src_install
}

