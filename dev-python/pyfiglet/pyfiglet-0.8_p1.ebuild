# Copyright 2022 Aisha Tammy <floss@bsd.ac>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="Implementation of figlet written in Python"
HOMEPAGE="https://github.com/pwaller/pyfiglet"

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pwaller/pyfiglet.git"
else
	PYPI_VER="0.8.post1"
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PYPI_VER}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${PYPI_VER}"
fi

LICENSE="MIT"
SLOT="0"

RESTRICT="test"
