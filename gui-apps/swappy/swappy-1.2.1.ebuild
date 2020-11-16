
EAPI=7

inherit meson xdg-utils

DESCRIPTION="wayland native snapshot editing tool"
HOMEPAGE="https://github.com/jtheoof/swappy"

MY_PV=$(ver_rs 2 '-')
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jtheoof/swappy"
else
	SRC_URI="https://github.com/jtheoof/swappy/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+libnotify man"

DEPEND="
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/pango
	libnotify? ( x11-libs/libnotify )
"
RDEPEND="${DEPEND}
	gui-apps/grim
"
BDEPEND="
	virtual/pkgconfig
	man? ( app-text/scdoc )
"

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
		$(meson_feature libnotify)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
