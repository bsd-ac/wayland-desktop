# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A program for screen recording of wlroots-based compositors"
HOMEPAGE="https://git.sr.ht/~leon_plickat/lavalauncher"

if [[ ${PV} == 9999 ]]; then
	inherit mercurial
	EHG_REPO_URI="https://git.sr.ht/~leon_plickat/lavalauncher"
else
	SRC_URI="https://git.sr.ht/~leon_plickat/lavalauncher/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	media-video/ffmpeg
	media-sound/pulseaudio
"
BDEPEND="
	virtual/pkgconfig
	dev-libs/wayland-protocols
"
