# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit xdg

DESCRIPTION="gradient icons inspired by linebit"
HOMEPAGE="https://www.gnome-look.org/p/1330383/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://www.opencode.net/adhe/hey-icons"
else
	COMMIT="a5ac75ff6783fe25a301b0b3bd90a86839b265c5"
	SRC_URI="https://www.opencode.net/adhe/hey-icons/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/hey-icons-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="no-inherit"

# dead symbolic links QA
src_prepare() {
	default
	find . -xtype l -delete || die
	mv index-dark.theme index.theme || die
	# pico wayfire specific changes
	use no-inherit && sed -e "/^Inherits/d" -i index.theme || die
}

src_install() {
	insinto /usr/share/icons/hey-icons
	doins -r index.theme 16 22 32 48 64
}
