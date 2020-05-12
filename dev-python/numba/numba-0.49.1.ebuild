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
	>=dev-python/llvmlite-0.32.0[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	threads? ( dev-cpp/tbb )
	openmp? ( virtual/mpi[cxx] )
"
BDEPEND="
	${RDEPEND}
	test? (
		sci-libs/scipy[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/numba-skip-tests.patch"
	"${FILESDIR}/numba-tbb-check.patch"
)

python_test() {
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
	NUMBA_NO_TBB=$(usex threads 0 1) \
	TBBROOT="${SYSROOT}/usr/include" \
	NUMBA_NO_OPENMP=$(usex openmp 0 1) \
	distutils-r1_python_compile -j 1
}

pkg_postinst() {
	optfeature "support for linear algebra" sci-libs/scipy
	optfeature "compile cuda code" dev-util/nvidia-cuda-sdk
}
