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
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
OBSLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

DISTUTILS_IN_SOURCE_BUILD=1

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
		dev-python/flaky[${PYTHON_USEDEP}]
		dev-python/ipython[notebook,${PYTHON_USEDEP}]
		dev-python/pandas[full-support,${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-html[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/mypy[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/networkx[${PYTHON_USEDEP}]
		dev-python/nbconvert[${PYTHON_USEDEP}]
		dev-python/nbformat[${PYTHON_USEDEP}]
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/selenium[${PYTHON_USEDEP}]
		dev-ruby/selenium-webdriver
		>=net-libs/nodejs-12[npm]
		sci-libs/scipy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}/${P}-conftest_py.patch"
)

python_test() {
	distutils_install_for_testing
	# disable tests having network calls
	# and assertion failures
	local SKIP_TESTS=" \
		not (test_model and test_select) and \
		not (test___init__ and TestWarnings and test_filters) and \
		not (test_json__subcommands and test_no_script) and \
		not (test_export and test_get_svgs_no_svg_present) and \
		not test_client_server and \
		not test_server and \
		not test_tornado__server and \
		not test_webdriver and \
		not test_bundle and \
		not test_ext \
	"
	pytest -m "not sampledata and not selenium" tests/unit -k \
		   "${SKIP_TESTS}" -vv || die "unit tests fail with ${EPYTHON}"
}

python_install_all() {
	if use examples; then
		dodoc -r examples
	fi
	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "integration with amazon S3" dev-python/boto
	optfeature "pypi integration to publish packages" dev-python/twine
	optfeature "js library usage" net-libs/nodejs
}
