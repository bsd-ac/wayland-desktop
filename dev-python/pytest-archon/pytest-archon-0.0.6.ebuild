# SPDX-License-Identifier: GPL-2.0 OR ISC
# Copyright 2024 Jason André Charles Gantner
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Rule your architecture like a real developer"
HOMEPAGE="https://github.com/jwbargsten/pytest-archon/"
SRC_URI="https://github.com/jwbargsten/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	${PYTHON_DEPS}
	dev-python/pytest
	"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest
