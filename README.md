# lnav format file for XenServer logs
[![Build Status](https://travis-ci.org/gaborigloi/lnav_xenserver_logs.svg?branch=lnav_0.7)](https://travis-ci.org/gaborigloi/lnav_xenserver_logs)

This is a [lnav](http://lnav.org/) [format
file](https://github.com/tstack/lnav/blob/v0.7.3/docs/source/formats.rst) for
the log files on [XenServer](http://xenserver.org/). It is written for the log
format of the "trunk" (latest development) version of
[xapi](https://xapi-project.github.io/), and for the older, 0.7.x releases of
lnav. To check which version of lnav is installed, run `lnav -V`.

It currently supports the following log files on a XenServer host:

- /var/log/xensource.log
- /var/log/audit.log

(And of course, it supports the rotated versions of these log files as well.)

## Installing the format file

Clone this repo in the directory where the lnav format files are stored
(`~/.lnav/formats/`) and checkout this branch with `git`, or follow the
[installation instructions in the lnav
documentation](https://github.com/tstack/lnav/blob/v0.7.3/docs/source/formats.rst#installing-formats).

## Contributing

### Travis tests

The [`pcregrep`](http://www.rexegg.com/pcregrep-pcretest.html) tool is a `grep`
tool that uses the same PCRE regexes as lnav format files. The Travis tests use
this tool to verify that the regex in the format file matches every line in a
`xensource.log` file. By inverting the match, the `pcregrep -v <regex to be
tested>` command will output all the non-matching lines. If the regex does not
match all lines of the well-formatted `xensource.log` test file in the
`test/test_match/` directory, then the build fails.

There is also a second test, which uses perl itself, and checks that the regex
correctly extracts each field of the log lines in the `xensource.log` test file
found in the `test/test_captures/` directory.

## License

This repo uses the same 2-Clause BSD License (or "Simplified BSD License" or "FreeBSD
License") as lnav.

Some of the code comes from the [lnav
repository](https://github.com/tstack/lnav); I took the first part of the
`xensource_log` regex from the default syslog lnav format, due to the
similarities, and then simplified it.
