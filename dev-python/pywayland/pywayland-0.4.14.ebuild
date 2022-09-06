# Copyright 2022 Aisha Tammy <floss@bsd.ac>
# Distributed under the terms of the ISC License

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Python bindings for the libwayland library."
HOMEPAGE="https://github.com/flacjacket/pywayland"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/flacjacket/pywayland"
else
	SRC_URI="https://github.com/flacjacket/pywayland/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	$(python_gen_cond_dep '
		dev-python/cffi[${PYTHON_USEDEP}]
	')
	dev-libs/wayland
"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

distutils_enable_tests pytest

python_compile() {
	${EPYTHON} pywayland/ffi_build.py || die "could not create ffi bindings"
	${EPYTHON} -m pywayland.scanner || die
	distutils-r1_python_compile
}

python_test() {
	distutils_install_for_testing
	local -x XDG_RUNTIME_DIR="${T}"
	pytest -vvv || die "tests failed for ${EPYTHON}"
}
