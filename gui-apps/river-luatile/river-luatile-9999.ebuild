# Copyright 2023 Maxim Chizhov
# Distributed under the terms of the ISC License

EAPI=8

CRATES="
"

inherit cargo

DESCRIPTION="Write your own river layout generator in lua"
HOMEPAGE="https://github.com/MaxVerevkin/river-luatile"

if [ ${PV} = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MaxVerevkin/river-luatile"
else
	SRC_URI="
		https://github.com/MaxVerevkin/river-luatile/archive/v${PV}.tar.gz -> ${PN}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3 MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"

QA_FLAGS_IGNORED="usr/bin/river-luatile"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_install() {
	cargo_src_install

	dodoc README.md

	docinto examples
	dodoc layout.lua
}

pkg_postinst() {
	elog "Please read /usr/share/doc/${PF}/README.md"
	elog "You may also want to check out layout example at"
	elog "/usr/share/doc/${PF}/layout.lua"
}
