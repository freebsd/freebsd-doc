#!/usr/bin/perl
# Copyright (c) Wolfram Schneider, Berlin. Sep 1997.
#
# redirect FreeBSD man script
#
# $FreeBSD: www/en/cgi/man.cgi,v 1.3 1999/09/06 07:02:40 peter Exp $

exec('/usr/local/www/bsddoc/bin/man.cgi');

$_ = $ENV{'QUERY_STRING'};
$_ = '?' . $_ if $_;

print "Window-target: _top\n";
print "Location: http://www.de.FreeBSD.org/de/cgi/man.cgi$_\n";
print "Content-type: text/plain\n\n";

exit 0;

