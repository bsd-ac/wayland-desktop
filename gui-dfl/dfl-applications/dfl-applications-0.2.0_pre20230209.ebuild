# Copyright 2022 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="Thin wrapper around Q*Application for DFL project"
HOMEPAGE="https://gitlab.com/desktop-frameworks/applications"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/desktop-frameworks/applications"
else
	COMMIT="be3e1b24f420f58deac0f2ddbe1d081c3e4c6c6f"
	SRC_URI="https://gitlab.com/desktop-frameworks/applications/-/archive/${COMMIT}/applications-${COMMIT}.tar.bz2 -> ${P}.tar.bz2"
	S="${WORKDIR}/applications-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+qt5 qt6"
REQUIRED_USE="^^ ( qt5 qt6 )"

DEPEND="
	qt5? (
		dev-qt/qtcore:5
	)
	qt6? (
		dev-qt/qtbase:6
	)
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		"-Duse_qt_version=$(usex qt5 qt5 qt6)"
	)
	meson_src_configure
}
