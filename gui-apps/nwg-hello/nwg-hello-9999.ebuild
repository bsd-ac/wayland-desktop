# Copyright 2024 Aisha Tammy <floss@bsd.ac>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="GTK3-based greeter for greetd."
HOMEPAGE="https://github.com/nwg-piotr/nwg-hello"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/nwg-hello.git"
else
	SRC_URI="https://github.com/nwg-piotr/nwg-hello/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	gui-libs/greetd
	gui-libs/gtk-layer-shell
"

python_install_all() {
	distutils-r1_python_install_all

	insinto "/etc/nwg-hello"
	doins nwg-hello-default.json nwg-hello-default.css hyprland.conf \
		sway-config
	insinto "/usr/share/nwg-hello"
	doins nwg.jpg
	doins img/*
	insinto "/var/cache/nwg-hello"
	doins cache.json
	fowners root:greetd "/var/cache/nwg-hello"
	fperms 775 "/var/cache/nwg-hello"
	fowners greetd:greetd "/var/cache/nwg-hello/cache.json"
	fperms 664 "/var/cache/nwg-hello/cache.json"
}
