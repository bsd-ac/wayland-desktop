# Copyright 2021 knotteye <knotteye@waldn.net>
# Distributed under the terms of the ISC License

EAPI=7

PYTHON_COMPAT=( python3_9 )

inherit distutils-r1

DESCRIPTION="An improved Python library to control i3wm and sway."
HOMEPAGE="https://github.com/altdesktop/i3ipc-python/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep 'dev-python/python-xlib[${PYTHON_USEDEP}]')
"

