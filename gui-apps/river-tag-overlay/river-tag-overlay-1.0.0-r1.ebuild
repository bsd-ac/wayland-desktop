# Copyright 2023 Niklaus 'vimja' Hofer
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="A pop-up showing tag status [in the river window manager]"
HOMEPAGE="https://git.sr.ht/~leon_plickat/river-tag-overlay"
SRC_URI="https://git.sr.ht/~leon_plickat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}"/${PN}-v${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64 ~amd64"

BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"
DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	x11-libs/pixman
"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	einstalldocs
}
