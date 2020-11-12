# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fcaps meson

DESCRIPTION="Screen locker for Wayland"
HOMEPAGE="https://github.com/mortie/swaylock-effects"

MY_PV=$(ver_rs 2 '-')
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mortie/swaylock-effects.git"
else
	SRC_URI="https://github.com/mortie/swaylock-effects/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="fish-completion +gdk-pixbuf +man +pam zsh-completion"

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
	>=dev-libs/wayland-protocols-1.14
	virtual/pkgconfig
	man? ( app-text/scdoc )
"

src_prepare() {
	default
	sed -e "/werror=true/d" \
	    -e "/mtune=native/d" \
	    -e "/-O3/d" \
	    -i meson.build || die
}

src_configure() {
	local emesonargs=(
		-Dman-pages=$(usex man enabled disabled)
		-Dpam=$(usex pam enabled disabled)
		-Dgdk-pixbuf=$(usex gdk-pixbuf enabled disabled)
		$(meson_use fish-completion fish-completions)
		$(meson_use zsh-completion zsh-completions)
		"-Dbash-completions=true"
		"-Dwerror=false"
	)
	if [[ ${PV} != 9999 ]]; then
		emesonargs+=("-Dswaylock-version=${PV}")
	fi

	meson_src_configure
}

pkg_postinst() {
	if ! use pam; then
		fcaps cap_sys_admin usr/bin/swaylock
	fi
}
