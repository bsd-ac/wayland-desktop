# Copyright 2023 Niklaus 'vimja' Hofer
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="Small screenlocker for Wayland compositors"
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

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	einstalldocs
}
