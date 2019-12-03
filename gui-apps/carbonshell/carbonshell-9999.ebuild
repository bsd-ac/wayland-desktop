# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="The default shell of carbonOS"
HOMEPAGE="https://bitbucket.org/carbonOS/carbonshell"


if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://bitbucket.org/carbonOS/carbonshell.git"
  KEYWORDS=""
else
	SRC_URI="https://bitbucket.org/carbonOS/carbonshell/${PV}.tar.gz -> ${P}.tar.gz"
  KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	~gui-wm/wayfire-9999
	dev-libs/flatbuffers
	dev-libs/libdazzle[vala]
	dev-libs/pugixml
	dev-libs/gtkd
	dev-libs/libhandy
	dev-libs/libfmt
	~dev-libs/gtk-layer-shell-9999
"

RDEPEND="
	dev-libs/wayland-protocols
"
