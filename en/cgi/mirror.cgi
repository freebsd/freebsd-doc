#!/usr/bin/perl -T
# (c) Wolfram Schneider, Berlin. June 1996. Public domain.
#
# FreeBSD WWW mirror redirect
#
# $FreeBSD: www/en/cgi/mirror.cgi,v 1.3 1999/09/06 07:02:40 peter Exp $

$_ = $ENV{'QUERY_STRING'};

s/^[^=]+=//;			# 'variable=value' -> 'value'
s/\+/ /g;			# '+'   -> space
s/%(..)/pack("c",hex($1))/ge;	# '%ab' -> char ab

print "Window-target: _top\n";
print "Location: $_\n";
print "Content-type: text/plain\n\n";

exit 0;
