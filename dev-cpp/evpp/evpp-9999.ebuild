# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="modern C++ network library for high performance network services"
HOMEPAGE="https://github.com/Qihoo360/evpp"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Qihoo360/evpp.git"
else
	SRC_URI="https://github.com/Qihoo360/evpp/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"

IUSE=""
DEPEND="dev-cpp/glog:=[gflags]
	dev-cpp/gtest
	dev-libs/libevent
	dev-libs/boost
	dev-python/thrift
"
BDEPEND="${DEPEND}"
RDEPEND="${DEPEND}"

DOCS=( readme.md docs/quick_start.md)

PATCHES=(
	${FILESDIR}/evpp-benchmark_throughput_asio_from_chenshuo_handler_allocator.cpp
)
