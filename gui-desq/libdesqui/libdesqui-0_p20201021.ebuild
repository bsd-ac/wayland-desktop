# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit qmake-utils

DESCRIPTION="DesQ library for UI elements"

HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/libdesqui"
else
	COMMIT=b97a042ac712999ee43675b17c210b3b48a36a78
	SRC_URI="https://gitlab.com/DesQ/libdesqui/-/archive/${COMMIT}/libdesqui-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/libdesqui-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5[X]
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5[X]
	gui-desq/libdesq:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	sed -e "/LIBDIR = \$\$PREFIX\/lib\//s/lib/$(get_libdir)/" \
		-i DesQUI.pro || die
	default
}

src_compile() {
	eqmake5 DesQUI.pro
	default
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
}
