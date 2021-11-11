# Copyright 2021 knotteye <knotteye@waldn.net>
# Distributed under the terms of the ISC License

EAPI=7

PYTHON_COMPAT=( python3_9 )

inherit distutils-r1

DESCRIPTION="GTK3-based panel for sway window manager"
HOMEPAGE="https://github.com/nwg-piotr/nwg-panel/"
SRC_URI="https://github.com/nwg-piotr/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}-src.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"
DEPEND="
	$(python_gen_cond_dep 'dev-python/pygobject[${PYTHON_USEDEP}]')
"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep 'dev-python/i3ipc[${PYTHON_USEDEP}]')
	gui-libs/gtk-layer-shell
"

python_install() {
	distutils-r1_python_install
	insinto /usr/share/pixmaps
	doins nwg-panel.svg nwg-shell.svg
	insinto /usr/share/applications
	doins nwg-panel-config.desktop
}
