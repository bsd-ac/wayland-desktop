# Copyright 2025 B. Gazotti
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="A collection of libraries which implement some freedesktop.org specifications"
HOMEPAGE="https://gitlab.freedesktop.org/vyivel/libsfdo"
SRC_URI="https://gitlab.freedesktop.org/vyivel/libsfdo/-/archive/v${PV}/libsfdo-v${PV}.tar.bz2"

# necessary because packaged dir contains a v before version number
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-build/meson
	virtual/pkgconfig
"

inherit meson
