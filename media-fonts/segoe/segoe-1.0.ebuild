# Copyright 2021-2022 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit font

DESCRIPTION="Segoe font family by Microsoft"
HOMEPAGE="https://docs.microsoft.com/windows/apps/design/downloads/#fonts"
SRC_URI="
	https://aka.ms/SegoeUIVariable -> ${P}-variable.zip
	https://aka.ms/SegoeFluentIcons -> ${P}-fluent-icons.zip
	https://aka.ms/segoeuifont -> ${P}-ui.zip
	https://aka.ms/segoemdl2 -> ${P}-mdl2.zip
"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

S="${WORKDIR}"
FONT_SUFFIX="ttf"
DOCS="EULA.txt"
