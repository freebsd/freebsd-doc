#!/usr/bin/perl
# (c) Wolfram Schneider, Berlin. June 1996. Public domain.
#
# FreeBSD WWW mirror redirect
#
# $Id: mirror.cgi,v 1.2 1996-10-01 18:59:10 jfieber Exp $

$_ = $ENV{'QUERY_STRING'};

s/^[^=]+=//;			# 'variable=value' -> 'value'
s/\+/ /g;			# '+'   -> space
s/%(..)/pack("c",hex($1))/ge;	# '%ab' -> char ab

print "Window-target: _top\n";
print "Location: $_\n";
print "Content-type: text/plain\n\n";

exit 0;
