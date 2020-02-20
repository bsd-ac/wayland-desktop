# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A compiz like 3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wf-shell"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WayfireWM/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/WayfireWM/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="~gui-apps/wf-config-0.3
	dev-cpp/gtkmm:3.0[wayland]
	>=dev-libs/gtk-layer-shell-0.1
"

BDEPEND="virtual/pkgconfig
	dev-libs/wayland-protocols
	dev-libs/gobject-introspection
"
