# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="A system for automatically configuring mutt and isync"
HOMEPAGE="https://github.com/LukeSmithxyz/mutt-wizard"

EGIT_REPO_URI="https://github.com/LukeSmithxyz/${PN}.git"
COMMIT=d8f57b57f6e4f7d07969a26775686b45b0e2b565
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"
IUSE="+notmuch links +w3m lynx +libnotify +abook +gpg +cron +imagemagick"

DEPEND="mail-client/neomutt:=[notmuch=]
	net-mail/isync
	mail-mta/msmtp
	app-admin/pass
	cron? ( virtual/cron )
	imagemagick? ( media-gfx/imagemagick )
	lynx? ( www-client/lynx )
	links? ( www-client/links )
	w3m? ( www-client/w3m )
	libnotify? ( x11-libs/libnotify )
	abook? ( app-misc/abook )
	gpg? ( app-crypt/gnupg )
"

RDEPEND="
	${DEPEND}
"

BDEPEND="net-mail/isync
	app-admin/pass
"

src_compile() {
	return 0;
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
	einstalldocs
}
