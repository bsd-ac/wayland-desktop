# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="obs-studio plugin to screen capture on wlroots compositors"
HOMEPAGE="https://hg.sr.ht/~scoopta/wlrobs"

if [[ ${PV} == 9999 ]]; then
	inherit mercurial
	EHG_REPO_URI="https://hg.sr.ht/~scoopta/wlrobs"
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+dmabuf +screencopy"

DEPEND="
	dmabuf? (
		media-libs/mesa:=[egl]
		x11-libs/libdrm
	)
"
RDEPEND="
	media-video/obs-studio
	gui-libs/wlroots
"
BDEPEND="virtual/pkgconfig"

src_compile() {
	local emesonargs=(
		$(meson_use screencopy use_scpy)
		$(meson_use dmabuf use_dmabuf)
	)
	meson_src_compile
}

src_install() {
	emake PREFIX=${D}/usr ETC_PREFIX=${D}/etc install
}
