#!/usr/bin/perl -T
# Copyright (c) 1997-2000 Wolfram Schneider <wosch@FreeBSD.ORG>, Berlin.
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
# pds.cgi - FreeBSD Ports download sources cgi script
#	    print a list of source files for a port
#
# $FreeBSD: www/en/cgi/pds.cgi,v 1.6 2000/01/05 15:47:45 phantom Exp $

$hsty_base = '';
$hsty_email = 'ports@FreeBSD.org';

require "./cgi-lib.pl";
require "./cgi-style.pl";

$file = $ENV{'QUERY_STRING'};
$file_rcs = "$file/Makefile,v";

$cvsroot = "/home/ncvs";
$co = '/usr/bin/co';
$make = '/usr/bin/make';
$pds = '/usr/local/www/bin/pds';

# security
$ENV{'PATH'} = '/bin:/usr/bin';

# set DISTDIR to a dummy  directory.
$ENV{'DISTDIR'} = "/tmp/___pds.cgi___" . $<;

# security
$ENV{'PATH'} = '/bin:/usr/bin';


sub footer { 
    return qq{<P>\n<A HREF="} .
	($ENV{'PATH_INFO'} ? 'http://www.FreeBSD.org/ports/' : '../ports/') .
     	qq{">Help</a>\n} . &html_footer; 
}

print &short_html_header("FreeBSD Ports download script");
print "<p>\n";
if ($file !~ m%^ports/[^/]+/[^/]+$%) {
    print qq{Invalid module name: "$file"\n} . &footer; 
    exit;
}

if (! -f "$cvsroot/$file_rcs" || $file_rcs =~ /\.\./) {
    print qq{Port "$file" does not exist.\n} . &footer;
    exit;
}

print "<h2>Sources for $file</h2>\n\n";

open(MAKE, "-|") || exec($pds, "$cvsroot/$file_rcs") || do {
    print "Sorry, cannot run make\n" . &footer; 
    exit;
};

local(@sources);
while(<MAKE>) {
    push(@sources, $_);
}
close MAKE;

if ($#sources < 0) {
    print "Sorry, did not find the sources for $file\n" . &footer;
    exit;
}

foreach (@sources) {
    print qq{<a href="$1">$1</a><br>\n} if m%((http|ftp)://\S+)%;
}

local($md5file) = "$cvsroot/$file/distinfo,v";
if (-f $md5file) {
    open(CO, "-|") || exec ($co, '-q', '-p', $md5file) || do {
	print "Cannot read MD5 checksum file for $file\n" . &footer;
	exit;
   };
   local(@checksums);
   while(<CO>) {
	push(@checksums, $_) if $_;
   } 
   close CO;
   if ($#checksums >= 0) {
	print "<h3>MD5 Checksum for $file</h3>\n\n";
        print "<PRE>\n";
        print @checksums;
        print "</PRE>\n";
   }
}


print &footer;
exit;
