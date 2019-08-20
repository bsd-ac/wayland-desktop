# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="Wayfire Config Manager"
HOMEPAGE="https://github.com/WayfireWM/wcm"
EGIT_REPO_URI="https://github.com/WayfireWM/wcm.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="=gui-wm/wayfire-9999"
RDEPEND="${DEPEND}"
BDEPEND=""
