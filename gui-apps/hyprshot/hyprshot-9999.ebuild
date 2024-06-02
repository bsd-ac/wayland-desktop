# Copyright 2024 Misha Zavertkin <misha.zavertkin@mail.ru>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="Hyprshot is an utility to easily take screenshot in Hyprland using your mouse"
HOMEPAGE="https://github.com/Gustash/Hyprshot/"

EGIT_REPO_URI="https://github.com/Gustash/Hyprshot.git/"
inherit git-r3

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
	gui-apps/hyprpicker
"

src_install() {
	dobin hyprshot
	dodoc LICENSE README.md
}
