# Copyright 2022 Aisha Tammy <floss@bsd.ac>
# Distributed under the terms of the ISC License

EAPI=8

PYTHON_COMPAT=( python3_{9,10} )

inherit distutils-r1

DESCRIPTION="Wayland compositor for laptops and touchpads."
HOMEPAGE="https://github.com/jbuchermn/newm"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jbuchermn/newm.git"
else
	SRC_URI="https://github.com/jbuchermn/newm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"

SLOT="0"
DEPEND="
		$(python_gen_cond_dep '
			dev-python/dasbus[${PYTHON_USEDEP}]
			dev-python/psutil[${PYTHON_USEDEP}]
			dev-python/pycairo[${PYTHON_USEDEP}]
			dev-python/pyfiglet[${PYTHON_USEDEP}]
			dev-python/python-pam[${PYTHON_USEDEP}]
			dev-python/thefuzz[${PYTHON_USEDEP}]
		')
"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest
