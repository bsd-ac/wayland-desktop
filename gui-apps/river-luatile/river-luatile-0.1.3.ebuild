# Copyright 2023 Maxim Chizhov
# Distributed under the terms of the ISC License

EAPI=8

CRATES="
	aho-corasick@1.0.1
	autocfg@1.1.0
	bitflags@1.3.2
	bstr@0.2.17
	cc@1.0.79
	cfg-if@1.0.0
	convert_case@0.6.0
	dirs@5.0.1
	dirs-sys@0.4.1
	env_logger@0.10.0
	errno@0.3.1
	errno-dragonfly@0.1.2
	getrandom@0.2.9
	hermit-abi@0.3.1
	humantime@2.1.0
	io-lifetimes@1.0.10
	is-terminal@0.4.7
	libc@0.2.143
	linux-raw-sys@0.3.7
	log@0.4.17
	memchr@2.5.0
	memoffset@0.7.1
	mlua@0.8.8
	nix@0.26.2
	num-traits@0.2.15
	once_cell@1.17.1
	option-ext@0.2.0
	pkg-config@0.3.27
	proc-macro2@1.0.56
	quick-xml@0.28.2
	quote@1.0.26
	redox_syscall@0.2.16
	redox_users@0.4.3
	regex@1.8.1
	regex-syntax@0.7.1
	river-layout-toolkit@0.1.4
	rustc-hash@1.1.0
	rustix@0.37.19
	static_assertions@1.1.0
	syn@2.0.15
	termcolor@1.2.0
	thiserror@1.0.40
	thiserror-impl@1.0.40
	unicode-ident@1.0.8
	unicode-segmentation@1.10.1
	wasi@0.11.0+wasi-snapshot-preview1
	wayrs-client@0.10.4
	wayrs-scanner@0.10.3
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-targets@0.48.0
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.48.0
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
