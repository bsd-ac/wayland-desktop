# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit ecm

DESCRIPTION="Liri core library"
HOMEPAGE="https://github.com/lirios/libliri"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/libliri"
else
	COMMIT=6e47eb9030575a7c6eee0310bb64a935ae320757
	SRC_URI="https://github.com/lirios/libliri/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwayland:5
	dev-qt/qtxml:5
"
DEPEND="${RDEPEND}
	gui-liri/liri-cmake-shared
"
BDEPEND="
	dev-libs/wayland-protocols
"

PATCHES=( "${FILESDIR}"/${PN}-0-no_logind_test.patch )

src_configure() {
	local mycmakeargs=(
		-DLIRI_BUILD_TESTING=$(usex test)
	)
	ecm_src_configure
}
