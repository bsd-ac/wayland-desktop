# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend

# upstream hasn't tested python 3.8 fully
PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Statistical and interactive HTML plots for Python"
HOMEPAGE="https://bokeh.org/
	https://github.com/bokeh/bokeh
	https://pypi.org/project/bokeh/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

distutils_enable_tests pytest

# upstream authoritative dependencies
# https://github.com/bokeh/bokeh/blob/master/conda.recipe/meta.yaml
DEPEND="
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/markupsafe[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	>=www-servers/tornado-5[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND="
	${DEPEND}
	sys-apps/ripgrep[pcre]
	test? (
		dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
		dev-python/boto[${PYTHON_USEDEP}]
		dev-python/colorama[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nbformat[${PYTHON_USEDEP}]
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/selenium[${PYTHON_USEDEP}]
		>=net-libs/nodejs-12[npm]
		sci-libs/scipy[${PYTHON_USEDEP}]
	)
"

python_compile() {
	esetup.py build --build-js
}

python_test() {
	pytest tests/unit -vv || die "unit tests fail with ${EPYTHON}"
	pytest tests/test_bokehjs.py -vv || die "bokehjs tests fail with ${EPYTHON}"
}

python_install_all() {
	if use examples; then
		dodoc -r examples
	fi
	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "integration with amazon services" dev-python/boto
	optfeature "pypi integration for publishing bokeh build packages" dev-python/twine
	optfeature "using the js library for integration project integration" net-libs/nodejs
}
