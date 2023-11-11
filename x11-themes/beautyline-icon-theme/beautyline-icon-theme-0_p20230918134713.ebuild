# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit xdg

DESCRIPTION="BeautyLine Icons Theme"
HOMEPAGE="https://www.gnome-look.org/p/1425426"
SRC_URI="mirror://bsd.ac/${P}.tar.gz"
KEYWORDS="~amd64"
S="${WORKDIR}"/BeautyLine

LICENSE="GPL-3"
SLOT="0"
IUSE="no-inherit"

src_prepare() {
	default
	rm mimetypes/scalable/application-vnd.oasis.opendocument.text-master.svgln || die
	# dead symbolic links QA
	find . -xtype l -delete || die
	# pico wayfire specific changes
	mv './apps/scalable/java (1).svg' './apps/scalable/java_(1).svg' || die
	find . -type l -name "* *" | while read file; do mv "$file" ${file// /_}; done || die
	if use no-inherit; then
		sed -e "/^Inherits/d" -i index.theme || die
	fi
}

src_install() {
	insinto /usr/share/icons/BeautyLine
	doins -r index.theme actions \
		apps devices mimetypes places
}
