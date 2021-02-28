# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake
DESCRIPTION="SNI plugin for DesQ"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/DesQPlugins/SNI"
else
	COMMIT=733e0a810eaa8d21ec19f95c5ae4a0223bc05715
	SRC_URI="https://gitlab.com/DesQ/DesQPlugins/SNI/-/archive/${COMMIT}/Shell-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/SNI-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtwidgets:5
	gui-desq/libdesqui
	gui-desq/libdesqwl
"
RDEPEND="${DEPEND}"
