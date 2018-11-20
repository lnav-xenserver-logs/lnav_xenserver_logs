#!/bin/bash
# Tests the format files using lnav. Run this from the repository root.

set -uex

# This branch and test is for the 0.8.X versions of lnav
[[ "$(lnav -V)" == lnav\ 0.8* ]]

# If we have the latest lnav version, check that there are no warnings
test "$(lnav -V)" == "lnav 0.8.4" && \
  (! (lnav -C |& grep "^warning:"))

lnav -C

# Test that the different fields are extracted correctly

# Test xensource.log
# Test the main format
lnav -qn -c ';select log_time,log_hostname,log_procname,xapi_timestamp,log_level,xapi_hostname,threadid,origin,task,module from xensource_log' -c ':write-csv-to /tmp/out.csv' ./test/xensource_log/main_format/xensource.log
diff /tmp/out.csv test/xensource_log/main_format/expected_matches.csv
# Test the module format
lnav -qn -c ';select xapi_timestamp,level,xapi_hostname,threadid,origin,task,module from xensource_log_module_format' -c ':write-csv-to /tmp/out.csv' ./test/xensource_log/module_format/syslog
diff /tmp/out.csv test/xensource_log/module_format/expected_matches.csv

# Test xenrt.log
lnav -qn -c ';select log_time,log_level,log_body from xenrt_log' -c ':write-csv-to /tmp/out.csv' ./test/xenrt_log/xenrt.log
diff /tmp/out.csv test/xenrt_log/expected_matches.csv
