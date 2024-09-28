# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2-or-later

EAPI=8

DESCRIPTION="A collection of libraries which implement some freedesktop.org specifications"
HOMEPAGE="https://gitlab.freedesktop.org/vyivel/libsfdo"
SRC_URI="https://gitlab.freedesktop.org/vyivel/libsfdo/-/archive/v${PV}/libsfdo-v${PV}.tar.gz"

# necessary because packaged dir contains a v before version number
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/meson
	virtual/pkgconfig
"

inherit meson
