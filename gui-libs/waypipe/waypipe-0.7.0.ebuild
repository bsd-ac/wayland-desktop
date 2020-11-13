
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
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="dmabuf lz4 man vaapi video zstd"
REQUIRED_USE="?? ( lz4 zstd )"

DEPEND="
	lz4? ( app-arch/lz4 )
	zstd? ( app-arch/zstd )
"
RDEPEND="${DEPEND}
	dev-libs/weston[wayland-compositor,screen-sharing]
"
BDEPEND="
	dev-libs/wayland
	virtual/pkgconfig
"

src_configure() {
	local mymesonargs=(
		$(meson_feature dmabuf)
		$(meson_feature lz4)
		$(meson_feature man man-pages)
		$(meson_feature video)
		$(meson_feature vaapi)
		$(meson_feature zstd)
	)
	meson_src_configure
}
