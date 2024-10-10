# SPDX-License-Identifier: GPL-2.0 OR ISC
# Copyright 2024 Jason André Charles Gantner
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Pretty and useful exceptions in Python, automatically."
HOMEPAGE="https://github.com/qix-/better-exceptions"
SRC_URI="https://github.com/qix-/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

DEPEND="
	${PYTHON_DEPS}
	test? (
		dev-python/pytest
		dev-python/pytest-cov
	)
	"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest
