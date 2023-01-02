# Copyright 2022 Julien Roy <julien@jroy.ca>
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="xdg-desktop-portal backend for hyprland"
HOMEPAGE="https://github.com/hyprwm/xdg-desktop-portal-hyprland"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/hyprwm/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/hyprwm/${PN}/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
fi

LICENSE="BSD"
SLOT="0"
IUSE="elogind systemd"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="
	dev-libs/inih
	dev-libs/wayland
	dev-qt/qtbase
	dev-qt/qtwayland:6
	media-libs/mesa
	>=media-video/pipewire-0.3.41:=
	x11-libs/libdrm
	|| (
		systemd? ( >=sys-apps/systemd-237 )
		elogind? ( >=sys-auth/elogind-237 )
		sys-libs/basu
	)
"
# mesa is needed for gbm dep (which it hards sets to 'on')
RDEPEND="
	${DEPEND}
	sys-apps/xdg-desktop-portal
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.24
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=()

	if use systemd; then
		emesonargs+=(-Dsd-bus-provider=libsystemd)
	elif use elogind; then
		emesonargs+=(-Dsd-bus-provider=libelogind)
	else
		emesonargs+=(-Dsd-bus-provider=basu)
	fi
	meson_src_configure
}

src_compile() {
	meson_src_compile
	emake -C hyprland-share-picker all
}

src_install() {
	meson_src_install
	dobin "${S}/hyprland-share-picker/build/hyprland-share-picker"
}
