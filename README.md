# lnav format file for XenServer logs
[![Build Status](https://travis-ci.org/lnav-xenserver-logs/lnav_xenserver_logs.svg?branch=master)](https://travis-ci.org/lnav-xenserver-logs/lnav_xenserver_logs)

This is a [lnav](http://lnav.org/) [format
file](https://lnav.readthedocs.io/en/latest/formats.html) for the log files on
[XenServer](http://xenserver.org/). It is written for the log format of the
"trunk" (latest development) version of
[xapi](https://xapi-project.github.io/), and for the latest (0.8) version of
lnav. To check which version of lnav is installed, run `lnav -V`.

It currently supports the following log files on a XenServer host:

- /var/log/xensource.log
- /var/log/audit.log

(And of course, it supports the rotated versions of these log files as well.)

## Installing the format file

Follow the [installation instructions in the lnav
documentation](https://lnav.readthedocs.io/en/latest/formats.html#installing-formats).
The easiest method is to install the format file from this git repository using
the `-i` option, as explained in the documentation.

## License

This repo uses the same 2-Clause BSD License (or "Simplified BSD License" or "FreeBSD
License") as lnav.

Some of the code comes from the [lnav
repository](https://github.com/tstack/lnav); I took the first part of the
`xensource_log` regex from the default syslog lnav format, due to the
similarities, and then simplified it.
