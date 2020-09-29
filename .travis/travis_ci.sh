#!/bin/bash

# wrapper for running 
# - package tester - check if tests pass
# - spinner - repoman full -d checker

if [ -z "${REPOMAN+S}" ]; then
	exec .travis/package_tester.sh
else
  exec ../spinner.sh "python ../portage-portage-${PORTAGE_VER}/repoman/bin/repoman full -d"
fi
