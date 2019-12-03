# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="Wayfire Config Manager"
HOMEPAGE="https://github.com/WayfireWM/wcm"

inherit git-r3
EGIT_REPO_URI="https://github.com/WayfireWM/${PN}.git"
EGIT_COMMIT="v0.3"
KEYWORDS="~amd64 ~arm64 ~x86"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/libxml2
        dev-cpp/gtkmm:3.0[wayland]
        >=gui-apps/wf-config-0.3
        "
BDEPEND="virtual/pkgconfig
         dev-libs/wayland-protocols
		     "
