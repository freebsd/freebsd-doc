#!/usr/bin/perl
# $Id: query-pr.cgi,v 1.2 1996-09-29 03:14:16 jfieber Exp $

$ENV{'PATH'} = "/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin";

%mons = ('Jan', '01',  'Feb', '02',  'Mar', '03',
	 'Apr', '04',  'May', '05',  'Jun', '06',
	 'Jul', '07',  'Aug', '08',  'Sep', '09',
	 'Oct', '10',  'Nov', '11',  'Dec', '12');

require "cgi-lib.pl";
require "cgi-style.pl";
require "getopts.pl";

&Getopts('p:');

if ($opt_p) {

    $input{'pr'} = $opt_p;

} else {

    if (! &ReadParse(*input)) {
	print &html_header("PR Query Interface");
	print "<p>Please enter the PR number you wish to query:</p>\n";
	($scriptname = $ENV{'SCRIPT_NAME'}) =~ s|^/?|/|;
	$scriptname =~ s|/$||;
	($summary = $scriptname) =~ s/query-pr/query-pr-summary/;
	print "<FORM METHOD=GET ACTION=\"$scriptname\">\n";
	print "<INPUT TYPE=TEXT NAME=pr></FORM>\n";
	print "<p>See also the <A HREF=\"$summary\">PR summary</A></p>\n";
	print &html_footer;
	exit 0;
    }
}

$pr = $input{'pr'};

if ($pr < 1 || $pr > 99999) {
    print &html_header("FreeBSD Problem Report");
    print "<p>Invalid problem report number: $pr</p>\n";
    print &html_footer;
    exit 0;
}

unless (open(Q, "query-pr --restricted -F $pr 2>&1 |")) {
    print &html_header("Server error");
    print "<p>Unable to open PR database.</p>\n";
    print &html_footer;
    die "Unable to query PR's";
}

$inhdr = 1;
$multiline = 0;
$from = "";

while(<Q>) {
    chop;

    $html_fixup = 1;

    if (/^query-pr: no PRs matched$/) {
	print &html_header("FreeBSD problem report");
	print "<p>No PR found matching $pr</p>\n";
	print &html_footer;
	exit;
    }

    if (/^From:\s*(.*)$/) {
	$from = $1;
	($email = $from) =~ s/.*<(.*)>.*/$1/;
	$email =~ s/\s*\(.*\)\s*//;
	$email .= '@freebsd.org' unless ($email =~ /@/);
    }

    if (/^>Responsible:/) {
	$_ = &getline($_);
	s/\(.*\)//;			# remove personal name
	s/\s+//g;
	$_ = $_ . '@freebsd.org' if !/@/;
	$_ = '>Responsible:<a href="mailto:' . $_ . '">' . $_ . '</a>';
	$html_fixup = 0;
    }

    s/^>Last-Modified:\s*$/>Last-Modified: never/;

    if(/^>Number:/) {
	$number = &getline($_);
	$inhdr = 0;
    } elsif (/^>Category:/) {
	$cat = &getline($_);
    } elsif (/^>Synopsis:/) {
	$syn = &getline($_);
	$syn =~ s/[\t]+/ /g;
	$syn = &fixline($syn);
	print &html_header("Problem Report $cat/$number");
	print "<strong>$syn</strong><p>\n<dl>\n";
    } else {
	next if $inhdr;

	if (/^>(\S+):\s*(.*)/) {
	    print $trailer . "\n";
	    print "<dt><strong>$1</strong><dd>\n";
	    $trailer = $2;
	    $trailer = &fixline($2) if $html_fixup;
	    if ($1 eq "Originator" && $from ne "") {	# add email address
	        $trailer .= " <A HREF=\"mailto:$email\">" . &fixline($from) . "</A>";
	    }
	    $multiline = 0;
	} else {
	    unless ($multiline) {
		next if /^\s*$/;
		print $trailer . "\n<listing>\n";
	    }
	    $multiline = 1;
	    print $html_fixup ? &fixline($_) : $_ , "\n";
	    $trailer = "</listing>";
	}
    }
}
close(Q);

print "$trailer\n</dl>" . &html_footer;

exit 0;

sub getline
{
    local($_) = @_;
    ($tag,$remainder) = split(/[ \t]+/, $_, 2);
    return $remainder;
}

sub fixline {
    local($line) = @_[0];
    
    $line =~ s/&/&amp;/g;
    $line =~ s/</&lt;/g;
    $line =~ s/>/&gt;/g;
    $line =~ s|(http://\S+)|<A HREF="$1">$1</A>|g;
    
    $line;
}
