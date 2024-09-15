# SPDX-License-Identifier: GPL-2.0 OR ISC
# Copyright 2020-2024 Jason André Charles Gantner
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="Wayland Overlay Bar"
HOMEPAGE="https://github.com/francma/wob"
SRC_URI="https://github.com/francma/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"
IUSE="+man seccomp test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/wayland
	dev-libs/inih
	seccomp? ( sys-libs/libseccomp )
	test? ( dev-util/cmocka )
	"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/meson
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	man? ( >=app-text/scdoc-1.9.2 )
	"
src_configure (){
	local emesonargs=(
		$(meson_feature seccomp)
		$(meson_feature man man-pages)
	)
	meson_src_configure
}
