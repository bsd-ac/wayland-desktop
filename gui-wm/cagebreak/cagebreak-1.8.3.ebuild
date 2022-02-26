# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit font meson

DESCRIPTION="Wayland tiling compositor inspired by RatPoison"
HOMEPAGE="https://github.com/project-repo/cagebreak"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/project-repo/cagebreak"
else
	SRC_URI="https://github.com/project-repo/cagebreak/releases/download/${PV}/release_${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+X"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libinput
	dev-libs/libxml2:2
	>=gui-libs/wlroots-0.14.1:=[X?]
	x11-libs/cairo[X?]
	x11-libs/libxkbcommon:=[X?]
	x11-libs/pango[X?]
	x11-libs/pixman
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
	app-text/scdoc
"

src_configure() {
	local emesonargs=(
		$(meson_use X xwayland)
		-Dman-pages=true
	)
	meson_src_configure
}
