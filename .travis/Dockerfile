FROM jannik2099/gentoo:devtools
ARG REPOPATH
RUN emerge-webrsync -q
ADD overlay.tar ${REPOPATH}
COPY overlay.conf /etc/portage/repos.conf/
