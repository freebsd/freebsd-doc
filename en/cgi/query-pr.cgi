#!/usr/bin/perl -T
# $FreeBSD: www/en/cgi/query-pr.cgi,v 1.49 2005/11/07 10:43:19 ceri Exp $

$ENV{'PATH'} = "/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin";

use DB_File;
use Fcntl qw(:DEFAULT :flock);

require "./cgi-lib.pl";
require "./cgi-style.pl";
require "getopts.pl";
require "./Gnats.pm";  import Gnats;

my $expiretime = 2700;
$dbpath = "/tmp/querypr-code.db";

&Getopts('cp:');

if ($opt_c) {
    $codeentered = $opt_c;
}

if ($opt_p) {

    $input{'pr'} = $opt_p;

} else {

    if (! &ReadParse(*input)) {
	print &html_header("PR Query Interface");
	print "<p>Please enter the PR number you wish to query:</p>\n";
	($scriptname = $ENV{'SCRIPT_NAME'}) =~ s|^/?|/|;
	$scriptname =~ s|/$||;
	($summary = $scriptname) =~ s/query-pr/query-pr-summary/;
	print "<form method='post' action='$scriptname'>\n";
	print "<input type='text' name='pr' />\n";
	print "<p>To view the PR with email addresses, copy the code ";
	print " from the image below: <input type='text' ";
	print " name='code-confirm' id='code-confirm' size='8' />\n";
	print "</p><p><label for='code-confirm'>";
	print "<img src='http://www.FreeBSD.org/cgi/querypr-code.cgi?dummy=1' ";
	print " alt='Random text; if you cannot see the image, please email ";
	print " bugbusters\@FreeBSD.org' border='0' height='24' /></label></p>\n";
	print "<input type='submit' value='Query' />\n</form>\n";
	print "<p>See also the <a href='$summary'>PR summary</a></p>\n";
	print &html_footer;
	exit 0;
    }
}

# allow query-pr.cgi?<pr> queries
if (!($pr = $input{'pr'}) && &MethGet) {
    $pr = $ENV{'QUERY_STRING'};
}

# Get the confirmation code if it exists
#  (and wasn't specified with -c).
$codeentered ||= $input{'code-confirm'};

# Verify the data ...

$db_obj = tie(%db_hash, 'DB_File', $dbpath, O_CREAT|O_RDWR, 0644)
                    or die "dbcreate $dbpath $!";
$fd = $db_obj->fd;
open(DB_FH, "+<&=$fd") or die "fdopen $!";

unless (flock (DB_FH, LOCK_EX | LOCK_NB)) {
    unless (flock (DB_FH, LOCK_EX)) { die "flock: $!" }
}

# Sweep for and remove expired codes.
foreach $randomcode (keys %db_hash) {
	if ( ($currenttime - $expiretime) >= $db_hash{$randomcode}) {
		delete $db_hash{"$randomcode"};
	}
}

$currenttime = time();
if (defined($codeentered) && $codeentered && $db_hash{$codeentered} && 
    (($currenttime - $expiretime) <= $db_hash{$codeentered})) {
	# This code is good.  Set the flag and remove the code.
	$codeok++;
	delete $db_hash{"$codeentered"};
} else {
	# Fail silently.
	;
}

$db_obj->sync();                   # to flush
flock(DB_FH, LOCK_UN);
undef $db_obj;                     # removing the last reference to the DB
                                   # closes it. Closing DB_FH is implicit.
untie %db_hash;

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
    print &summary_link;
    print &html_footer;
    exit 0;
}

