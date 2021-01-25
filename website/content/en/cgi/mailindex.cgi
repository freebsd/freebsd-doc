#!/usr/bin/perl -T
#
# Copyright (c) Jan 1999-2011 Wolfram Schneider <wosch@FreeBSD.org>
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
# $FreeBSD$


use CGI;
use CGI::Carp;

require "./cgi-lib.pl";
require "./cgi-style.pl";

$ENV{PATH} = "/bin:/usr/bin:/usr/local/bin";

# no sort
my $sortopt = '';
my $up = 0;

$| = 1;

# mail archive location
$maildir = '/home/mail/archive';

# mailindex program
$mailindex = '/usr/local/www/mailindex/bin/mailindex';


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
if ($file =~ m,^([0-9a-z/-]+|[0-9a-z/-]+\.[0-9a-z-]+)$,) {
    $file = $1;
} else {
    print "Unknown file name given\n";
    exit;
} 
	

sub file_not_exists {
    my $file = shift;
    print "File does not exist: $file\n";
    exit;
}

if ($file =~ s%^archive/%%) {
    $maildir = '/usr/local/www/mailindex/archive';
    &file_not_exists("$maildir/$file") if (! -f "$maildir/$file");
} elsif ($file =~ s%^current/%% && $file =~ /^(freebsd|cvs|svn|ctm|trustedbsd)-/) {
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
