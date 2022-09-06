# Copyright 2022 Aisha Tammy <floss@bsd.ac>
# Distributed under the terms of the ISC License

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Fuzzy String Matching in Python."
HOMEPAGE="https://github.com/rhinstaller/dasbus"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/seatgeek/thefuzz.git"
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/hypothesis[${PYTHON_USEDEP}]
		')
	)
"

distutils_enable_tests pytest
