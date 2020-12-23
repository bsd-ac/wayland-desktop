
EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit meson python-any-r1

DESCRIPTION="network transparency with Wayland"
HOMEPAGE="https://gitlab.freedesktop.org/mstoeckl/waypipe"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/mstoeckl/waypipe"
else
	SRC_URI="https://gitlab.freedesktop.org/mstoeckl/waypipe/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-v${PV}
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="dmabuf lz4 man systemtap vaapi ffmpeg zstd test"
REQUIRED_USE="vaapi? ( ffmpeg )"
RESTRICT="!test? ( test )"

DEPEND="
	dmabuf? (
		media-libs/mesa[gbm,vaapi?,wayland]
		x11-libs/libdrm
	)
	lz4? ( app-arch/lz4 )
	systemtap? ( dev-util/systemtap )
	vaapi? ( x11-libs/libva[drm,wayland] )
	ffmpeg? (
		media-video/ffmpeg[x264,vaapi?]
	)
	zstd? ( app-arch/zstd )
"
RDEPEND="${DEPEND}
	dev-libs/weston[wayland-compositor,screen-sharing]
"
BDEPEND="
	${PYTHON_DEPS}
	man? ( app-text/scdoc )
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}"/${PN}-0.7.1-systemtap.patch )

src_configure() {
	local mymesonargs=(
		$(meson_use systemtap with_systemtap)
		$(meson_feature dmabuf with_dmabuf)
		$(meson_feature ffmpeg with_video)
		$(meson_feature lz4 with_lz4)
		$(meson_feature man man-pages)
		$(meson_feature vaapi with_vaapi)
		$(meson_feature zstd with_zstd)
	)
	meson_src_configure
}
