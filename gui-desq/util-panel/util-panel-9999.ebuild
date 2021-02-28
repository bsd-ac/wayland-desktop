# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="Simple panel for DesQ"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/DesQUtils/Panel"
else
	COMMIT=beb7bfd7e9dfca0525153d0d4fe5ea5cb61a3de6
	SRC_URI="https://gitlab.com/DesQ/DesQUtils/Panel/-/archive/${COMMIT}/Panel-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/Panel-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtwidgets:5
	dev-qt/qtwayland:5
"
RDEPEND="${DEPEND}"
