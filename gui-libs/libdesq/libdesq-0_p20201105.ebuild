
EAPI=7

inherit qmake-utils

DESCRIPTION="DesQ library for X/Wayland protocol handling"

HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/libdesq"
else
	COMMIT=070b841e2e529a3168901f9e66043ec2c08bbfb4
	SRC_URI="https://gitlab.com/DesQ/libdesq/-/archive/${COMMIT}/libdesq-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/libdesq-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtnetwork:5[ssl]
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	sed -e "/LIBDIR = \$\$PREFIX\/lib\//s/lib/$(get_libdir)/" \
		-i libdesq.pro || die
	default
}

src_compile() {
	eqmake5 libdesq.pro
	default
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
}
