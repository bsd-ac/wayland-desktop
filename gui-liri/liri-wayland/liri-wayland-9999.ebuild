# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit ecm

DESCRIPTION="Liri wayland client and server extensions"
HOMEPAGE="https://github.com/lirios/wayland"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/wayland"
else
	COMMIT=ff9e88882a7da05b31713722f08e81d7b842c882
	SRC_URI="https://github.com/lirios/wayland/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/wayland-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwayland:5
"
DEPEND="${RDEPEND}
	gui-liri/liri-cmake-shared
"
BDEPEND="
	dev-libs/wayland-protocols
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	ecm_src_configure
}
