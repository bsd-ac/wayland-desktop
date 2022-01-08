# Copyright 2021 knotteye <knotteye@waldn.net>
# Distributed under the terms of the ISC License

EAPI=8

PYTHON_COMPAT=( python3_{9,10} )

inherit desktop distutils-r1

DESCRIPTION="GTK3-based panel for sway window manager"
HOMEPAGE="https://github.com/nwg-piotr/nwg-panel/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/nwg-panel.git"
else
	SRC_URI="https://github.com/nwg-piotr/nwg-panel/archive/refs/tags/v${PV}.tar.gz -> ${P}-src.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

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
	domenu nwg-panel-config.desktop
}
