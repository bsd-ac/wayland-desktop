# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="general logout scripts for wayland compositors"

HOMEPAGE="https://github.com/soreau/wayland-logout"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/soreau/wayland-logout"
else
	SRC_URI="https://github.com/soreau/wayland-logout/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="c +python shell"
REQUIRED_USE="^^ ( c python shell )"

RDEPEND="shell? ( sys-process/lsof )"

src_install() {
	exeinto /usr/bin
	if use python; then
		mv "${S}"/wayland-logout.py "${S}"/wayland-logout
	elif use shell; then
		mv "${S}"/wayland-logout.sh "${S}"/wayland-logout
	fi
	doexe wayland-logout
}
