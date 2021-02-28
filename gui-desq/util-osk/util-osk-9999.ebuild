# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit meson

DESCRIPTION="Simple on screek keyboard for DesQ Shell"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/DesQUtils/OSK"
else
	COMMIT=2e4be7af8d271b7cd57e7321b0be9ba1aca2b973
	SRC_URI="https://gitlab.com/DesQ/DesQUtils/OSK/-/archive/${COMMIT}/OSK-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/OSK-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-cpp/gtkmm:3.0
	gui-libs/gtk-layer-shell
"
RDEPEND="${DEPEND}"
