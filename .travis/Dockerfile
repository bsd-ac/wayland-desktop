FROM jannik2099/gentoo:devtools
ARG REPOPATH
COPY gentoo-master /var/db/repos/gentoo/
ADD overlay.tar ${REPOPATH}
COPY overlay.conf /etc/portage/repos.conf/

