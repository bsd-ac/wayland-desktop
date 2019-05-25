# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson eutils

DESCRIPTION="A compiz like 3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wayfire"
EGIT_REPO_URI="https://github.com/WayfireWM/wayfire.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
		>=gui-libs/wlroots-0.4.1
		dev-libs/libevdev
		"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-util/meson
		dev-util/ninja
		"
src_configure() {
		local emesonargs=(
				
		)
}
