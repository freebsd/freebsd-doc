#!/usr/bin/perl
# $Id: query-pr-summary.cgi,v 1.4 1996-10-22 23:12:08 fenner Exp $

$self_ref = $ENV{'SCRIPT_NAME'};
($query_pr_ref = $ENV{'SCRIPT_NAME'}) =~ s/-summary//;
$query_args   = '--restricted -s "open|analyzed|feedback|suspended"';
$state_args   = '--restricted ';

$avail_file   = '/home/ncvs/CVSROOT/avail';
$ENV{'PATH'}  = "/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin";

$html_mode    = 1 if $ENV{'DOCUMENT_ROOT'} ne '';

require "cgi-lib.pl";
require "cgi-style.pl";
require "getopts.pl";

if ($html_mode) {
    &ReadParse(*input) if $html_mode;

} else {
	&Getopts('qRr:s:');

	$input{"responsible"} = "summary" if $opt_R;
	$input{"responsible"} = $opt_r if $opt_r;
	$input{"state"}	      = $opt_s if $opt_s;
	$input{"quiet"}	      = $opt_q if $opt_q;
}

#------------------------------------------------------------------------

%mons = ('Jan', '01',  'Feb', '02',  'Mar', '03',
	 'Apr', '04',  'May', '05',  'Jun', '06',
	 'Jul', '07',  'Aug', '08',  'Sep', '09',
	 'Oct', '10',  'Nov', '11',  'Dec', '12');


if ($html_mode) {
    $h1 = "<h1>"; $h1_e = "</h1>";
    $h2 = "<h2>"; $h2_e = "</h2>";
    $h3 = "<h3>"; $h3_e = "</h3>";
    $h4 = "<h4>"; $h4_e = "</h4>";
    $p  = "<p>" ; $p_e  = "</p>";
    $br = "<br>";

    $st = "<strong>"; $st_e = "</strong>";
    $pr = "<pre>";    $pr_e = "</pre>";
    $dl = "<dl>";     $dl_e = "</dl>";
    $dt = "<dt>";
    $dd = "<dd>";     $dd_x = "";
    $hr = "<hr>";

#    print "Content-type: text/html\n";

} else {

    $h1 = ""; $h1_e = "";
    $h2 = ""; $h2_e = "";
    $h3 = ""; $h3_e = "";
    $h4 = ""; $h4_e = "";
    $p  = ""; $p_e  = "";
    $br = "";
    $st = ""; $st_e = "";
    $pr = ""; $pr_e = "";
    $dl = ""; $dl_e = "";
    $dt = "";
    $dd = "     "; $dd_x = "     ";
    $hr = "\n----------------------------------------" .
	  "---------------------------------------\n";
}

sub header_info {
    if ($html_mode) {
	print &html_header("Current FreeBSD problem reports");
    }
    else {
	print "Current FreeBSD problem reports";
    }

print "

The following is a listing of current problems submitted by FreeBSD users.
These represent problem reports covering all versions fo FreeBSD including
experimental development code and obsolete releases.
${p}
Bugs can be in one of several states:
${dl}
${dt}${st}o - open${st_e}
${dd}A problem report has been submitted, no sanity checking performed.

${dt}${st}a - analyzed${st_e}
${dd}The report has been examined by a team member and evaluated.

${dt}${st}f - feedback${st_e}
${dd}The problem has been solved, and the originator has been given a
${dd_x}patch or a fix has been committed.  The PR remains in this state
${dd_x}pending a response from the originator.

${dt}${st}s - suspended${st_e}
${dd}Work on the problem has been postponed.  This happens if a
${dd_x}timely solution is not possible or is not cost-effective at
${dd_x}the present time.  The PR continues to exist, though a solution
${dd_x}is not being actively sought.  If the problem cannot be solved at all,
${dd_x}it will be closed, rather than suspended.

${dt}${st}c - closed${st_e}
${dd}A problem report is closed when any changes have been integrated,
${dd_x}documented, and tested.
${dl_e}
" if (!$input{"quiet"});

	if ($html_mode) {
$self_ref1 = $self_ref . '?';
if ($input{'sort'}) {
	$self_ref1 .= 'sort=' . $input{'sort'};
}
print '<P>You may view summaries by <A HREF="', $self_ref1, '">Severity</A>, ';
print '<A HREF="', $self_ref1, '&state=summary">State</A>, ';
print '<A HREF="', $self_ref1, '&category=summary">Category</A>, or ';
print '<A HREF="', $self_ref1, '&responsible=summary">Responsible Party</A>.';
$self_ref2 = $self_ref . '?';
foreach ('responsible','state','category') {
	if ($input{$_}) {
		$self_ref2 .= $_ . '=' . $input{$_};
		last;
	}
}
print 'You may also sort by ';
print '<A HREF="', $self_ref2, '&sort=lastmod">Last-Modified</A>, ';
print '<A HREF="', $self_ref2, '&sort=category">Category</A>, or ';
print '<A HREF="', $self_ref2, '&sort=responsible">Responsible Party</A>.', "\n";
	}
}

