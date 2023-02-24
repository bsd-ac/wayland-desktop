# Copyright 2023 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit cmake

DESCRIPTION="Library for managing drive and getting system resource information in real time"
HOMEPAGE="https://gitlab.com/cubocore/libcsys"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/libcsys.git"
else
	SRC_URI="https://gitlab.com/cubocore/libcsys/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
"
RDEPEND="
	${DEPEND}
"
