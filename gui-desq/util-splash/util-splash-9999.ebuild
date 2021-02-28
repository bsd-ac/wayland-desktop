# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="Session splash screen for DesQ"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/DesQUtils/Splash"
else
	COMMIT=f7f2375e4df06166abef5cbd01bf6a756531eaf7
	SRC_URI="https://gitlab.com/DesQ/DesQUtils/Splash/-/archive/${COMMIT}/Splash-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/Splash-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}"
