#!/usr/bin/perl -T
# $FreeBSD: www/en/cgi/query-pr-summary.cgi,v 1.42 2003/12/27 14:44:57 ceri Exp $

sub escape($) { $_ = $_[0]; s/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g; $_; }

$html_mode     = 1 if $ENV{'DOCUMENT_ROOT'};
$self_ref      = $ENV{'SCRIPT_NAME'};
($query_pr_ref = $self_ref) =~ s/-summary//;

$ENV{'PATH'}   = '/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin';

$project       = "FreeBSD";
$mail_prefix   = "freebsd-";
$mail_unass    = "freebsd-bugs";
$ports_unass   = "ports-bugs";
$closed_too    = 0;

require "./cgi-lib.pl";
require "./cgi-style.pl";
require "getopts.pl";

if ($ENV{'QUERY_STRING'} eq 'query') {
	print &html_header("Query $project problem reports");
	&displayform;
	print &html_footer;
	exit(0);
}

if ($html_mode) {
	$query_args   = '--restricted ';
	&ReadParse(*input) if $html_mode;

} else {
	&Getopts('CcqRr:s:');

	$input{"responsible"}	= "summary" if $opt_R;
	if ($opt_r) {
		($input{"responsible"})	= ($opt_r =~ m/^(\^?[-_a-zA-Z0-9@.]*\$?)$/);
		die "Insecure args" if ($input{"responsible"} ne $opt_r)
	}
	if ($opt_s) {
		($input{"state"})	= ($opt_s =~ m/^([a-zA-Z]*)$/);
		die "Insecure args" if ($input{"state"} ne $opt_s)
	}
	$input{"quiet"}		= "yes" if $opt_q;
	if ($opt_C) {
		$query_args   = '--confidential=yes ';
	} elsif (!$opt_c) {
		$query_args   = '--restricted ';
	}
}

$closed_too = 1 if $input{'state'} eq 'closed' || $input{'closedtoo'};

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

sub cgiparam {
    local ($result) = @_;

    $result =~ s/[^A-Za-z0-9+.@-]/"%".sprintf("%02X", unpack("C", $&))/ge;
    $result;
}

sub header_info {
    if ($html_mode) {
	print &html_header("Current $project problem reports");
    }
    else {
	print "Current $project problem reports\n";
    }

print <<EOM unless $input{"quiet"};

The following is a listing of current problems submitted by $project users.
These represent problem reports covering all versions including
experimental development code and obsolete releases.
${p}
Bugs can be in one of several states:
${dl}
${dt}${st}o - open${st_e}
${dd}A problem report has been submitted, no sanity checking performed.

${dt}${st}a - analyzed${st_e}
${dd}The problem is understood and a solution is being sought.

${dt}${st}f - feedback${st_e}
${dd}Further work requires additional information from the
${dd_x}originator or the community - possibly confirmation of
${dd_x}the effectiveness of a proposed solution.

${dt}${st}p - patched${st_e}
${dd}A patch has been committed, but some issues (MFC and / or
${dd_x}confirmation from originator) are still open.

${dt}${st}r - repocopy${st_e}
${dd}The resolution of the problem report is dependent on
${dd_x}a repocopy operation within the CVS repository which
${dd_x}is awaiting completion.

${dt}${st}s - suspended${st_e}
${dd}The problem is not being worked on, due to lack of information
${dd_x}or resources.  This is a prime candidate
${dd_x}for somebody who is looking for a project to do.
${dd_x}If the problem cannot be solved at all,
${dd_x}it will be closed, rather than suspended.

${dt}${st}c - closed${st_e}
${dd}A problem report is closed when any changes have been integrated,
${dd_x}documented, and tested -- or when fixing the problem is abandoned.
${dl_e}
EOM

	if ($html_mode) {

# These self references are attempts to only change a single variable at a time.
# If someone does a multiple-variable query they will probably do weird things.

$self_ref1 = $self_ref . '?';
$self_ref1 .= 'sort=' . escape($input{'sort'}) if $input{'sort'};
print '<P>You may view summaries by <A HREF="', $self_ref1, '">Severity</A>, ';
$self_ref1 .= '&' if ($self_ref1 !~/\?$/);
print '<A HREF="', $self_ref1, 'state=summary">State</A>, ';
print '<A HREF="', $self_ref1, 'category=summary">Category</A>, or ';
print '<A HREF="', $self_ref1, 'responsible=summary">Responsible Party</A>.';

$self_ref2 = $self_ref . '?';
foreach ("category", "originator", "priority", "class", "responsible",
	"severity", "state", "submitter", "text", "multitext", "closedtoo") {
	if ($input{$_}) {
		$self_ref2 .= '&' if ($self_ref2 !~/\?$/);
		$self_ref2 .= $_ . '=' . cgiparam($input{$_});
	}
}

print 'You may also sort by ';
print '<A HREF="', $self_ref2, '&sort=lastmod">Last-Modified</A>, ';
print '<A HREF="', $self_ref2, '&sort=category">Category</A>, or ';
print '<A HREF="', $self_ref2, '&sort=responsible">Responsible Party</A>.', "\n";
print 'Or <A HREF="', $self_ref, '?query">formulate a specific query</A>.', "\n";

$self_ref3 = $self_ref . '?';
foreach ("category", "originator", "priority", "class", "responsible",
	"severity", "state", "submitter", "text", "multitext", "sort") {
	if ($input{$_}) {
		$self_ref3 .= '&' if ($self_ref2 !~/\?$/);
		$self_ref3 .= $_ . '=' . cgiparam($input{$_});
	}
}

if ($input{"closedtoo"}) {
	print '<A HREF="', $self_ref3, '">Don',"'",'t show closed reports</A>.';
} else {
	print '<A HREF="', $self_ref3, '&closedtoo=on">Include closed reports too</A>.';
}

	}
}

