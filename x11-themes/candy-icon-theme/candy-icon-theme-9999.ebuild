# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

inherit xdg

DESCRIPTION="sweet gradient icons"
HOMEPAGE="https://github.com/EliverLara/candy-icons"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/EliverLara/candy-icons.git"
else
	COMMIT="b8a2ca72e7182f23abf5a2c5d24d93c230de394a"
	SRC_URI="https://github.com/EliverLara/candy-icons/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/candy-icons-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="no-inherit"

# dead symbolic links QA
src_prepare() {
	default
	find . -xtype l -delete || die
	# pico wayfire specific changes
	if use no-inherit; then
		sed -e "/^Inherits/d" -i index.theme || die
	fi
	ln -s dropbox.svg apps/scalable/dropboxstatus-logo.svg || die
	ln -s zoom-desktop.svg apps/scalable/zoom-videocam.svg || die
	ln -s mupdf.svg apps/scalable/new-mupdf-icon.svg || die
}

src_install() {
	insinto /usr/share/icons/candy-icons
	doins -r index.theme apps devices places preferences preview
}
