
EAPI=7

inherit qmake-utils

DESCRIPTION="DesQ library for additional Wayland protocol handling"

HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/libdesqwl"
else
	COMMIT=cd1bdb629f20313e188b3a92abc5f38baed3396f
	SRC_URI="https://gitlab.com/DesQ/libdesqwl/-/archive/${COMMIT}/libdesqwl-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/libdesqwl-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtwayland:5[X]
	dev-libs/wayland
	gui-libs/libdesq:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	sed -e "/LIBDIR = \$\$PREFIX\/lib\//s/lib/$(get_libdir)/" \
		-i desq-wl/desq-wl.pro || die
	sed -e "/target.path = \/usr\/lib\//s/lib/$(get_libdir)/" \
		-i desq-layershell/interface/interface.pro || die
	default
}

src_compile() {
	eqmake5 libdesqwl.pro
	default
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
}
