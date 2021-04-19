# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit xdg

DESCRIPTION="colorful design icon theme"
HOMEPAGE="https://www.gnome-look.org/s/Gnome/p/1460991
	https://github.com/yeyushengfan258/Lyra-icon-theme
"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/yeyushengfan258/Lyra-icon-theme"
else
	COMMIT="62ffd49ee40b5651ffb1fedcc4e97f6b0d0382c5"
	SRC_URI="https://github.com/yeyushengfan258/Lyra-icon-theme/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/Lyra-icon-theme-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="no-inherit"

src_compile() {
	mkdir "${T}"/generated || die
	./install.sh -a -d "${T}"/generated || die
}

src_install() {
	insinto /usr/share/icons/
	for themev in "${T}"/generated/*; do
		use no-inherit && sed -e "/^Inherits/d" \
				      -i "${themev}"/index.theme || die
		doins -r "${themev}"
	done
}
