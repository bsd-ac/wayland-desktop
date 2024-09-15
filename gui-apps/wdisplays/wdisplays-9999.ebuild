# Copyright 2020-2024 Jason André Charles Gantner
# Distributed under the terms of the ISC License

EAPI=8

inherit git-r3 meson

DESCRIPTION="wdisplays is a wayland app for configuring displays in compositors."
HOMEPAGE="https://github.com/artizirk/wdisplays"
EGIT_REPO_URI="https://github.com/artizirk/${PN}.git"

LICENSE="MIT GPL-3+ CC0-1.0 CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+scour"

DEPEND="
	>=x11-libs/gtk+-3.24
	media-libs/libepoxy
	dev-libs/wayland"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/meson
	>=dev-libs/wayland-protocols-1.17
	dev-util/wayland-scanner
	scour? ( media-gfx/scour )"
