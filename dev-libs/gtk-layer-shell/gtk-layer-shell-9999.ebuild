# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="A library to create panels and other desktop components for Wayland using the Layer Shell protocol"
HOMEPAGE="https://github.com/wmww/gtk-layer-shell"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/wmww/gtk-layer-shell.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/wmww/gtk-layer-shell/releases/download/v${PN}/${P}.tar.xz -> ${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi


LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=x11-libs/gtk+-3.24.1:3[introspection,wayland]
"

RDEPEND="${DEPEND}"

BDEPEND="
	virtual/pkgconfig
	dev-libs/wayland-protocols
"
