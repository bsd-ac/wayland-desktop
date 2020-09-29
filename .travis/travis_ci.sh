#!/bin/bash

# wrapper for running 
# - package tester - check if tests pass
# - spinner - repoman full -d checker

if [ -z ${PACKAGE+S} ]; then
  exec ../spinner.sh "python ../portage-portage-${PORTAGE_VER}/repoman/bin/repoman full -d"
else
	exec .travis/package_tester.sh
fi
