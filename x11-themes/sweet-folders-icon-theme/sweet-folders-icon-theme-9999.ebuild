
EAPI="7"

inherit xdg-utils

DESCRIPTION="sweet gradient icons"

HOMEPAGE="https://github.com/EliverLara/Sweet-folders"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/EliverLara/Sweet-folders.git"
else
	COMMIT="d50fbe3d93df4c494958c773b681ab36049935a1"
	SRC_URI="https://github.com/EliverLara/Sweet-folders/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/Sweet-folders-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"

src_prepare() {
	default
	find . -xtype l -delete || die
	for if in Sweet-*/index.theme; do
		sed -e "/^Inherits/d" -i ${if} || die
	done
}

src_install() {
	insinto /usr/share/icons/
	doins -r Sweet-*
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
