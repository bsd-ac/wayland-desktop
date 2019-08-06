# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="A compiz like 3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wf-shell"
EGIT_REPO_URI="https://github.com/WayfireWM/wf-shell.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
		=gui-wm/wayfire-9999
		dev-cpp/gtkmm:3.0
		"
RDEPEND="${DEPEND}"
BDEPEND="
		virtual/pkgconfig
		=dev-libs/wayland-protocols-9999
		"