sub trailer_info {
print &html_footer if $html_mode;
}

&header_info;

# backwards compatibility
$input{'responsible'} = $input{'engineer'} if $input{'engineer'};

&read_gnats($query_args);

if ($input{'sort'} eq 'lastmod') {
	@prs = sort {$lastmod{$b} <=> $lastmod{$a}} @prs;
} elsif ($input{'sort'} eq 'category') {
	@prs = sort {($ca,$na)=split(m|/|,$a); ($cb,$nb)=split(m|/|,$b); $ca eq $cb ? $na <=> $nb : $ca cmp $cb} @prs;
} elsif ($input{'sort'} eq 'responsible') {
	@prs = sort {$resp{$a} cmp $resp{$b}} @prs;
} else {
	$input{'sort'} = 'none';
}

if ($input{'responsible'} eq 'summary') {
	&resp_summary;

} elsif ($input{'responsible'} ne '') {
	&resp_query($input{'responsible'});

} elsif ($input{'state'} eq 'summary') {
	&state_summary;

} elsif ($input{'state'} ne '') {
	&state_query($input{'state'});

} elsif ($input{'category'} eq 'summary') {
	&cat_summary;

} elsif ($input{'category'} ne '') {
	&cat_query($input{'category'});

} else {
	&severity_summary;
}

&trailer_info;
exit(0);

#------------------------------------------------------------------------

sub getline {
    local($_) = @_;
    ($tag,$remainder) = split(/[ \t]+/, $_, 2);
    return $remainder;
}

sub html_fixline {
    local($line) = @_[0];

    $line =~ s/&/&amp;/g;
    $line =~ s/</&lt;/g;
    $line =~ s/>/&gt;/g;

    $line;
}

sub printcnt {
    local($cnt) = $_[0];

    if ($cnt) {
	printf("%d problem%s total.\n\n", $cnt, $cnt == 1 ? "" : "s");
    }
}

sub cat_query {
    local($cat) = $_[0];

    &printcnt(&gnats_summary("\$cat eq \"$cat\"", $html_mode));
}

sub cat_summary {
    foreach (keys %status) {
	s|/\d+||;
	$cat{$_}++;
    }
    foreach (sort keys %cat) {
	&cat_query($_);
    }
}

sub resp_query {
    local($resp) = @_[0];
    local($cnt);

    $cnt = &gnats_summary("\$resp eq \"$resp\"", $html_mode);
    print "${hr}${b}No problem reports assigned to $resp${b_e}\n"
	if (!$input{"quiet"} && $cnt == 0);
}

sub resp_summary {
    local($who, %who);

    foreach (keys %resp) {
	$who{$resp{$_}}++;
    }
    foreach $who (sort keys %who) {
	$cnt = &gnats_summary("\$resp eq \"$who\"", $html_mode);
    }
}

sub state_query {
    local($state) = @_[0];
    local(%statemap) = ("open", "o", "analyzed", "a", "feedback", "f", "suspended", "s", "closed", "c");

    print "${h3}Problems in state: $state${h3_e}\n";
    $state = $statemap{$state} if ($statemap{$state} ne '');
    &printcnt(&gnats_summary("\$state eq \"$state\" ", $html_mode));
}

