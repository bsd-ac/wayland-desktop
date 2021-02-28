# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="main user interface shell for DesQ"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/DesQUtils/SettingsDaemon"
else
	COMMIT=d5994bcb68edfa73ec8ffeaceaf0d8b50eadac2d
	SRC_URI="https://gitlab.com/DesQ/DesQUtils/SettingsDaemon/-/archive/${COMMIT}/SettingsDaemon-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/SettingsDaemon-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
"
RDEPEND="${DEPEND}"
