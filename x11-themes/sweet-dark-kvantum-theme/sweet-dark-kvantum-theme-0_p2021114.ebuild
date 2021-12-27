# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit xdg

PV_BASE=0_p20211106
PV_MARS=0_p20211114

DESCRIPTION="Sweet (dark) kvantum theme"
HOMEPAGE="https://github.com/EliverLara/Sweet-KDE"
SRC_URI="
	mirror://bsd.ac/sweet-kvantum-${PV_BASE}.tar.xz
	mirror://bsd.ac/sweet-transparent-kvantum-${PV_BASE}.tar.xz
	mirror://bsd.ac/sweet-mars-kvantum-${PV_MARS}.tar.xz
	mirror://bsd.ac/sweet-mars-transparent-kvantum-${PV_MARS}.tar.xz
"
S="${WORKDIR}"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

src_install() {
	local stheme ltheme
	for stheme in *; do
		insinto "/usr/share/Kvantum/${stheme}"
		doins "${stheme}"/*
	done
}
