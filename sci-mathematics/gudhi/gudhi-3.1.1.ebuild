# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )
inherit python-r1 distutils-r1

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
	dev-cpp/eigen
	sci-mathematics/cgal
	dev-libs/boost[python,${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
  dev-python/pot[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

src_configure() {
	
}