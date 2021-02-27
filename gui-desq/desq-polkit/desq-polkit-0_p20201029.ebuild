# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit qmake-utils

DESCRIPTION="polkit auth backend for DesQ"

HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/DesQUtils/PolkitExec"
else
	COMMIT=93418cb1570d7bd343957f3d2896dec05676e37f
	SRC_URI="https://gitlab.com/DesQ/DesQUtils/PolkitExec/-/archive/${COMMIT}/PolkitExec-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/PolkitExec-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_compile() {
	eqmake5 desq-pkit.pro
	emake
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
}
