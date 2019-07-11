# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Highly customizable Wayland bar for Sway and Wlroots based compositors."
HOMEPAGE="https://github.com/Alexays/Waybar"


if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Alexays/Waybar.git"
else
	SRC_URI="https://github.com/Alexays/Waybar/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/Waybar-${PV}
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="+netlink +mpd +pulseaudio +tray +udev"

RDEPEND="
		>=dev-libs/libfmt-5.3.0
		>=dev-libs/spdlog-1.3.1
		sys-libs/libcap
		dev-libs/libappindicator
		dev-libs/libinput
		dev-libs/wayland
		dev-cpp/gtkmm:3.0
		media-fonts/fontawesome
		tray? (
				dev-libs/libdbusmenu:=[gtk3]
				dev-libs/glib
		)
		dev-libs/jsoncpp
		dev-libs/libsigc++:2
		netlink? ( dev-libs/libnl:3 )
		pulseaudio? ( media-sound/pulseaudio )
		mpd? ( media-libs/libmpdclient )
"

DEPEND="${RDEPEND}
		dev-libs/wayland-protocols
"



src_configure() {
	local emesonargs=(
		$(meson_feature network libnl)
		$(meson_feature udev libudev)
		$(meson_feature pulseaudio)
		$(meson_feature tray dbusmenu-gtk)
		$(meson_feature mpd)
	)

	meson_src_configure
}
