# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# enable 3.8 when llvmlite gets 3.8.
PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="NumPy aware dynamic Python compiler using LLVM"
HOMEPAGE="http://numba.pydata.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples openmp threads"

distutils_enable_tests pytest

RDEPEND="
	>=dev-python/llvmlite-0.31.0[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	threads? ( dev-cpp/tbb )
	openmp? ( virtual/mpi[cxx] )
"
BDEPEND="
	${RDEPEND}
"

PATCHES=(
	"${FILESDIR}/numba-skip-tests.patch"
	"${FILESDIR}/numba-tbb-check.patch"
)

python_test() {
	cd "${BUILD_DIR}/lib" || die
	${EPYTHON} -m numba.runtests -vv || die
}

# upstream authoritative install documentation
# https://numba.pydata.org/numba-doc/latest/user/installing.html

python_install_all() {
	if use examples; then
		dodoc -r examples
	fi
	distutils-r1_python_install_all
}

python_compile() {
	if ! use threads; then
		export NUMBA_NO_TBB=1
	else
		export TBBROOT=${SYSROOT}/usr/
	fi

	distutils-r1_python_compile -j1
}
