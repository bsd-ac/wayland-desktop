# Copyright 2021 knotteye <knotteye@waldn.net>
# Distributed under the terms of the ISC License

EAPI=7

PYTHON_COMPAT=( python3_9 )

inherit distutils-r1 git-r3

DESCRIPTION="An improved Python library to control i3wm and sway."
HOMEPAGE="https://github.com/altdesktop/i3ipc-python/"
EGIT_REPO_URI="https://github.com/altdesktop/i3ipc-python.git"
LICENSE="BSD"

SLOT="0"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep 'dev-python/python-xlib[${PYTHON_USEDEP}]')
"

