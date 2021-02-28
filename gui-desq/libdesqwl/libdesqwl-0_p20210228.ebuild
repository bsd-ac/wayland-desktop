# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="DesQ library for additional Wayland protocol handling"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/libdesqwl"
else
	COMMIT=c60ba5a238c097a42fbce290702663cbb40bdc6f
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
"
RDEPEND="${DEPEND}"
