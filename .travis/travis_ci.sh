#!/bin/bash

# wrapper for running 
# - package tester - check if tests pass
# - spinner - repoman full -d checker

if [ -z "${REPOMAN+S}" && -z "${PKGCHECK+S}" ]; then
	exec .travis/package_tester.sh
elif [ -z "${REPOMAN+S}" ]; then
  exec python portage-portage-${PORTAGE_VER}/repoman/bin/repoman full -dx
else
  exec pkgcheck scan
fi