sub trailer_info {
    print &html_footer if $html_mode;
}

&header_info;

#Usage: query-pr [-FGhiPRqVx] [-C confidential] [-c category] [-d directory]
#       [-e severity] [-m mtext] [-O originator] [-o outfile] [-p priority]
#       [-L class] [-r responsible] [-S submitter] [-s state] [-t text]
#       [-b date] [-a date] [-B date] [-M date] [-z date] [-Z date]
#       [-y synopsis] [-A release] [--full] [--help] [--print-path] [--version]
#       [--summary] [--sql] [--skip-closed] [--category=category]
#       [--confidential=yes|no] [--directory=directory] [--output=outfile]
#       [--originator=name] [--priority=level] [--class=class]
#       [--responsible=person] [--release=release] [--restricted]
#       [--quarter=quarter] [--keywords=regexp]
#       [--required-before=date] [--required-after=date]
#       [--arrived-before=date] [--arrived-after=date]
#       [--modified-before=date] [--modified-after=date]
#       [--closed-before=date] [--closed-after=date]
#       [--severity=severity] [--state=state] [--submitter=submitter]
#       [--list-categories] [--list-classes] [--list-responsible]
#       [--list-states] [--list-submitters] [--list-config]
#       [--synopsis=synopsis] [--text=text] [--multitext=mtext] [PR] [PR]...

$query_args .= " --skip-closed" unless $closed_too;

# Only read the appropriate PR's.
foreach ("category", "originator", "priority", "class", "responsible",
	"release", "severity", "state", "submitter", "text", "multitext") {
	if ($input{$_} && $input{$_} ne "summary") {
		$d = $input{$_};
		$d =~ s/^"(.*)"$/$&/;
		$d =~ s/'/\\'/;
		$query_args .= " --${_}='$d'";
	}
}

&read_gnats($query_args);

if ($input{'sort'} eq 'lastmod') {
	@prs = sort {$lastmod{$b} cmp $lastmod{$a}} @prs;
} elsif ($input{'sort'} eq 'category') {
	@prs = sort {($ca,$na)=split(m|/|,$a); ($cb,$nb)=split(m|/|,$b); $ca eq $cb ? $na <=> $nb : $ca cmp $cb} @prs;
} elsif ($input{'sort'} eq 'responsible') {
	@prs = sort {$resp{$a} cmp $resp{$b}} @prs;
} else {
	$input{'sort'} = 'none';
}

