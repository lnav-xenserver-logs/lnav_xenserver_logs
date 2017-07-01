#!/bin/bash
set -uex

# This branch and test is for the 0.8.X versions of lnav
[[ "$(lnav -V)" == lnav\ 0.8* ]]

# If we have the latest lnav version, check that there are no warnings
test "$(lnav -V)" == "lnav 0.8.2" && \
  (! (lnav-0.8.2/lnav |& grep "^warning:"))

lnav -C
