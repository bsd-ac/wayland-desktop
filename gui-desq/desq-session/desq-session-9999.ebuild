# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit qmake-utils

DESCRIPTION="session manager for DesQ"

HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/Session"
else
	COMMIT=c37acd1812e3f6e146be38c0595c7195c8c0a3ab
	SRC_URI="https://gitlab.com/DesQ/Session/-/archive/${COMMIT}/Session-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/Session-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	gui-desq/libdesq:=
	gui-desq/libdesqwl:=
	x11-libs/libxcb[xkb]
"
RDEPEND="${DEPEND}
	gui-desq/desq-shell
	gui-desq/desq-settings
	gui-wm/wayfire
"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	sed -e "/LIBDIR = \$\$PREFIX\/lib\//s/lib/$(get_libdir)/" \
		-i Session.pro || die
	default
}

src_compile() {
	eqmake5 Session.pro
	default
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
}
