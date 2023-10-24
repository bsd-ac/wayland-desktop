# Copyright 2023 Niklaus 'vimja' Hofer
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="stacktile is a layout generator for the river Wayland compositor."
HOMEPAGE="https://git.sr.ht/~leon_plickat/stacktile"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}"/${PN}-v${PV}

LICENSE="GPLv3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

KEYWORDS="~arm64 ~amd64"

RDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/wayland-scanner
"

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	einstalldocs
}
