#!/usr/bin/perl -T
# (c) 1996-2011 Wolfram Schneider. Public domain.
#
# FreeBSD WWW mirror redirect
#
# $FreeBSD$

use CGI;
use strict;
use warnings;

my $debug      = 1;
my $master_url = 'https://www.freebsd.org/';

my $q = new CGI;
my $url = $q->param('goto') || "";

if (   $url =~ m,^http://[a-z0-9\.]+\.freebsd\.org/?$,i
    || $url =~ m,^http://[a-z0-9\.]+\.freebsd\.org/www\.FreeBSD\.org/(data)?$,i
    || $url =~ m,^http://(freebsd\.unixtech\.be|www\.gufi\.org/mirrors/www.freebsd.org/data)/$,i
  )
{
    # ok
}

else {
    warn "Ignore illegal redirect URL: $url\n" if $debug;
    $url = $master_url;
}

print $q->redirect($url);

