# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit xdg

DESCRIPTION="meta icon theme for pico-wayfire"
HOMEPAGE="https://github.com/bsd-ac/pico-wayfire-icon-theme"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bsd-ac/pico-wayfire-icon-theme"
else
	SRC_URI="https://github.com/bsd-ac/pico-wayfire-icon-theme/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"

RDEPEND="
	x11-themes/adwaita-icon-theme
	x11-themes/beautyline-icon-theme[no-inherit]
	x11-themes/candy-icon-theme[no-inherit]
	x11-themes/hey-icon-theme[no-inherit]
	x11-themes/hicolor-icon-theme
	x11-themes/oie-icon-theme[no-inherit]
"

src_install() {
	insinto /usr/share/icons/PicoWayfire
	doins -r index.theme scalable
}
