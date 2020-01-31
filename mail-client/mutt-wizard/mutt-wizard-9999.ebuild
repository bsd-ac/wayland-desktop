# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A system for automatically configuring mutt and isync with a simple interface and safe passwords"
HOMEPAGE="https://github.com/LukeSmithxyz/mutt-wizard"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/LukeSmithxyz/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/LukeSmithxyz/${PN}/archive/${PV}.tar.xz -> ${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="notmuch "

DEPEND="mail-client/neomutt
		net-mail/isync
		mail-mta/msmtp
		app-admin/pass
		notmuch ? (net-mail/notmuch)
		lynx ? (www-client/lynx)
		libnotify ? (x11-libs/libnotify)
		abook ? (app-misc/abook)
		gpg ? (app-crypt/gnupg)
		"
BDEPEND="net-mail/isync
		app-admin/pass
		"
