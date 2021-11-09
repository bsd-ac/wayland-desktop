# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Cross platform desktop notifications for Python scripts and applications."
HOMEPAGE="https://github.com/nwg-piotr/nwg-panel/"
SRC_URI="https://github.com/nwg-piotr/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}-src.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"
DEPEND="
	$(python_gen_cond_dep 'dev-python/pygobject[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/i3ipc[${PYTHON_USEDEP}]')
	gui-libs/gtk-layer-shell
"

src_install() {
	insinto /usr/share/pixmaps
	doins nwg-panel.svg
	doins nwg-shell.svg
	insinto /usr/share/applications
	doins nwg-panel-config.desktop
	python_install_all
}
