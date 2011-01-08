#!/usr/bin/perl -T
#
# Copyright (c) Oct 1997-2011 Wolfram Schneider <wosch@FreeBSD.org>. Berlin.
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
# $FreeBSD: www/en/cgi/url.cgi,v 1.37 2010/08/28 19:15:22 wosch Exp $

use strict;

$ENV{"PATH"} = "/bin:/usr/bin";

$main::hsty_email = 'ports@FreeBSD.org';

# shutup perl -w
my $dummy = $main::hsty_base . $main::hsty_email; undef $dummy;

require "./cgi-lib.pl";
require "./cgi-style.pl";

my $file = $ENV{'QUERY_STRING'};
my $uri = "$file";
my $portcategory;


# security checks
if ($file !~ m%^(http|ftp)://[a-z_\-0-9]+\.freebsd\.(com|org)%i &&
    $file !~ m%^ports/%) {
    &CgiError(("Invalid URL", "Only http://*.freebsd.* is allowed.\n"));
    exit(0);
}

# backward compatible with old ports layout
$file =~ s%/pkg/DESCR$%/pkg-descr%;

# catch '..', multiple times
# ports/japanese/ppxp/../../net/ppxp/pkg-descr 
#	-> ports/net/ppxp/pkg-descr
1 while $file =~ s%/[^/]+/\.\./%/%;

# print HTML header
$file =~ s%(http|ftp)://ftp.FreeBSD.org/pub/FreeBSD/(branches/|FreeBSD)-current/%%i;
if ($file =~ m%^ports/([\w\-]+)/(\w[\w\-+.]+)/pkg-descr%) {
    print &html_header(
       "Port description for $1/$2");
    $portcategory = $1;

    # XXX: shut up perl -T warnings
    $file = qq{ports/$1/$2/pkg-descr};
} else {
    print &short_html_header($file);
}

my $isvalidfilename = ($file =~ m%^ports/[\w\-]+/\w[\w\-+.]*/pkg-descr%);
my $atticfile = $file;
$atticfile =~ s%^(.*)/([^/]+)$%$1/Attic/$2%;

my($cvsroot) = '/usr/local/www/cvsroot/FreeBSD';
my $realfile;

# since CVS moves deleted files into the Attic subdirectory we also
# want to look there, so we can find CVS deleted files (which might
# still be referenced from other places).
if ($isvalidfilename && -f "$cvsroot/$file,v") {
    $realfile = $file;
} elsif ($isvalidfilename && -f "$cvsroot/$atticfile,v") {
    $realfile = $atticfile;
} else {
    $isvalidfilename = 0;
}

# do cvs checkout
if($isvalidfilename) {
    open(CO, "-|") ||
	exec ('/usr/bin/co', '-p', '-q', "$cvsroot/$realfile,v") ||
	die "exec co -pq $cvsroot/$realfile,v: $!\n";
} else {
    print "<p>The port specified does not exist, or has an invalid name: <p>",
	  "<blockquote>$file</blockquote>\n";

    # Server environment variables
    my $http_referer = $ENV{'HTTP_REFERER'};

    # rfc1738 says that ";"|"/"|"?"|":"|"@"|"&"|"=" may be reserved.
    $http_referer =~ s/([^a-zA-Z0-9;\/?:&=])/sprintf("%%%02x",ord($1))/eg;

    if ($http_referer) {
	print qq{<p>You are coming from 
	<blockquote>
	<a href="$http_referer">$http_referer</a>.
	</blockquote>
	<p>\n};
    }
    print "<p>Please contact www\@FreeBSD.org\n";
    warn "$0: invalid port name: `$file', $http_referer\n";
}
print "\n<HR>\n<pre>\n";

# read the pkg-descr file and make URLs clickable
my($content);
$content .= $_ while(<CO>);
$content =~ s/</&lt;/g;
$content =~ s%((http|ftp)://\S+[^.;,"\s>])%<A HREF="$1">$1</A>%gi;

print $content;
print "</pre>\n";

# Add 'source' link for freebsd ports
if ($file =~ m%^(ports/[\w\-]+/\w[\w\-+.]+)/pkg-descr%) {
    print qq{<HR><a href=\"pds.cgi?$1">Sources</a> |\n};
    print qq{<a href=\"../ports/$portcategory.html">};
    print qq{Category $portcategory</a>\n};
    print qq{| <a href="../ports/">Help</a>\n};
    print qq{<BR>\n};
}

# print standard footer line
print &html_footer; 

# Sleep 0.35 seconds to avoid DoS attacks from broken robots
select undef, undef, undef, 0.35;

exit;

