# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

DESCRIPTION="fully programmable wayland compositor"
HOMEPAGE="https://github.com/buffet/kiwmi"

inherit meson

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/buffet/kiwmi"
else
	COMMIT=c7a60fe2e8938d4e50bf39aeaa09df2ad25babe7
	SRC_URI="https://github.com/buffet/kiwmi/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MPL-2.0"
SLOT="0"

RDEPEND="
	gui-libs/wlroots[X]
	dev-lang/lua:=
"

BDEPEND="
	${RDEPEND}
	>=dev-libs/wayland-protocols-1.14
	virtual/pkgconfig
"
