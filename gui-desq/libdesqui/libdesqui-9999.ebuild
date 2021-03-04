# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake
DESCRIPTION="DesQ library for UI elements"

HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/libdesqui"
else
	COMMIT=6bf1f40f8f3694d1d0936f83de6f98100e108757
	SRC_URI="https://gitlab.com/DesQ/libdesqui/-/archive/${COMMIT}/libdesqui-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/libdesqui-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5[X]
	gui-desq/libdesq
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DPKGCONFPATH="${EPREFIX}"/etc/xdg/desq
		-DPKGSHAREDPATH=share/desq
	)
	cmake_src_configure
}
