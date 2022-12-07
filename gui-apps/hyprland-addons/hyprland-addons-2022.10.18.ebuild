# Copyright 2022 Julien Roy <julien@jroy.ca>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="Community scripts and utilities for Hypr projects"
HOMEPAGE="https://github.com/hyprwm/contrib/"

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/hyprwm/contrib.git/"
	inherit git-r3
else
	COMMIT="5b21c74a3200ffdd48ed7764c7041d43c3cd5588"
	SRC_URI="https://github.com/hyprwm/contrib/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/contrib-${COMMIT}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+grimblast +shellevents"
REQUIRED_USE="|| ( grimblast shellevents )"

RDEPEND="
	app-misc/jq
	gui-apps/grim
	gui-apps/slurp
	gui-apps/wl-clipboard
	gui-wm/hyprland
	x11-libs/libnotify
"

BDEPEND="app-text/scdoc"

src_install() {
	if use grimblast ; then
		emake PREFIX="${ED}/usr" -C grimblast install
	fi

	if use shellevents ; then
		emake PREFIX="${ED}/usr" -C shellevents
	fi
}
