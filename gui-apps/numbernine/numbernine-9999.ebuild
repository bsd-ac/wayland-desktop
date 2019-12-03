# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="[WIP] desktop 'environment'"
HOMEPAGE="https://github.com/myfreeweb/numbernine"


if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/myfreeweb/numbernine.git"
  KEYWORDS=""
else
	SRC_URI="https://github.com/Alexays/Waybar/archive/${PV}.tar.gz -> ${P}.tar.gz"
  KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="Unlicense"
SLOT="0"
IUSE=""

DEPEND="
	~gui-wm/wayfire-9999
	dev-libs/flatbuffers
	dev-libs/pugixml
	dev-libs/gtkd
	dev-libs/libhandy
	dev-libs/libfmt
	~dev-libs/gtk-layer-shell-9999
"

RDEPEND="
	dev-libs/wayland-protocols
"
