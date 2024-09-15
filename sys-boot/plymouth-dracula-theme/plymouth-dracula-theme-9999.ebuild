# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="dracula theme for plymouth"
HOMEPAGE="https://github.com/dracula/plymouth"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dracula/plymouth"
else
	COMMIT="37aa09b27ecee4a825b43d2c1d20b502e8f19c96"
	SRC_URI="https://github.com/dracula/plymouth/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/dracula-plymouth-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/plymouth/themes
	doins -r dracula
}
