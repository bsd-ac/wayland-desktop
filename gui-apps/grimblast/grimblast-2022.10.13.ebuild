# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="dafb86d6d3adb421e788f0eaeecdf09c497a14e8"
DESCRIPTION="A helper for screenshots within hyprland"
HOMEPAGE="https://github.com/hyprwm/contrib/"

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/hyprwm/contrib.git/"
	inherit git-r3
	S="${WORKDIR}/grimblast-9999/${PN}"
else
	SRC_URI="https://github.com/hyprwm/contrib/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/contrib-${COMMIT}/${PN}"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	app-misc/jq
	gui-apps/grim
	gui-apps/slurp
	gui-apps/wl-clipboard
	gui-wm/hyprland
	x11-libs/libnotify
"

DEPEND="${RDEPEND}"

BDEPEND=""

src_install() {
	dodoc grimblast.1
	dobin grimblast
}
