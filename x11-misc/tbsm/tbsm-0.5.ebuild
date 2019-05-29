# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A pure bash session or application launcher. Inspired by cdm, tdm and krunner"
HOMEPAGE="https://loh-tar.github.io/tbsm/"
SRC_URI="https://github.com/loh-tar/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-shells/bash"
RDEPEND="${DEPEND}"
BDEPEND=""
