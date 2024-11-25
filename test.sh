#!/bin/bash
# Tests the format files using lnav. Run this from the repository root.

set -uex

# If we have the latest lnav version, check that there are no warnings
CURR_VERSION=$(lnav -V | sed -e 's/lnav //')

if [[ $(echo -e "0.10.0\n$CURR_VERSION" | sort -V | head -n1) != "$CURR_VERSION" ]]; then
  (! (lnav -C |& grep "^warning:"))
else
  lnav -C
fi

# Test that the different fields are extracted correctly

# Test xensource.log
# Test the main format
# Update the modification time of the log file, to match the behaviour of Travis, where the file is always fresh,
# because there is not year in this timestamp format so lnav figures out the date based on the file's timestamp.
touch ./test/xensource_log/main_format/xensource.log
lnav -qn -c ';select log_time,log_hostname,log_procname,xapi_timestamp,log_level,xapi_hostname,threadid,origin,task,module from xensource_log' -c ':write-csv-to /tmp/out.csv' ./test/xensource_log/main_format/xensource.log
sed "s/#year#/$(date +%Y)/" test/xensource_log/main_format/expected_matches.csv > /tmp/expected_matches.csv
diff /tmp/out.csv /tmp/expected_matches.csv
# Test the module format
lnav -qn -c ';select xapi_timestamp,level,xapi_hostname,threadid,origin,task,module from xensource_log_module_format' -c ':write-csv-to /tmp/out.csv' ./test/xensource_log/module_format/syslog
diff /tmp/out.csv test/xensource_log/module_format/expected_matches.csv

# Test xenrt.log
lnav -qn -c ';select log_time,log_level from xenrt_log' -c ':write-csv-to /tmp/out.csv' ./test/xenrt_log/xenrt.log
diff /tmp/out.csv test/xenrt_log/expected_matches.csv
