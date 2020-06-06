# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="image build for lxd and lxc"
HOMEPAGE="https://github.com/wizbright/waybox"

inherit golang-base

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxc/distrobuilder.git"
else
	SRC_URI="https://github.com/lxc/distrobuilder/archive/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"

BDEPEND="
	dev-util/debootstrap
	net-misc/rsync
	app-crypt/gnupg
	sys-fs/squashfs-tools
	dev-vcs/git
"
