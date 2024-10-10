# SPDX-License-Identifier: GPL-2.0 OR ISC
# Copyright 2024 Jason André Charles Gantner
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="poetry"
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Generic programming library for Python"
HOMEPAGE="https://generic.readthedocs.org"
SRC_URI="https://github.com/gaphor/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc test"

DEPEND="
	dev-python/pycairo
	dev-python/pygobject
	${PYTHON_DEPS}
	doc? (
		dev-python/sphinx
		dev-python/furo
	)
	test? (
		dev-python/pytest
		dev-python/pytest-archon
		dev-python/pytest-cov
	)
	"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest
