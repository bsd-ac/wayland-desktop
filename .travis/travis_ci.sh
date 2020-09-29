#!/bin/bash

# wrapper for running 
# - package tester - check if tests pass
# - spinner - repoman full -d checker

if [ ! -z "${REPOMAN+S}" ]; then
  exec python portage-portage-${PORTAGE_VER}/repoman/bin/repoman full -dx
elif [ ! -z "${PKGCHECK+S}" ]; then
  exec pkgcheck scan
else
	exec .travis/package_tester.sh
fi
