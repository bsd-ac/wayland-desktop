# Copyright 2022 Aisha Tammy <floss@bsd.ac>
# Distributed under the terms of the ISC License

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Python binding to the wlroots library using cffi."
HOMEPAGE="https://github.com/flacjacket/pywlroots"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/flacjacket/pywlroots.git"
else
	SRC_URI="https://github.com/flacjacket/pywlroots/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="NCSA-AMD"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	$(python_gen_cond_dep '
		dev-python/cffi[${PYTHON_USEDEP}]
		dev-python/pywayland[${PYTHON_USEDEP}]
		dev-python/python-xkbcommon[${PYTHON_USEDEP}]
	')
	<gui-libs/wlroots-0.16:=[X]
"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
"

distutils_enable_tests pytest

python_compile() {
	${EPYTHON} wlroots/ffi_build.py || die "could not create ffi bindings"
	distutils-r1_python_compile
}

python_test() {
	distutils_install_for_testing
	pytest -vvv || die "tests failed for ${EPYTHON}"
}
