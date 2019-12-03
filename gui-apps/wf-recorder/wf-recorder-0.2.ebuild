# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="A program for screen recording of wlroots-based compositors"
HOMEPAGE="https://github.com/ammen99/wf-recorder"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ammen99/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/ammen99/${PN}/releases/download/v${PV}/${P}.tar.xz -> ${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
		media-video/ffmpeg
		media-sound/pulseaudio
		"
RDEPEND="${DEPEND}"
BDEPEND="
		virtual/pkgconfig
		dev-libs/wayland-protocols
		"
