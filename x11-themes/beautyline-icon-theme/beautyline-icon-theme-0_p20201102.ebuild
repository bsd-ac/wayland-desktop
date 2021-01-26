EAPI="7"

inherit xdg-utils

DESCRIPTION="BeautyLine Icons Theme"

HOMEPAGE="https://www.gnome-look.org/p/1425426"
SRC_URI="BeautyLine.tar.gz"
KEYWORDS="~amd64"
S="${WORKDIR}"/BeautyLine

# can't seem to find a license
LICENSE="all-rights-reserved"
SLOT="0"
RESTRICT="fetch"

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
	sed -e "/^Inherits/d" -i index.theme || die
	# gentoo specific changes
	ln -s Zoom.svg "${S}"/apps/scalable/zoom-videocam.svg || die
}

src_install() {
	insinto /usr/share/icons/BeautyLine
	doins -r index.theme actions \
		apps devices mimetypes places
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
