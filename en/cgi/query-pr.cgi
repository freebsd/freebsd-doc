#!/usr/bin/perl -T
# $FreeBSD: www/en/cgi/query-pr.cgi,v 1.36 2003/11/12 20:58:13 ceri Exp $

$ENV{'PATH'} = "/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin";

%mons = ('Jan', '01',  'Feb', '02',  'Mar', '03',
	 'Apr', '04',  'May', '05',  'Jun', '06',
	 'Jul', '07',  'Aug', '08',  'Sep', '09',
	 'Oct', '10',  'Nov', '11',  'Dec', '12');

require "./cgi-lib.pl";
require "./cgi-style.pl";
require "getopts.pl";
require "./Gnats.pm";  import Gnats;

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

# allow query-pr.cgi?<pr> queries
if (!($pr = $input{'pr'}) && &MethGet) {
    $pr = $ENV{'QUERY_STRING'};
}

# be tolerant to <category>/<PR id> queries
$pr =~ s%^.+/%%;	# remove <category>/ part
if ($pr =~ /(\d+)/) {
    $pr = $1;
} else {
    $pr = 0;
}

$pr = int($pr); 	# numeralize: "0123" -> 123

if ($pr < 1 || $pr > 499999) {
    print &html_header("FreeBSD Problem Report");
    print "<p>Invalid problem report number: $pr</p>\n";
    print &html_footer;
    exit 0;
}

unless (open(Q, "$query_pr -F $pr 2>&1 |")) {
    print &html_header("Server error");
    print "<p>Unable to open PR database.</p>\n";
    print &html_footer;
    die "Unable to query PR's";
}

if ($input{'f'} eq 'raw') {
    print "Content-Type: text/plain\r\n\r\n";
    print <Q>;
    close(Q);
    exit 0;
}

$inhdr = 1;
$multiline = 0;
$from = "";
$replyto = "";

while(<Q>) {
    chop;

    $html_fixup = 1;

    if (/^query-pr.real: /) {
	print &html_header("FreeBSD problem report");
	if ($_ ne "query-pr.real: no PRs matched") {
	    print "<P>query-pr said:\n";
	    print "<PRE>$_\n";
	    print <Q>;
	    print "</PRE>\n";
	} else {
	    print "<p>No PR found matching $pr\n";
	}
	print &html_footer;
	exit;
    } elsif (/^lockf: /) {
	print &html_header("FreeBSD problem report");
	print "<p>The PR database is currently busy; please try ",
	    "<A HREF=\"./query-pr.cgi?pr=$pr\">your query</A> again.";
	print &html_footer;
	exit;
    }

    # In e-mail header
    if ($inhdr && /^From:\s*(.*)$/i) {
	$from = $1;
	$from =~ s/.*<(.*)>.*/$1/;
	$from =~ s/\s*\(.*\)\s*//;
    }
    if ($inhdr && /^Reply-to:\s*(.*)$/i) {
	$replyto = $1;
	$replyto =~ s/.*<(.*)>.*/$1/;
	$replyto =~ s/\s*\(.*\)\s*//;
    }

    # End of e-mail header
    if ($inhdr && /^$/) {
	$from = $replyto if ($replyto);
	$email = $from;
	$email .= '@FreeBSD.org' unless ($email =~ /@/);
	$inhdr = 0;
    }

    if (/^>Responsible:/) {
	$_ = &getline($_);
	s/\(.*\)//;			# remove personal name
	s/\s+//g;
	$_ = $_ . '@FreeBSD.org' if !/@/;
	$_ = '>Responsible:<a href="mailto:' . $_ . '">' . $_ . '</a>';
	$html_fixup = 0;
    }

    s/^>Last-Modified:\s*$/>Last-Modified: never/;

    if (/^>Number:/) {
	$number = &getline($_);
    } elsif (/^>Category:/) {
	$cat = &getline($_);
    } elsif (/^>Synopsis:/) {
	$syn = &getline($_);
	$syn =~ s/[\t]+/ /g;
	$origsyn = $syn;
	$syn = &fixline($syn);
	print &short_html_header("Problem Report $cat/$number: $syn");
	print "<h1><font color=\"#660000\">Problem Report $cat/$number</font></h1>\n";
	print "<strong>$syn</strong><p>\n<dl>\n";
    } else {
	next if $inhdr;

	if (/^>(\S+):\s*(.*)/) {
	    print $trailer . "\n" unless ($blank);
	    $trailer = "<dt><strong>$1</strong><dd>\n";
	    if ($html_fixup) {
		$trailer .= &fixline($2);
	    } else {
		$trailer .= $2;
	    }
	    if ($1 eq "Originator" && $from ne "") {	# add email address
		$trailer .= " &lt;<A HREF=\"mailto:$email\">" . &fixline($from) . "</A>&gt;";
	    }
	    $blank = !($2);
	    $multiline = 0;
	} else {
	    unless ($multiline) {
		next if /^\s*$/;
		print $trailer . "\n<pre>\n";
	    }
	    $multiline = 1;
	    $blank = 0;
	    print $html_fixup ? &fixline($_) : $_ , "\n";
	    $trailer = "</pre>";
	}
    }
}
close(Q);

print "$trailer\n" unless ($blank);
print "</dl>";

$origsyn =~ s/[^a-zA-Z+.@-]/"%" . sprintf("%02X", unpack("C", $&))/eg;
$email =~ s/[^a-zA-Z+.@-]/"%" . sprintf("%02X", unpack("C", $&))/eg;

print qq`<A HREF="mailto:freebsd-gnats-submit\@FreeBSD.org,${email}?subject=Re:%20${cat}/${number}:%20$origsyn">Submit Followup</A> | <A HREF="./query-pr.cgi?pr=$pr&amp;f=raw">Raw PR</A>\n`;

print &html_footer;

# Sleep 0.35 seconds to avoid DoS attacks from broken robots
select undef, undef, undef, 0.35;

exit 0;

sub getline
{
    local($_) = @_;
    ($tag,$remainder) = split(/[ \t]+/, $_, 2);
    return $remainder;
}




sub cvsweb {
    local($file) = shift;
    $file =~ s/[,.;]$//;
    return 'http://cvsweb.FreeBSD.org/' . $file;
}
    

sub srcref {
    local($_) = shift;

    local($rev) = '(rev\.?|revision):?\s+[0-9]\.[0-9.]+(\s+of)?';
    local($src) = '((src|www|doc|ports)/[^\s]+)';

    if (m%$rev\s*$src%oi || m%$src\s*$rev%) {
	s#$src#sprintf("<a href=%c%s%c>%s</a>", 34, &cvsweb($1), 34, $1)#ge;
    }

    return $_;
}

sub fixline {
    local(@splitline) = split(/((?:https?|ftp):\/\/[^\s"\(\)<>,;]+)/, shift);

    local($isurl) = 0;
    foreach (@splitline) {
	if ($isurl) {
	    local($href) = local($html) = $_;
	    $href =~ s/&/%26/g;
	    $html =~ s/&/&amp;/g;
	    $_ = "<A HREF=\"$href\">$html</A>";
	} else {
	    s/&/&amp;/g;
	    s/</&lt;/g;
	    s/>/&gt;/g;
	    s%(\WPR[:s# \t]+)([a-z3486]+\/)?([0-9]+)%$1<A HREF="query-pr.cgi?pr=$3">$2$3</A>%ig;
	}
	$isurl = ! $isurl;
    }

    return &srcref(join('', @splitline));
}
