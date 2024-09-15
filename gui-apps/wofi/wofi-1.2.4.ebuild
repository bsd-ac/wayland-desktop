# SPDX-License-Identifier: GPL-2.0 OR ISC
# Copyright 2020-2024 Jason André Charles Gantner
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="A lancher/menu program for wlroots based compositors"
HOMEPAGE="https://hg.sr.ht/~scoopta/wofi"
SRC_URI="https://hg.sr.ht/~scoopta/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="+run +drun +dmenu"
REQUIRED_USE="|| ( run drun dmenu )"

DEPEND="x11-libs/gtk+ dev-libs/wayland"
RDEPEND="${DEPEND}"
BDEPEND="dev-build/meson virtual/pkgconfig"

src_configure(){
	meson_src_configure $(meson_use run enable_run) $(meson_use drun enable_drun) $(meson_use dmenu enable_dmenu)
}
