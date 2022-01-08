# Copyright 2021 knotteye <knotteye@waldn.net>
# Distributed under the terms of the ISC License

EAPI=8

PYTHON_COMPAT=( python3_{9,10} )

inherit virtualx distutils-r1

DESCRIPTION="An improved Python library to control i3wm and sway."
HOMEPAGE="https://github.com/altdesktop/i3ipc-python/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/altdesktop/i3ipc-python.git"
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD"

SLOT="0"
BDEPEND="
	test? (
		x11-wm/i3
		$(python_gen_cond_dep '
			dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		')
	)
"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep '
		dev-python/python-xlib[${PYTHON_USEDEP}]
	')
"

distutils_enable_tests pytest

PATCHES=( "${FILESDIR}/${PN}-2.2.1-fix-test_workspace-bug.patch" )

python_test() {
	distutils_install_for_testing
	virtx py.test --verbose -k "not TestShutdownEvent" || die
}