if ($#prs < $[) {
	print "${h1}No matches to your query${h1_e}\n";

} elsif ($input{'responsible'} eq 'summary') {
	&resp_summary;

} elsif ($input{'state'} eq 'summary') {
	&state_summary;

} elsif ($input{'category'} eq 'summary') {
	&cat_summary;

} elsif ($input{'severity'} eq '') {
	&severity_summary;

} else {
	&printcnt(&gnats_summary(1, $html_mode));

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

sub cat_summary {
    &get_categories;
    foreach (keys %status) {
	s|/\d+||;
	$cat{$_}++;
    }
    foreach (@categories) {
	next unless $cat{$_};	# skip categories with no bugs.
	print "${h3}Problems in category: $_ ($catdesc{$_})${h3_e}\n";
	if (/^(\w+)/) {
	    &printcnt(&gnats_summary("\$cat eq \"$1\"", $html_mode));
	} else {
	    print "\n??? weird category $_\n";
	}
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

sub state_summary {
    &get_states;
    foreach (@states) {
	next if ($_ eq "closed" && !$input{"closedtoo"});
	print "${h3}Problems in state: $_${h3_e}\n";
	if (/^(\w)/) {
	    &printcnt(&gnats_summary("\$state eq \"$1\" ", $html_mode));
	} else {
	    print "\n??? bad state $state\n";
	}
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

sub get_categories {
    @categories = ();

    open(Q, "query-pr.web --list-categories 2>/dev/null |") ||
	die "Cannot get categories\n";

    while(<Q>) {
	chop;
	local ($cat, $desc, $responsible, $notify) = split(/:/);
	push(@categories, $cat);
	$catdesc{$cat} = $desc;
    }
}

sub get_states {
    @states = ();

    open(Q, "query-pr.web --list-states 2>/dev/null |") ||
	die "Cannot get states\n";

    while(<Q>) {
	chop;
	local ($state, $type, $desc) = split(/:/);
	push(@states, $state);
	$statedesc{$state} = $desc;
    }
}

sub get_classes {
    @classes = ();

    open(Q, "query-pr.web --list-classes 2>/dev/null |") ||
	die "Cannot get classes\n";

    while(<Q>) {
	chop;
	local ($class, $type, $desc) = split(/:/);
	push(@classes, $class);
	$classdesc{$class} = $desc;
    }
}

sub read_gnats {
    local($report)   = @_[0];

    open(Q, "query-pr.web $report 2>/dev/null |") || die "Cannot query the PR's\n";

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
	    if ($lastmod =~ /^[ 	]*$/) {	
		$lastmod = $date;
	    } else {
	        # strip timezone if any (between HH:MM:SS and YYYY at end of line):
		$lastmod =~ s/(\d\d:\d\d:\d\d)\D+(\d{4})$/\1 \2/;
		($dow,$mon,$day,$time,$year,$xtra) = split(/[ \t]+/, $lastmod);
		$day = "0$day" if $day =~ /^[0-9]$/;
	        $lastmod = "$year/$mons{$mon}/$day";
	    }

	} elsif (/>Category:/) {
	    $cat = &getline($_);

	} elsif (/>Severity:/) {
	    $sev = &getline($_);

	} elsif (/>Responsible:/) {
	    $resp = &getline($_);
	    $resp =~ s/@.*//;
	    $resp =~ tr/A-Z/a-z/;
	    $resp = "" if (($resp =~ /$mail_unass/o) or ($resp =~ /$ports_unass/o));
	    $resp =~ s/^$mail_prefix//;

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

	print "${pr}\nS  Submitted   Tracker     Resp.       Description${hr}"
	    if ($iteration++ == 0);

	$syn = &html_fixline($syn) if $htmlmode;

	if ($htmlmode) {
	    $title = '<a href="' . $query_pr_ref . '?pr='. $cat . '/' . $number . '">' .
		     $_ . '</a> ';
	} else {
	    $title = $_;
	}

	print "$state [$date] $title" .
	    (' ' x (16 - length($_))) .
	    $resp . (' ' x (12 - length($resp))) .
	    ($htmlmode ? $syn : substr($syn,0,41))
	    . "\n";

	++$counter;
    }

    print "${pr_e}\n" if $iteration;

    $counter;
}

sub displayform {
print qq`
Please select the items you wish to search for.  Multiple items are AND'ed
together.
<P>
<FORM METHOD=GET ACTION="`, $self_ref, qq`">

<TABLE>
<TR>
<TD><B>Category</B>:</TD>
<TD><SELECT NAME="category">
<OPTION SELECTED VALUE="">Any</OPTION>`;

&get_categories;
foreach (sort @categories) {
    #print "<OPTION VALUE=\"$_\">$_ ($catdesc{$_})</OPTION>\n";
    print "<OPTION>$_</OPTION>\n";
}

print qq`
</SELECT></TD>
<TD><B>Severity</B>:</TD>
<TD><SELECT NAME="severity">
<OPTION SELECTED VALUE="">Any</OPTION>
<OPTION>non-critical</OPTION>
<OPTION>serious</OPTION>
<OPTION>critical</OPTION>
</SELECT></TD>
</TR><TR>
<TD><B>Priority</B>:</TD>
<TD><SELECT NAME="priority">
<OPTION SELECTED VALUE="">Any</OPTION>
<OPTION>low</OPTION>
<OPTION>medium</OPTION>
<OPTION>high</OPTION>
</SELECT></TD>
<TD><B>Class</B>:</TD>
<TD><SELECT NAME="class">
<OPTION SELECTED VALUE="">Any</OPTION>
`;

&get_classes;
foreach (@classes) {
	#print "<OPTION VALUE=\"$_\">$_ ($classdesc{$_})</OPTION>\n";
	print "<OPTION>$_</OPTION>\n";
}

print qq`</SELECT></TD>
</TR><TR>
<TD><B>State</B>:</TD>
<TD><SELECT NAME="state">
<OPTION SELECTED VALUE="">Any</OPTION>
`;

&get_states;
foreach (@states) {
	($us = $_) =~ s/^./\U$&/;
	print "<OPTION VALUE=\"$_\">";
	#print "$us ($statedesc{$_})</OPTION>\n";
	print "$us</OPTION>\n";
}

print qq`</SELECT></TD>
<TD><B>Sort by</B>:</TD>
<TD><SELECT NAME="sort">
<OPTION SELECTED VALUE="none">No Sort</OPTION>
<OPTION VALUE="lastmod">Last-Modified</OPTION>
<OPTION VALUE="category">Category</OPTION>
<OPTION VALUE="responsible">Responsible Party</OPTION>
</SELECT></TD>
</TR><TR>
<!-- We don't use submitter Submitter: -->
<TD><B>Text in single-line fields</B>:</TD>
<TD><INPUT TYPE=TEXT NAME="text"></TD>
<TD><B>Responsible</B>:</TD>
<TD><INPUT TYPE=TEXT NAME="responsible"></TD>
</TR><TR>
<TD><B>Text in multi-line fields</B>:</TD>
<TD><INPUT TYPE=TEXT NAME="multitext"></TD>
<TD><B>Originator</B>:</TD>
<TD><INPUT TYPE=TEXT NAME="originator"></TD>
</TR><TR>
<TD><B>Closed reports too</B>:</TD>
<TD><INPUT NAME="closedtoo" TYPE=CHECKBOX></TD>
<TD><B>Release</B>:</TD>
<TD><SELECT NAME="release">
<OPTION SELECTED VALUE="">Any</OPTION>
<OPTION VALUE="^FreeBSD [234]">Pre-5.x</OPTION>
<OPTION VALUE="^FreeBSD 5">5.x only</OPTION>
<OPTION VALUE="^FreeBSD 4">4.x only</OPTION>
<OPTION VALUE="^FreeBSD 3">3.x only</OPTION>
<OPTION VALUE="^FreeBSD 2">2.x only</OPTION>
</SELECT>
</TR>
</TABLE>
<INPUT TYPE="SUBMIT" VALUE=" Query PR's ">
<INPUT TYPE="RESET" VALUE=" Reset Form ">
</FORM>
`;
}
