#!/usr/bin/perl
#
# Copyright (c) March 1998 Wolfram Schneider <wosch@FreeBSD.org>. Berlin.
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
# Search a mail by Message-ID, References or In-Reply-To field
#
# $FreeBSD: www/en/cgi/mid.cgi,v 1.8 1999/09/06 07:02:40 peter Exp $

$hsty_base = '';

require "./cgi-lib.pl";
require "./cgi-style.pl";

$home = '/usr/local/www/mailindex';
$prefix= "/usr/local/www/db/text";
$lookupdir = "$home/message-id"; # database(s) directory
$databaseDefault = 'mid';           # default database
$bindir = "$home/bin"; # where search scripts located
$script = $ENV{'SCRIPT_NAME'};
$shortid = 1;
$lookCommand = "/usr/bin/look";

sub get_id {
    local($query, $db) = @_;

    open(DB,  "-|") ||
	exec("$lookCommand", $query, "$lookupdir/mid-current.$db") ||
	do {
	    print &midheader .
		"Cannot connect to Message-ID database.<p>\n" . &foot;
    exit;
    	};

    local(@idlist);
    while(<DB>) {
	push(@idlist, $_);
    }
    close DB;
    #warn "$lookCommand $query, $lookupdir/mid.$db";
    open(DB,  "-|") ||
	exec("$lookCommand", $query, "$lookupdir/mid.$db") ||
	do {
	    print &midheader .
		"Cannot connect to Message-ID database.<p>\n" . &foot;
	    exit;
    	};

    while(<DB>) {
	push(@idlist, $_);
    }
    close DB;


    if ($#idlist < 0) {           # nothing found
	print &midheader;
	if ($db eq 'mid') {
	    print qq{Message-ID: "$query" not fond\n};
	} else {
	    print qq{No answers found for: "$query"\n};
	}
	print &foot;

    } elsif ($#idlist == 0) {     # one hit
	local($location) = $ENV{'SCRIPT_NAME'};
	local($id, $file, $start) = split($", $idlist[0]);
	$location =~ s%/[^/]+$%%;
	local($host) = $ENV{'HTTP_HOST'};
	$location = 'http://' . $host . $location;
	$start =~ s/\s+$//;

	print "Location: $location/getmsg.cgi?fetch=$start+0+" .
		($file =~ /^current/ ?  '' :  "$prefix/") . "$file\n";
	print "Content-type: text/plain\n\n";
	exit;

    } else {                      # more than one hit
	local($id, $file, $start, $name);
	print &midheader;
	print "<UL>\n";
	foreach (@idlist) {
	    ($id, $file, $start) = split;
	    $name = $file;
	    $name =~ s%.*/%%;
	    $name =~ s%(....)(..)(..)\.%$1-$2-$3 %;
	    print qq{<LI><A HREF="getmsg.cgi?fetch=$start+0+} .
                ($file =~ /^current/ ? '' : "$prefix/") .
		qq{$file">$name $start</A>\n};
	}
	print "</UL>\n<p>\n";
	print &foot;
    }
}

sub midheader {
    return &short_html_header("FreeBSD Message-ID Mail Archives") .
	qq{<p><a href="../search/search.html">Back to the search interface</a><p>\n};
}

sub foot { return &html_footer . "</BODY></HTML>\n"; }

###
# Main
###

&ReadParse(*input);
$messageid = $input{'id'};
$database = $input{'db'};


if (!$messageid) {
    # for lazy people ;-)
    # allow the syntax  mid.cgi?messageid
    if ($ENV{'QUERY_STRING'} =~ /<?[a-z0-9._>\-]+\S+$/) {
	$messageid = $ENV{'QUERY_STRING'};
	$database = $databaseDefault;
    } 

    # no message-id given
    else {
	print  &midheader;
	print "No input given\n";
	print &foot; exit;
    }
}

$messageid =~ s/^<//;
$messageid =~ s/>$//;
$messageid =~ s/@.*// if $shortid;

$database = $databaseDefault
    if (!($database eq 'mid' || $database eq 'irt'));

&get_id($messageid, $database);
