
EAPI=7

DESCRIPTION="wayland compositing library"
HOMEPAGE="https://github.com/rdkcmf/westeros"

inherit autotools

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rdkcmf/westeros"
else
	SRC_URI="https://github.com/rdkcmf/westeros/archive/Westeros-${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/Westeros-${PV}
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="modules opengl xdgv5"

RDEPEND="
	gui-libs/wlroots
	x11-libs/libxkbcommon:=[X]
"

BDEPEND="
	${RDEPEND}
	>=dev-libs/wayland-protocols-1.14
	virtual/pkgconfig
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-app
		--enable-player
		--enable-sbprotocol
		--enable-ldbprotocol
		--enable-xdgv4
		--enable-xdgv5
		$(use_enable opengl rendergl)
		$(use_enable modules)
	)
	econf "${myconf[@]}"
}
