
EAPI=7

inherit meson

DESCRIPTION="network transparency with Wayland"

HOMEPAGE="https://gitlab.freedesktop.org/mstoeckl/waypipe"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/mstoeckl/waypipe"
else
	SRC_URI="https://gitlab.freedesktop.org/mstoeckl/waypipe/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-v${PV}
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="dmabuf lz4 man systemtap vaapi video zstd"

DEPEND="
	dmabuf? (
		media-libs/mesa[gbm]
		x11-libs/libdrm
	)
	lz4? ( app-arch/lz4 )
	systemtap? ( dev-util/systemtap )
	vaapi? ( media-libs/mesa[vaapi] )
	video? (
		media-video/ffmpeg[x264,vaapi?]
	)
	zstd? ( app-arch/zstd )
"
RDEPEND="${DEPEND}
	dev-libs/weston[wayland-compositor,screen-sharing]
"
BDEPEND="
	man? ( app-text/scdoc )
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}"/${PN}-0.7.1-systemtap.patch )

src_configure() {
	local mymesonargs=(
		$(meson_use systemtap with_systemtap)
		$(meson_feature dmabuf with_dmabuf)
		$(meson_feature lz4 with_lz4)
		$(meson_feature man man-pages)
		$(meson_feature video with_video)
		$(meson_feature vaapi with_vaapi)
		$(meson_feature zstd with_zstd)
	)
	meson_src_configure
}
