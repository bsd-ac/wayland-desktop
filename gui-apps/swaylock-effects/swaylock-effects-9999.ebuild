# Copyright 2021 Aisha Tammy, Ichika Zou
# Distributed under the terms of the ISC License

EAPI=8

inherit bash-completion-r1 meson

DESCRIPTION="Screen locker for Wayland"
HOMEPAGE="https://github.com/jirutka/swaylock-effects"

MY_PV=$(ver_rs 2 '-')
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jirutka/swaylock-effects.git"
else
	SRC_URI="https://github.com/jirutka/swaylock-effects/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${MY_PV}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="zsh-completion +gdk-pixbuf pam +man cpu_flags_x86_sse"

DEPEND="
	dev-libs/wayland
	x11-libs/cairo
	x11-libs/libxkbcommon
	gdk-pixbuf? ( x11-libs/gdk-pixbuf:2 )
	pam? ( sys-libs/pam )
"
RDEPEND="${DEPEND}
	!gui-apps/swaylock
"
BDEPEND="
	app-text/scdoc
	>=dev-libs/wayland-protocols-1.14
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		-Dman-pages=$(usex man enabled disabled)
		-Dpam=$(usex pam enabled disabled)
		-Dgdk-pixbuf=$(usex gdk-pixbuf enabled disabled)
		$(meson_use zsh-completion zsh-completions)
		"-Dbash-completions=true"
		"-Dwerror=false"
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	newbashcomp completions/bash/swaylock swaylock
	insinto /usr/share/zsh/site-functions
	doins completions/zsh/_swaylock
	if ! use pam; then
		fowners root:0 ${ED}/bin/swaylock
		fperms 4511 ${ED}/bin/swaylock
	fi
}
