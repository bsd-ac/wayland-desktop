# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A small GUI utility to control sound volume"
HOMEPAGE="https://github.com/WayfireWM/wf-sound-control"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WayfireWM/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/WayfireWM/wf-sound-control/releases/download/v${PV}/${P}.tar.xz -> ${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	gui-wm/wayfire
	"
BDEPEND=""