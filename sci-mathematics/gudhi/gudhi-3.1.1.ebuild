# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
inherit distutils-r1 cmake

DESCRIPTION="An open source C++, python library for Topological Data Analysis"
HOMEPAGE="https://gudhi.inria.fr/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GUDHI/gudhi-devel.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/GUDHI/gudhi-devel/releases/download/tags/gudhi-release-${PV}/${PN}.${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}.${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/cython[${PYTHON_USEDEP}]
	dev-cpp/eigen:3
	sci-mathematics/cgal
	dev-libs/boost[python,${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pot[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-python_CMakeLists.txt.patch"
)

src_install() {
	cmake_src_install

	cd python
	python_foreach_impl run_in_build_dir default
	einstalldocs
}