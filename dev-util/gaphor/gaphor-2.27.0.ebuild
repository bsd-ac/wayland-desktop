# SPDX-License-Identifier: GPL-2.0 or ISC
# Copyright 2024 Jason André Charles Gantner
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="poetry"
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 desktop

DESCRIPTION="Gaphor is the simple modeling tool"
HOMEPAGE="https://gaphor.org/"
SRC_URI="https://github.com/gaphor/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc test"

DEPEND="
	dev-python/Babel
	dev-python/better-exceptions
	dev-python/defusedxml
	dev-python/dulwich
	dev-python/gaphas
	dev-python/generic
	dev-python/jedi
	dev-python/pillow
	dev-python/pycairo
	dev-python/pydot
	dev-python/pygobject
	dev-python/tinycss2
	gui-libs/gtksourceview
	gui-libs/libadwaita
	${PYTHON_DEPS}
	doc? (
		dev-python/sphinx
		dev-python/sphinx-copybutton
		dev-python/sphinx-intl
		dev-python/myst-parser
		dev-python/furo
	)
	test? (
		dev-python/pytest
		dev-python/pytest-archon
		dev-python/pytest-cov
		dev-python/pytest-randomly
		dev-python/xdoctest
		dev-python/hypothesis
		dev-python/ipython
		dev-python/sphinx
	)
	"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-python/semver
	dev-python/tomli
	"
#	dev-python/pyinstaller
#	dev-python/pyinstaller-versionfile

distutils_enable_tests pytest

src_install() {
	default
	distutils-r1_src_install
	for size in 24 48;do
		doicon --size "$size" "${S}/data/logos/${PN}-${size}x${size}.png"
		newicon "${S}/data/logos/${PN}-logo-full.svg" "${PN}.svg"
	done

	make_desktop_entry 'python -m gaphor' Gaphor "${PN}".svg Development
}
