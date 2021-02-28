# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="Simple dock for DesQ Shell"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/DesQUtils/Dock"
else
	COMMIT=685f90e8dd75907c1f807e547710461932584f98
	SRC_URI="https://gitlab.com/DesQ/DesQUtils/Dock/-/archive/${COMMIT}/Dock-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/Dock-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtwayland:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}"
