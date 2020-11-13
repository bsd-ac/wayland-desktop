
EAPI=7

inherit meson

DESCRIPTION="simple gtk launchers for X and wlroots compositors"
HOMEPAGE="https://github.com/nwg-piotr/nwg-launchers"

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/nwg-launchers.git"
else
	SRC_URI="https://github.com/nwg-piotr/nwg-launchers/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3 CC-BY-SA-3.0"
SLOT="0"
IUSE="+bar +dmenu +grid"

RDEPEND="
	x11-libs/gtk+:3
	dev-cpp/gtkmm:3.0
	dev-cpp/nlohmann_json
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use bar)
		$(meson_use dmenu)
		$(meson_use grid)
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	insinto /usr/share/icons/nwg-launchers
	doins -r "${FILESDIR}"/.
}
