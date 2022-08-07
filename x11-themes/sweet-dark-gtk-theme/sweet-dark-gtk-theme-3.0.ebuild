# Copyright 2021-2022 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit xdg

DESCRIPTION="Sweet (dark) gtk theme"
HOMEPAGE="https://github.com/EliverLara/Sweet"
SRC_URI="
	https://github.com/EliverLara/Sweet/releases/download/v${PV}/Sweet-Dark.zip -> ${P}.zip
	https://github.com/EliverLara/Sweet/releases/download/v${PV}/Sweet-Dark-v40.zip -> ${P}-v40.zip
"
S="${WORKDIR}"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

BDEPEND="app-arch/unzip"

src_install() {
	insinto /usr/share/themes/Sweet-Dark
	doins -r Sweet-Dark/{assets,cinnamon,gnome-shell,gtk-{2,3}.0,metacity-1,xfwm4,index.theme}
	insinto /usr/share/themes/Sweet-Dark-4
	doins -r Sweet-Dark-v40/{assets,cinnamon,gnome-shell,gtk-{2,3}.0,metacity-1,xfwm4,index.theme}
}
