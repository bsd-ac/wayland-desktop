# Copyright 2023 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="Preconfigured layouts for DFL projects"
HOMEPAGE="https://gitlab.com/desktop-frameworks/layouts"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/desktop-frameworks/layouts"
else
	COMMIT="0d6c8afef1934b85fa61d10a28985a9ed201f1ff"
	SRC_URI="https://gitlab.com/desktop-frameworks/layouts/-/archive/${COMMIT}/layouts-${COMMIT}.tar.bz2 -> ${P}.tar.bz2"
	S="${WORKDIR}/layouts-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+qt5 qt6"
REQUIRED_USE="^^ ( qt5 qt6 )"

DEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtwidgets:5
	)
	qt6? (
		dev-qt/qtbase:6[widgets]
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
