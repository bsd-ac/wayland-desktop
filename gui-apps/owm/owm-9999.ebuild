# Copyright 2023 Maxim Chizhov
# Distributed under the terms of the ISC License

EAPI=8

CRATES="
"

inherit cargo git-r3

DESCRIPTION="An experimental River layout generator using mathematical optimization to invent layouts on-the-fly"
HOMEPAGE="https://github.com/justinlovinger/owm"
EGIT_REPO_URI="https://github.com/justinlovinger/owm"

LICENSE="MIT ISC Unicode-DFS-2016"
SLOT="0"

QA_FLAGS_IGNORED="usr/bin/owm"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_configure() {
	cargo_src_configure --frozen
}

src_install() {
	cargo_src_install

	dodoc README.md
}

pkg_postinst() {
	elog "Check out owm --help for configuration options"
	elog "You may also want to add these lines to your river init:"
	elog "riverctl default-layout owm"
	elog "owm &"
}
