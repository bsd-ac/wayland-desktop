# Copyright 2021-2022 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit font

DESCRIPTION="Sanserif type face family with classical proportions"
HOMEPAGE="https://www.latofonts.com/"
SRC_URI="https://www.latofonts.com/download/lato2ofl-zip/ -> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

S="${WORKDIR}/Lato2OFL"
FONT_SUFFIX="ttf"
DOCS="README.txt"
