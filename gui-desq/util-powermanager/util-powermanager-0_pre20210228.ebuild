# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit xdg cmake

DESCRIPTION="Power Manager for DesQ"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/DesQUtils/PowerManager"
else
	COMMIT=890c95eabdeee5996b5bc35dae2212d410aaa7c6
	SRC_URI="https://gitlab.com/DesQ/DesQUtils/PowerManager/-/archive/${COMMIT}/PowerManager-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/PowerManager-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	gui-desq/libdesq
"
RDEPEND="${DEPEND}"

src_prepare() {
	xdg_src_prepare
	cmake_src_prepare
}
