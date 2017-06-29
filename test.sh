#!/bin/bash
set -uex

[[ "$(lnav -V)" == lnav\ 0.8* ]]
test "$(lnav -V)" == "lnav 0.8.2" && \
  (! (lnav-0.8.2/lnav |& grep "^warning:"))
lnav -C
