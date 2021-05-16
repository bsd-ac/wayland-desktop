# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit xdg

DESCRIPTION="Sweet (dark) kvantum theme"
HOMEPAGE="https://github.com/EliverLara/Sweet-KDE"
SRC_URI="mirror://bsd.ac/${P}.tar.xz"
S="${WORKDIR}/Sweet"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/Kvantum/Sweet
	doins Sweet.kvconfig Sweet.svg
}
