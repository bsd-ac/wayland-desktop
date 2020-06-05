# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# enable 3.8 when llvmlite gets 3.8.
PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1 eutils

DESCRIPTION="NumPy aware dynamic Python compiler using LLVM"
HOMEPAGE="https://numba.pydata.org/
	https://github.com/numba"
SRC_URI="https://github.com/numba/numba/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples openmp threads"

DEPEND="
	>=dev-python/llvmlite-0.32.0[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	openmp? ( virtual/mpi[cxx,threads?] )
	threads? ( dev-cpp/tbb )
"
RDEPEND="${DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
BDEPEND="
	${DEPEND}
	test? (
		sci-libs/scipy[${PYTHON_USEDEP}]
	)
"

DISTUTILS_IN_SOURCE_BUILD=1
distutils_enable_tests unittest

#"${FILESDIR}/numba-skip-tests.patch"
PATCHES=(
	"${FILESDIR}/numba-0.49.1-tbb-check.patch"
)

python_compile() {
	NUMBA_NO_TBB=$(usex threads 0 1) \
	TBBROOT="${SYSROOT}/usr/include" \
	NUMBA_NO_OPENMP=$(usex openmp 0 1) \
	distutils-r1_python_compile -j 1
}

python_test() {
	distutils_install_for_testing
	${EPYTHON} setup.py build_ext --inplace || die
	${EPYTHON} runtests.py -m || die
}

# upstream authoritative install documentation
# https://numba.pydata.org/numba-doc/latest/user/installing.html
python_install_all() {
	if use examples; then
		dodoc -r examples
	fi
	NUMBA_NO_TBB=$(usex threads 0 1) \
	TBBROOT="${SYSROOT}/usr/include" \
	NUMBA_NO_OPENMP=$(usex openmp 0 1) \
	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "support for linear algebra" sci-libs/scipy
	optfeature "compile cuda code" dev-util/nvidia-cuda-sdk
}
