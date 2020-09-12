# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1 desktop

DESCRIPTION="wallpaper manager for wlroots compositors"
HOMEPAGE="https://github.com/nwg-piotr/azote"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/azote"
else
	SRC_URI="https://github.com/nwg-piotr/azote/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"

RDEPEND="
	dev-python/pygobject
	dev-python/pillow
	dev-python/send2trash
	dev-cpp/gtkmm:3.0
	media-gfx/feh
	x11-apps/xrandr
	dev-python/pyyaml
	gui-apps/grim
	gui-apps/slurp
	media-gfx/maim
	x11-misc/slop
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

python_install_all() {
	distutils-r1_python_install_all

	cd "${S}"

	dobin dist/azote
	domenu dist/azote.desktop

	insinto /usr/share/azote
	doins dist/azote.svg dist/indicator_{active,attention}.png
}
