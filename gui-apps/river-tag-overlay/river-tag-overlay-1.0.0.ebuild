# Copyright 2023 Niklaus 'vimja' Hofer
# Distributed under the terms of the ISC License

EAPI=8

inherit git-r3

DESCRIPTION="A pop-up showing tag status [in the river window manager]"
HOMEPAGE="https://git.sr.ht/~leon_plickat/river-tag-overlay"
EGIT_REPO_URI="https://git.sr.ht/~leon_plickat/river-tag-overlay"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~arm64 ~amd64"

BDEPEND="virtual/pkgconfig"
DEPEND="
	x11-libs/pixman
	dev-libs/wayland
	dev-libs/wayland-protocols
"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	einstalldocs
}
