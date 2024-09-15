# Copyright 2020-2024 Jason André Charles Gantner
# Distributed under the terms of the ISC License

EAPI=7

inherit meson

DESCRIPTION="wdisplays is a wayland app for configuring displays in compositors."
HOMEPAGE="https://github.com/artizirk/wdisplays"
# Original git repo now disappeared
SRC_URI="https://github.com/artizirk/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT GPL-3+ CC0-1.0 CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+scour"

DEPEND="
	>=x11-libs/gtk+-3.24[wayland]
	media-libs/libepoxy
	dev-libs/wayland
	"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/meson
	>=dev-libs/wayland-protocols-1.17
	dev-util/wayland-scanner
	scour? ( media-gfx/scour )
	"
