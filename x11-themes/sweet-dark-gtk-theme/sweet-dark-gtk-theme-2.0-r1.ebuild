# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit xdg

DESCRIPTION="Sweet (dark) gtk theme"
HOMEPAGE="https://github.com/EliverLara/Sweet"
SRC_URI="https://github.com/EliverLara/Sweet/releases/download/${PV}/Sweet-Dark.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/Sweet-Dark"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/themes/Sweet-Dark
	doins -r assets gnome-shell gtk-{2,3}.0 \
		  metacity-1 xfwm4 index.theme
}
