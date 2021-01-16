EAPI=7

inherit cmake

DESCRIPTION="shared cmake configuration utils for liri"
HOMEPAGE="https://github.com/lirios/cmake-shared"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lirios/cmake-shared"
else
	COMMIT=071ec5dbbedafa48fe8d80e9bd627ed318a5014f
	SRC_URI="https://github.com/lirios/cmake-shared/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/cmake-shared-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

PATCHES=( "${FILESDIR}"/${PN}-0-libdir.patch )
