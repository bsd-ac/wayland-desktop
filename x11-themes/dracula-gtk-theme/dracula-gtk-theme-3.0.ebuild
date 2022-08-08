# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit xdg

DESCRIPTION="Dracula GTK theme"
HOMEPAGE="https://draculatheme.com/gtk"
SRC_URI="
	https://github.com/dracula/gtk/releases/download/v${PV}/Dracula-pink-accent.tar.xz -> ${P}-pink.tar.xz
	https://github.com/dracula/gtk/releases/download/v${PV}/Dracula.tar.xz -> ${P}.tar.xz
"
#https://github.com/dracula/gtk/releases/download/v${PV}/Dracula-shell-pink-accent-v40.tar.xz -> ${P}-pink-v40.tar.xz
#https://github.com/dracula/gtk/releases/download/v${PV}/Dracula-shell-v40.tar.xz -> ${P}-v40.tar.xz

S="${WORKDIR}"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

src_prepare() {
	default
	local theme
	for theme in * ; do
		sed -e "/^Name\s*=Ant-Dracula/s|^.*$|Name=${theme}|" \
			-i "${theme}"/index.theme || die
	done
}

src_install() {
	insinto /usr/share/themes
	doins -r "${S}"/.
}
