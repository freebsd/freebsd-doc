#!/usr/local/bin/perl
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
# Search and present a mail by Message-ID or In-Reply-To field
#
# $Id: mid.cgi,v 1.1 1998-03-15 22:00:09 wosch Exp $

$hsty_base = '';

require "./cgi-lib.pl";
require "./cgi-style.pl";

$home = '/g/www/mid';
$lookupdir = "$home/index"; # database(s) directory
$database = 'mid';           # default database
$bindir = "$home/bin"; # where search scripts located
$script = $ENV{'SCRIPT_NAME'};
$shortid = 1;

sub foot { return &html_footer . "</BODY></HTML>\n"; }

sub get_id {
    local($query, $db) = @_;

    open(DB,  "-|") || 
	exec("$bindir/mid", $query, "$lookupdir/mid-current.$db", "$lookupdir/mid.$db") || do {
	print &foot; exit;	
    	};	

    print "\n<pre>\n";
    while(<DB>) {
	print &clickable($_);
    }
    close DB;

    if (($? >> 8) != 0) {
	if ($db eq 'mid') {
	    print qq{Message-ID: "$query" not fond\n};
	} else {
	    print qq{No answers found for: "$query"\n};
	}
    }
    print "</pre>\n";
    print &foot;
}

sub clickable {
    local($string) = @_;

    if (/^(message-id|resent-message-id):\s+(.*)/oi) {
	local($key,$val) = ($1,$2);
	$val =~ s%<([^>]+)>%<a href="$script?db=irt&id=$1">&lt;$1&gt;</a>%goi;
        return $key . ': ' . $val . "\n";
    } elsif (/^(references|in-reply-to):\s+(.*)/oi) {
	local($key,$val) = ($1,$2);
	$val =~ s%<([^>]+)>%<a href="$script?db=mid&id=$1">&lt;$1&gt;</a>%goi;
        return $key . ': ' . $val . "\n";
    } else {
	$string =~ s/</&lt;/g;
	return $string;
    }
    # </&lt;/g"
}

print &short_html_header("FreeBSD Message-ID Mail Archives");
print qq{<p><a href="mid.html">Back to the search interface</a><p>\n};

&ReadParse(*input);

if (!$input{'id'}) {
    print "No input given\n";
    print &foot; exit;
}
$input{'id'} =~ s/^<//;
$input{'id'} =~ s/>$//;
$input{'id'} =~ s/@.*// if $shortid;

if ($input{'db'} eq 'mid' || $input{'db'} eq 'irt') {
    $database = $input{'db'};
}

&get_id($input{'id'}, $input{'db'});
