# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="DesQ library for X/Wayland protocol handling"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/libdesq"
else
	COMMIT=14c72cd3ca4d86bab4f520d1ae45e390e0f117b8
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
	dev-qt/qtwidgets:5[X]
"
RDEPEND="${DEPEND}"
