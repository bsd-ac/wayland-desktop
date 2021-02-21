# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit xdg

DESCRIPTION="BeautyLine Icons Theme"
HOMEPAGE="https://www.gnome-look.org/p/1425426"
SRC_URI="mirror://bsd.ac/${P}.tar.gz"
KEYWORDS="~amd64"
S="${WORKDIR}"/BeautyLine

# can't seem to find a license
LICENSE="all-rights-reserved"
SLOT="0"
IUSE="+no-inherit"

pkg_pretend() {
	elog "download the package manually from"
	elog "\t ${HOMEPAGE}"
	elog "and put it in ${DISTDIR}"
}

# dead symbolic links QA
src_prepare() {
	default
	find . -xtype l -delete || die
	mv mimetypes/scalable/application-vnd.oasis.opendocument.text-master.svg{ln,} || die
	rm apps/scalable/goa-account-msn* || die
	# gentoo specific changes
	ln -s Zoom.svg "${S}"/apps/scalable/zoom-videocam.svg || die
	# pico wayfire specific changes
	use no-inherit && sed -e "/^Inherits/d" -i index.theme || die
}

src_install() {
	insinto /usr/share/icons/BeautyLine
	doins -r index.theme actions \
		apps devices mimetypes places
}
