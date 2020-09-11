# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="general logout scripts for wayland compositors"

HOMEPAGE="https://github.com/soreau/wayland-logout"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/soreau/wayland-logout"
else
	SRC_URI="https://github.com/soreau/wayland-logout/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="c +python shell"
REQUIRED_USE="^^ ( c python shell )"

RDEPEND="shell? ( sys-process/lsof )"

src_install() {
	exeinto /usr/share/wayland-logout/
	doexe "${BUILD_DIR}"/wayland-logout
	doexe "${S}"/wayland-logout.{py,sh}
	if use c; then
		dosym ../share/wayland-logout/wayland-logout /usr/bin/wayland-logout
	elif use python; then
		dosym ../share/wayland-logout/wayland-logout.py /usr/bin/wayland-logout
	elif use shell; then
		dosym ../share/wayland-logout/wayland-logout.sh /usr/bin/wayland-logout
	fi
}