sub state_summary {
    foreach ("open", "analyzed", "feedback", "suspended") {
	&state_query($_);
    }
}

sub severity_summary {
    print "${h3}Critical problems${h3_e}\n";
    &printcnt(&gnats_summary('$severity eq "critical"', $html_mode));

    print "${h3}Serious problems${h3_e}\n";
    &printcnt(&gnats_summary('$severity eq "serious"', $html_mode));

    print "${h3}Non-critical problems${h3_e}\n";
    &printcnt(&gnats_summary('$severity eq "non-critical"', $html_mode));
}

sub read_gnats {
    local($report)   = @_[0];

    open(Q, "query-pr " . $report . " 2>/dev/null |") || 
	die "Cannot query the PR's\n";

    while(<Q>) {
	chop;
	if(/^>Number:/) {
	    $number = &getline($_);

	} elsif (/Arrival-Date:/) {
	    $date = &getline($_);
	    # strip timezone if any (between HH:MM:SS and YYYY at end of line):
	    $date =~ s/(\d\d:\d\d:\d\d)\D+(\d{4})$/\1 \2/;
	    ($dow,$mon,$day,$time,$year,$xtra) = split(/[ \t]+/, $date);
	    $day = "0$day" if $day =~ /^[0-9]$/;
	    $date = "$year/$mons{$mon}/$day";

	} elsif (/>Last-Modified:/) {
	    $lastmod = &getline($_);
	    $lastmod =~ s/(\d\d:\d\d:\d\d)\D+(\d{4})$/\1 \2/;
	    ($dow,$mon,$day,$time,$year,$xtra) = split(/[ \t]+/, $lastmod);
	    $day = "0$day" if $day =~ /^[0-9]$/;
	    $lastmod = "$year$mons{$mon}$day";

	} elsif (/>Category:/) {
	    $cat = &getline($_);

	} elsif (/>Severity:/) {
	    $sev = &getline($_);

	} elsif (/>Responsible:/) {
	    $resp = &getline($_);
	    $resp =~ s/@.*//;
	    $resp =~ tr/A-Z/a-z/;
	    $resp = "" if ($resp =~ /freebsd-bugs/);
	    $resp =~ s/^freebsd-//;
	    $resp = substr($resp, 0, 8);

	} elsif (/>State:/) {
	    $status = &getline($_);
	    $status =~ s/(.).*/\1/;

	} elsif (/>Synopsis:/) {
	    $syn = &getline($_);
	    $syn =~ s/[\t]+/ /g;

	} elsif (/^$/) {
	    $_ = sprintf("%s/%s", $cat, $number);

	    $status{$_} = $status;
	    $date{$_} = $date;
	    $resp{$_} = $resp;
	    $syn{$_} = $syn;
	    $sev{$_} = $sev;
	    $lastmod{$_} = $lastmod;
	    push(@prs,$_);
	}
    }
    close(Q);
}

sub gnats_summary {
    local($report)   = @_[0];
    local($htmlmode) = @_[1];
    local($counter)  = 0;
    local($iteration)= 0;

    foreach (@prs) {
	$state = $status{$_};
	$date = $date{$_};
	$resp = $resp{$_};
	$syn = $syn{$_};
	$severity = $sev{$_};
	($cat, $number) = m|^([^/]+)/(\d+)$|;

	next if (($report ne '') && (eval($report) == 0));

	print "${pr}\nS  Submitted   Tracker    Engr.    Description${hr}"
	    if ($iteration++ == 0);

	$syn = &html_fixline($syn) if $htmlmode;

	if ($htmlmode) {
	    $title = '<a href="' . $query_pr_ref . '?pr='. $number . '">' .
		     $_ . '</a>';
	} else {
	    $title = $_;
	}

	print "$state [$date] $title" .
	    (' ' x (11 - length($_))) .
	    $resp . (' ' x (9 - length($resp))) .
	    substr($syn,0,41)
	    . "\n";

	++$counter;
    }

    print "${pr_e}\n" if $iteration;

    $counter;
}
