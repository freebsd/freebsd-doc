#!/usr/bin/perl
# Copyright (c) Wolfram Schneider, Berlin. Sep 1997.
#
# redirect FreeBSD man script
#
# $Id: man.cgi,v 1.1 1997-09-27 21:27:18 wosch Exp $

$_ = $ENV{'QUERY_STRING'};
$_ = '?' . $_ if $_;

print "Window-target: _top\n";
print "Location: http://www.de.freebsd.org/de/cgi/man.cgi$_\n";
print "Content-type: text/plain\n\n";

exit 0;

