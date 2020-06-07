# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
${P}
"

inherit cargo

DESCRIPTION="minimalistic login greeter daemon"
HOMEPAGE="https://man.sr.ht/%7Ekennylevinsen/greetd/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~kennylevinsen/greetd"
else
	SRC_URI="$(cargo_crate_uris ${CRATES})"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
ISUE="+man"

BDEPEND="
	man? ( app-text/scdoc )
"
