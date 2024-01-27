# Copyright 2024 Misha Zavertkin <misha.zavertkin@mail.ru>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="Hyprshot is an utility to easily take screenshot in Hyprland using your mouse"
HOMEPAGE="https://github.com/Gustash/Hyprshot/"

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/Gustash/Hyprshot.git/"
	inherit git-r3
else
	SRC_URI="https://github.com/Gustash/Hyprshot/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/Hyprshot-${PV}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-misc/jq
	app-shells/bash
	gui-apps/grim
	gui-apps/slurp
	gui-apps/wl-clipboard
	gui-wm/hyprland
	x11-libs/libnotify
"

src_install() {
	dobin hyprshot
	dodoc LICENSE README.md
}
