# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="session manager for DesQ"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/Session"
else
	COMMIT=3af014db286439d30b0bf54e6a03e13ae7e998ca
	SRC_URI="https://gitlab.com/DesQ/Session/-/archive/${COMMIT}/Session-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/Session-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	gui-desq/libdesq
	gui-desq/libdesqwl
	x11-libs/libxcb[xkb]
"
RDEPEND="${DEPEND}
	gui-desq/desq-shell
	gui-desq/util-settingsdaemon
	gui-wm/wayfire
"
