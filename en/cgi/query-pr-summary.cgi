#!/usr/bin/perl

$query_pr_ref = "http://www.freebsd.org/cgi-bin/query-pr.cgi";
$query_args   = '--restricted -s "open|analyzed|feedback|suspended"';
$state_args   = '--restricted ';

$avail_file   = '/home/ncvs/CVSROOT/avail';
$ENV{'PATH'}  = "/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin";

$html_mode    = 1 if $ENV{'DOCUMENT_ROOT'} ne '';

require "/usr/local/www/cgi-bin/cgi-lib.pl";
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

    print "Content-type: text/html\n";

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
print "
<html>
<head>
<title>Current FreeBSD problem reports</title>
</head>
<body>
" if $html_mode;

print "
${h2}Current FreeBSD problem reports${h2_e}

The following is a listing of current problems submitted by FreeBSD users.
These represent problem reports covering all versions fo FreeBSD including
experimental development code and obsolete releases.
${p}
Bugs can be in one of several states:
${dl}
${dt}${st}open${st_e}
${dd}A problem report has been submitted, no sanity checking performed

${dt}${st}analyzed${st_e}
${dd}The report has been examined by a team member and evaluated

${dt}${st}feedback${st_e}
${dd}The problem has been solved, and the originator has been given a
${dd_x}patch or a fix has been committed.  The PR remains in this state
${dd_x}pending a response from the originator.

${dt}${st}suspended${st_e}
${dd}Work on the problem has been postponsed.  This happens if a
${dd_x}timely solution is not possible or is not cost-effective at
${dd_x}the present time.  The PR continues to exist, though a solution
${dd_x}is not being actively sought.  If the problem cannot be solved at all,
${dd_x}it will be closed, rather than suspended.

${dt}${st}closed${st_e}
${dd}A problem report is closed when any changes have been integrated,
${dd_x}documented, and tested.
${dl_e}
" if (!$input{"quiet"});
}

sub trailer_info {
print "
</body>
</html>
" if $html_mode;
}

&header_info;

# backwards compatibility
$input{'responsible'} = $input{'engineer'} if $input{'engineer'};


if ($input{'responsible'} eq 'summary') {
	&resp_summary;

} elsif ($input{'responsible'} ne '') {
	&resp_query($input{'responsible'});

} elsif ($input{'state'} ne '') {
	&state_summary($input{'state'});

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

sub resp_query {
    local($resp) = @_[0];
    local($cnt);

    $cnt = &gnats_summary("-r $resp ". $query_args, $html_mode);
    print "${hr}${b}No problem reports assigned to $resp${b_e}\n"
	if (!$input{"quiet"} && $cnt == 0);
}

sub resp_summary {
    local($master, $who);

    open (AVAIL, "<$avail_file");
    while (<AVAIL>) {
	if (/^avail\|(.*)/) { 
	    $master = $1;
	    foreach $who (split(/,/, $master)) {
		$cnt = &gnats_summary("-r $who " . $query_args, $html_mode);
	    }
	}
    }
    close AVAIL;
}

sub state_summary {
    local($state) = @_[0];
    local($cnt);

    print "${h3}Problems in state: $state${h3_e}\n";
    $cnt = &gnats_summary("-s \"$state\" " . $state_args, $html_mode);
    print "$cnt problems total.\n\n";
}

sub severity_summary {
    local($cnt);

    print "${h3}Critical problems${h3_e}\n";
    $cnt = &gnats_summary('-e critical ' . $query_args, $html_mode);
    print "$cnt problems total.\n\n";

    print "${h3}Serious problems${h3_e}\n";
    $cnt = &gnats_summary('-e serious ' . $query_args, $html_mode);
    print "$cnt problems total.\n\n";

    print "${h3}Non-critical problems${h3_e}\n";
    $cnt = &gnats_summary('-e non-critical ' . $query_args, $html_mode);
    print "$cnt problems total.\n\n";
}

sub gnats_summary {
    local($report)   = @_[0];
    local($htmlmode) = @_[1];
    local($counter)  = 0;
    local($iteration)= 0;

    open(Q, "query-pr " . $report . " 2>/dev/null |") || 
	die "Cannot query the PR's\n";

    while(<Q>) {
	print "${pr}\nS  Submitted   Tracker    Engr.    Description${hr}"
	    if ($iteration++ == 0);

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

	} elsif (/>Category:/) {
	    $cat = &getline($_);

	} elsif (/>Severity:/) {
	    $sev = &getline($_);

	} elsif (/>Responsible:/) {
	    $resp = &getline($_);
	    $resp =~ s/@.*//;
	    $resp =~ tr/A-Z/a-z/;
	    $resp = "" if ($resp =~ /freebsd-bugs/);
	    $resp = substr($resp, 0, 8);

	} elsif (/>State:/) {
	    $status = &getline($_);
	    $status =~ s/(.).*/\1/;

	} elsif (/>Synopsis:/) {
	    $syn = &getline($_);
	    $syn =~ s/[\t]+/ /g;
	    $syn = &html_fixline($syn) if $htmlmode;

	} elsif (/^$/) {
	    $vistitle = sprintf("%s/%s", $cat, $number);
	    if ($htmlmode) {
		$title = '<a href="' . $query_pr_ref . '?pr='. $number . '">' .
			 $vistitle . '</a>';
	    } else {
		$title = $vistitle;
	    }

	    print "$status [$date] $title" .
		(' ' x (11 - length($vistitle))) .
		$resp . (' ' x (9 - length($resp))) .
		substr($syn,0,41)
		. "\n";

	    ++$counter;
	}
    }
    close(Q);

    print "${pr_e}\n" if $iteration;

    $counter;
}
