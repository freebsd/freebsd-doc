#!/usr/bin/perl -T
#
# Copyright (c) Oct 1997-1999 Wolfram Schneider <wosch@FreeBSD.org>. Berlin.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# url.cgi - make plain text URLs clickable
#
# $FreeBSD: www/en/cgi/url.cgi,v 1.24 2000/01/05 15:47:46 phantom Exp $

use strict;

$main::hsty_base = '..';
$main::hsty_email = 'ports@FreeBSD.org';

# shutup perl -w
my $dummy = $main::hsty_base . $main::hsty_email; undef $dummy;

require "./cgi-lib.pl";
require "./cgi-style.pl";

my $file = $ENV{'QUERY_STRING'};
my $uri = "$file";
my $portcategory;


# security checks
if ($file !~ m%^(http|ftp)://[a-z_\-0-9]+\.freebsd\.(com|org)%i) {
    &CgiError(("Invalid url: $file", "Only http://*.freebsd.* is allowed.\n"));
    exit(0);
}

# catch '..', multiple times
# ports/japanese/ppxp/../../net/ppxp/pkg/DESCR 
#	-> ports/net/ppxp/pkg/DESCR
1 while $file =~ s%/[^/]+/\.\./%/%;

# print HTML header
$file =~ s%(http|ftp)://ftp.freebsd.org/pub/FreeBSD/(branches/|FreeBSD)-current/%%i;
if ($file =~ m%^ports/([\w-]+)/(\w[\w-+.]+)/pkg/DESCR%) {
    print &html_header(
       "Port description for $1/$2");
    $portcategory = $1;
} else {
    print &short_html_header($file);
}

# do cvs checkout 
my($cvsroot) = '/home/ncvs';
if ($file =~ m%^ports/[\w-]+/\w[\w-+.]*/pkg/DESCR% && -f "$cvsroot/$file,v") {
    open(CO, "-|") || 
	exec ('/usr/bin/co', '-p', '-q', "$cvsroot/$file,v") ||
	die "exec co -pq $cvsroot/$file,v: $!\n";
} 

else {
    print "<p>The port specified does not exist, or has an invalid name:",
	  "$file\n";
    print "<p>Please contact the webmaster!\n";
}
print "\n<HR>\n<pre>\n";

# read the DESCR file and make URLs clickable
my($content);
$content .= $_ while(<CO>);
$content =~ s/</&lt;/g;
$content =~ s%((http|ftp)://\S+[^.;,"\s>])%<A HREF="$1">$1</A>%gi;

print $content;
print "</pre>\n";

# Add 'source' link for freebsd ports
if ($file =~ m%^(ports/[\w-]+/\w[\w-+.]+)/pkg/DESCR%) {
    print qq{<HR><a href=\"pds.cgi?$1">Sources</a> |\n};
    print qq{<a href=\"../ports/$portcategory.html">};
    print qq{Category $portcategory</a>\n};
    print qq{| <a href="../ports/">Help</a>\n};
    print qq{<BR>\n};
}

# print standard footer line
print &html_footer; 

exit;

