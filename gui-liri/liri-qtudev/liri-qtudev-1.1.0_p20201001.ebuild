# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit ecm

DESCRIPTION="shared cmake configuration utils for liri"
HOMEPAGE="https://github.com/lirios/cmake-shared"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/qtudev"
else
	COMMIT=f80ba68becac258004c7e331a6bdbb001b4e5a4f
	SRC_URI="https://github.com/lirios/qtudev/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/qtudev-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	virtual/udev
"
DEPEND="${RDEPEND}
	gui-liri/liri-cmake-shared
"
BDEPEND="
	test? ( dev-util/umockdev )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	ecm_src_configure
}

src_test() {
	LD_PRELOAD="libumockdev-preload.so.0 ${LD_PRELOAD}" \
	ecm_src_test
}
