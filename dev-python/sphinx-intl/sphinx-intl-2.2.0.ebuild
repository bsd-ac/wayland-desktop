# SPDX-License-Identifier: GPL-2.0 OR ISC
# Copyright 2024 Jason André Charles Gantner
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Sphinx utility that make it easy to translate and to apply translation."
HOMEPAGE="https://github.com/sphinx-dox/sphinx-intl/"
SRC_URI="https://github.com/sphinx-doc/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	${PYTHON_DEPS}
	dev-python/click
	dev-python/Babel
	dev-python/sphinx
	"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest
