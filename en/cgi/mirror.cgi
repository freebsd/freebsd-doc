#!/usr/bin/perl
# (c) Wolfram Schneider, Berlin. June 1996. Public domain.
#
# FreeBSD WWW mirror redirect
#
# $Id: mirror.cgi,v 1.1.1.1 1996-09-24 17:45:57 jfieber Exp $

$_ = $ENV{'QUERY_STRING'};

s/^[^=]+=//;			# 'variable=value' -> 'value'
s/\+/ /g;			# '+'   -> space
s/%(..)/pack("c",hex($1))/ge;	# '%ab' -> char ab

print "Location: $_\nContent-type: text/plain\n\n";

exit 0;
