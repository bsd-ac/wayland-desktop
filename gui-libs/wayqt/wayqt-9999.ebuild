# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="Qt-based wrapper for various wayland protocols"
HOMEPAGE="https://gitlab.com/desktop-frameworks/wayqt"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/desktop-frameworks/wayqt"
else
	COMMIT="b02915936dcefcb353d494dda769cb0a696904ce"
	SRC_URI="https://gitlab.com/desktop-frameworks/wayqt/-/archive/${COMMIT}/wayqt-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/wayqt-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT Unlicense"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwayland:5
	dev-qt/qtwidgets:5
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	dev-libs/wayland-protocols
	dev-qt/linguist-tools:5
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		"-Duse_qt_version=qt5"
	)
	meson_src_configure
}
