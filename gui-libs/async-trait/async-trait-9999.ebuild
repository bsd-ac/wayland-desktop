# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="minimalistic login greeter daemon"
HOMEPAGE="https://github.com/dtolnay/async-trait"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dtolnay/async-trait"
else
	SRC_URI="https://github.com/dtolnay/async-trait/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT Apache-2.0"
SLOT="0"
