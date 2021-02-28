# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit cmake

DESCRIPTION="Power Daemon for DesQ"
HOMEPAGE="https://desq-project.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/DesQ/DesQUtils/PowerDaemon"
else
	COMMIT=2e71fbbb97b78af1f411590bd66af7928efe88c5
	SRC_URI="https://gitlab.com/DesQ/DesQUtils/PowerDaemon/-/archive/${COMMIT}/PowerDaemon-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/PowerDaemon-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
"
RDEPEND="${DEPEND}"
