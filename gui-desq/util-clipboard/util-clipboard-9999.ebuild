# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit xdg cmake

DESCRIPTION="Simple clipboard for DesQ Shell"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/DesQUtils/Clipboard"
else
	COMMIT=9546e7d2f591f8a2d5f88fbc6c2d2d2d7f778eb8
	SRC_URI="https://gitlab.com/DesQ/DesQUtils/Clipboard/-/archive/${COMMIT}/Clipboard-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/clipboard-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtwayland:5
	dev-qt/qtwidgets:5
	gui-desq/libdesq
	gui-desq/libdesqwl
"
RDEPEND="${DEPEND}"

src_prepare() {
	xdg_src_prepare
	cmake_src_prepare
}