unless (open(Q, "$query_pr -F $pr 2>&1 |")) {
    print &html_header("Server error");
    print "<p>Unable to open PR database.</p>\n";
    print &summary_link;
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

    if (/^query-pr(:?\.(:?real|web))?: /) {
	print &html_header("FreeBSD problem report");
	if ($_ !~ /^query-pr(:?\.(:?real|web))?: no PRs matched$/) {
	    print "<P>query-pr said:\n";
	    print "<pre>$_\n";
	    print <Q>;
	    print "</pre>\n";
	} else {
	    print "<p>No PR found matching $pr</p>\n";
	}
	print &summary_link;
	print &html_footer;
	exit;
    } elsif (/^lockf: /) {
	print &html_header("FreeBSD problem report");
	print "<p>The PR database is currently busy; please try ",
	    "<a href='./query-pr.cgi?pr=$pr'>your query</a> again.</p>";
	print &summary_link;
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
	$_ = ">Responsible:<a href='mailto:$_'>$_</a>";
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
	print &html_header("Problem Report $cat/$number : $syn");
	if (! $codeok ) {
	    print "<p><a href='#SEEMAIL'>View PR with email
		addresses</a></p>\n";
	}
	print "<p><strong>$syn</strong></p>\n<dl>\n";
    } else {
	next if $inhdr;

	if (/^>(\S+):\s*(.*)/) {
	    print $trailer . "\n" unless ($blank);
	    $trailer = "<dt><strong>$1</strong></dt><dd>\n";
	    if ($html_fixup) {
		$trailer .= &fixline($2);
	    } else {
		$trailer .= $2;
	    }
	    if ($1 eq "Originator" && $from ne "" && $codeok) {	# add email address
		$trailer .= " &lt;<a href='mailto:$email'>" . &fixline($from) . "</a>&gt;";
	    }
	    $trailer .= '</dd>';
	    $blank = !($2);
	    $multiline = 0;
	} else {
	    unless ($multiline) {
		next if /^\s*$/;
		print $trailer . "\n<dd><pre>\n";
	    }
	    $multiline = 1;
	    $blank = 0;
	    print $html_fixup ? &fixline($_) : $_ , "\n";
	    $trailer = "</pre></dd>";
	}
    }
}
close(Q);

print "$trailer\n" unless ($blank);
print "</dl>";

$origsyn =~ s/[^a-zA-Z+.@-]/"%" . sprintf("%02X", unpack("C", $&))/eg;
$email =~ s/[^a-zA-Z+.@-]/"%" . sprintf("%02X", unpack("C", $&))/eg;

print qq`<a href="mailto:bug-followup\@FreeBSD.org,${email}?subject=Re:%20${cat}/${number}:%20$origsyn">Submit Followup</a> | <a href="./query-pr.cgi?pr=$pr&amp;f=raw">Raw PR</a> | <a href="./query-pr-summary.cgi?query">Find Another PR</a>\n`;

if (! $codeok ) {
    print "<a name='SEEMAIL' id='SEEMAIL' />";
    print "<p>To see this PR with email addresses ";
    print " displayed, enter the code from the image and submit: </p>\n";
    print "<form method='post' action='$scriptname'>\n";
    print "<input type='hidden' name='pr' value='$number'/>\n";
    print "<input type='text' name='code-confirm' ";
    print " id='code-confirm' size='8' />\n";
    print "<label for='code-confirm'>";
    print "<img src='http://www.FreeBSD.org/cgi/querypr-code.cgi?dummy=1' ";
    print " alt='Random text; if you cannot see the image, please email ";
    print " bugbusters\@FreeBSD.org' border='0' height='24' /></label>\n";
    print "<input type='submit' value='Go' />\n";
    print "</form>\n";
}

print &html_footer;

# Sleep 0.35 seconds to avoid DoS attacks from broken robots
select undef, undef, undef, 0.35;

exit 0;

sub getline
{
    local($_) = @_;
    ($tag,$remainder) = split(/\s+/, $_, 2);
    return $remainder;
}

sub summary_link {
	return qq`<p><a href="./query-pr-summary.cgi?query">Search for Another PR</a></p>\n`;
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
	    $_ = "<a href='$href'>$html</a>";
	} else {
	    s/&/&amp;/g;
	    s/</&lt;/g;
	    s/>/&gt;/g;
	    s%(\WPR[:s# \t]+)([a-z3486]+\/)?([0-9]+)%$1<a href="query-pr.cgi?pr=$3">$2$3</a>%ig;
	}
	$isurl = ! $isurl;
    }

    return &srcref(join('', @splitline));
}
