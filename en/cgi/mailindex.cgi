#!/usr/bin/perl
#
# Copyright (c) Jan 1999 Wolfram Schneider <wosch@FreeBSD.org>
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
# $FreeBSD: www/en/cgi/mailindex.cgi,v 1.4 1999/09/06 07:02:40 peter Exp $


use CGI;
use CGI::Carp;

$hsty_base = '';
require "./cgi-lib.pl";
require "./cgi-style.pl";


# no sort
my $sortopt = '';
my $up = 0;

$| = 1;

# mail archive location
$maildir = '/g/mail/archive';

# mailindex program
$mailindex = '/usr/local/www/mid/bin/mailindex';


$query = new CGI();

print "Content-type: text/html\n\n";

my $reverse;
$sortopt = '--sort-by-subject' if ($query->param('sort') eq 'subject');
$sortopt = '--sort-by-author'  if ($query->param('sort') eq 'author');
$sortopt = '' if ($query->param('sort') eq 'date');

$reverse = '--reverse'  if ($query->param('reverse'));

my $file = $query->param('file');
if (!$file) {
    print "No file name given\n";
    exit;
}

# forbid link to parent directories
$file =~ s%\.\./%%g;

sub file_not_exists {
    my $file = shift;
    print "File does not exists: $file\n";
    exit;
}

if ($file =~ s%^archive/%%) {
    $maildir = '/g/www/db/text';
    &file_not_exists("$maildir/$file") if (! -f "$maildir/$file");
} elsif ($file =~ s%^current/%% && $file =~ /^freebsd-|^cvs-/) {
    &file_not_exists("$file") if (! -f "$maildir/$file");
    $up = 0;
} else {
    &file_not_exists("$file");
}

chdir($maildir) or die "chdir $maildir: $!\n";

my @options;
push(@options, ("--up=$up", '--outdir=stdout', '--cgilink=1'));
push(@options, $sortopt) if $sortopt;
push(@options, $reverse) if $reverse;

open(M, "-|") || exec "$mailindex",  @options, $file || do {
    print "Cannot open $mailindex: $!\n";
    exit;
};

#print "cd $maildir; $mailindex  @options $file\n";
while(<M>) {
    print;
}

exit;
