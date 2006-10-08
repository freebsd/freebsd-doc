#!/usr/bin/perl -T
# $FreeBSD: www/en/cgi/query-pr-summary.cgi,v 1.56 2006/09/24 13:34:55 danger Exp $

$html_mode     = 1 if $ENV{'DOCUMENT_ROOT'};
$self_ref      = $ENV{'SCRIPT_NAME'};
($query_pr_ref = $self_ref) =~ s/-summary//;

$ENV{'PATH'}   = '/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin';

$project       = 'FreeBSD';
$mail_prefix   = 'freebsd-';
$mail_unass    = 'freebsd-bugs';
$ports_unass   = 'ports-bugs';
$closed_too    = 0;

require './cgi-lib.pl';
require './cgi-style.pl';
require 'getopts.pl';

if (!$ENV{'QUERY_STRING'} or $ENV{'QUERY_STRING'} eq 'query') {
	print &html_header("Query $project problem reports");
	&displayform;
	print &html_footer;
	exit(0);
}

if ($html_mode) {
	$query_args   = '--restricted ';
	&ReadParse(*input);
} else {
	&Getopts('CcqRr:s:T:');

	$input{'responsible'}	= 'summary' if $opt_R;
	if ($opt_r) {
		($input{'responsible'})	= ($opt_r =~ m/^(\^?[-_a-zA-Z0-9@.]*\$?)$/);
		die 'Insecure args' if ($input{'responsible'} ne $opt_r)
	}
	if ($opt_s) {
		($input{'state'})	= ($opt_s =~ m/^([a-zA-Z]*)$/);
		die 'Insecure args' if ($input{'state'} ne $opt_s)
	}
	$input{'quiet'}		= 'yes' if $opt_q;
	if ($opt_C) {
		$query_args   = '--confidential=yes ';
	} elsif (!$opt_c) {
		$query_args   = '--restricted ';
	}
	if ($opt_T) {
		($tag)	= ($opt_T =~ m/^(\^?[-_a-zA-Z0-9@.]*\$?)$/);
		die 'Insecure args' if ($tag ne $opt_T);
		$input{'text'} = '\[' . $tag . '\]';
	}
}

$closed_too = 1 if $input{'state'} eq 'closed' || $input{'closedtoo'};

#------------------------------------------------------------------------

%mons = ('Jan', '01',  'Feb', '02',  'Mar', '03',
	 'Apr', '04',  'May', '05',  'Jun', '06',
	 'Jul', '07',  'Aug', '08',  'Sep', '09',
	 'Oct', '10',  'Nov', '11',  'Dec', '12');


if ($html_mode) {

    $pr = '<pre>';    $pr_e = '</pre>';
    $h1 = '<h1>';     $h1_e = '</h1>';
    $h3 = '<h3>';     $h3_e = '</h3>';
    $hr = '<hr/>';

    $table   = "<table width='100%' border='0' cellspacing='1' cellpadding='0'>";
    $table_e = '</table>';

    # Customizations for the look and feel of the summary tables.
    $t_style = "<style type='text/css'><!--\n" .
	"table { background-color: #ccc; color: #000; }\n" .
	"tr { padding: 0; }\n" .
	"th { background-color: #cbd2ec; color: #000; padding: 2px;\n" .
	"     text-align: left; font-weight: normal; font-style: italic; }\n" .
	"td { color: #000; padding: 2px; }\n" .
	"td a { text-decoration: none; }\n" .
	".o { background-color: #fff; }\n" .
	".a { background-color: #cffafd; }\n" .
	".f { background-color: #ffc; }\n" .
	".p { background-color: #d1fbd6; }\n" .
	".r { background-color: #d6cfc4; }\n" .
	".s { background-color: #fcccd9; }\n" .
	".c { background-color: #c1d5db; }\n" .
	"--></style>";

} else {

    $pr = ''; $pr_e = '';
    $h1 = ''; $h1_e = '';
    $h3 = ''; $h3_e = '';
    $hr = "\n----------------------------------------" .
	    "---------------------------------------\n";

    $table   = '';
    $table_e = '';
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
    if (!$input{'quiet'}) {
       print "The following is a listing of current problems submitted by $project users. " .
	  'These represent problem reports covering all versions including ' .
	  'experimental development code and obsolete releases. ';
       if ($html_mode) {
	  print <<EOM;

<p>
Bugs can be in one of several states:
</p>
<dl>
<dt class='o'><strong>o - open</strong></dt>
<dd>A problem report has been submitted, no sanity checking
performed.</dd>

<dt class='a'><strong>a - analyzed</strong></dt>
<dd>The problem is understood and a solution is being sought.</dd>

<dt class='f'><strong>f - feedback</strong></dt>
<dd>Further work requires additional information from the originator
or the community - possibly confirmation of the effectiveness of a
proposed solution.</dd>

<dt class='p'><strong>p - patched</strong></dt>
<dd>A patch has been committed, but some issues (MFC and / or
confirmation from originator) are still open.</dd>

<dt class='r'><strong>r - repocopy</strong></dt>
<dd>The resolution of the problem report is dependent on a repocopy
operation within the CVS repository which is awaiting completion.</dd>

<dt class='s'><strong>s - suspended</strong></dt>
<dd>The problem is not being worked on, due to lack of information or
resources.  This is a prime candidate for somebody who is looking for a
project to do. If the problem cannot be solved at all, it will be
closed, rather than suspended.</dd>

<dt class='c'><strong>c - closed</strong></dt>
<dd>A problem report is closed when any changes have been integrated,
documented, and tested -- or when fixing the problem is abandoned.</dd>
</dl>
EOM

       } else {

print <<EOM;

Bugs can be in one of several states:

o - open
A problem report has been submitted, no sanity checking performed.

a - analyzed
The problem is understood and a solution is being sought.

f - feedback
Further work requires additional information from the
     originator or the community - possibly confirmation of
     the effectiveness of a proposed solution.

p - patched
A patch has been committed, but some issues (MFC and / or
     confirmation from originator) are still open.

r - repocopy
The resolution of the problem report is dependent on
     a repocopy operation within the CVS repository which
     is awaiting completion.

s - suspended
The problem is not being worked on, due to lack of information
     or resources.  This is a prime candidate
     for somebody who is looking for a project to do.
     If the problem cannot be solved at all,
     it will be closed, rather than suspended.

c - closed
A problem report is closed when any changes have been integrated,
     documented, and tested -- or when fixing the problem is abandoned.
EOM
       }
    }

	if ($html_mode) {

# These self references are attempts to only change a single variable at a time.
# If someone does a multiple-variable query they will probably do weird things.

$self_ref1 = $self_ref . '?';
$self_ref1 .= 'sort=' . html_fixline($input{'sort'}) if $input{'sort'};
print "<p>You may view summaries by <a href='$self_ref1'>Severity</a>, ";
$self_ref1 .= '&amp;' if ($self_ref1 !~/\?$/);
print "<a href='${self_ref1}state=summary'>State</a>, ";
print "<a href='${self_ref1}category=summary'>Category</a>, or ";
print "<a href='${self_ref1}responsible=summary'>Responsible Party</a>.";

$self_ref2 = $self_ref . '?';
foreach ('category', 'originator', 'priority', 'class', 'responsible',
	'severity', 'state', 'submitter', 'text', 'multitext', 'closedtoo') {
	if ($input{$_}) {
		$self_ref2 .= '&amp;' if ($self_ref2 !~/\?$/);
		$self_ref2 .= $_ . '=' . cgiparam($input{$_});
	}
}

print 'You may also sort by ';
print "<a href='$self_ref2&amp;sort=lastmod'>Last-Modified</a>, ";
print "<a href='$self_ref2&amp;sort=category'>Category</a>, or ";
print "<a href='$self_ref2&amp;sort=responsible'>Responsible Party</a>.\n";
print "Or <a href='$self_ref?query'>formulate a specific query</a>.\n";

$self_ref3 = $self_ref . '?';
foreach ('category', 'originator', 'priority', 'class', 'responsible',
	'severity', 'state', 'submitter', 'text', 'multitext', 'sort') {
	if ($input{$_}) {
		$self_ref3 .= '&amp;' if ($self_ref2 !~/\?$/);
		$self_ref3 .= $_ . '=' . cgiparam($input{$_});
	}
}

if ($input{'closedtoo'}) {
	print "<a href='$self_ref3'>Do not show closed reports</a>.";
} else {
	print "<a href='$self_ref3&amp;closedtoo=on'>Include closed reports too</a>.";
}

print "</p>\n";

	}
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

$query_args .= ' --skip-closed' unless $closed_too;

# Only read the appropriate PR's.
foreach ('category', 'originator', 'priority', 'class', 'responsible',
	'release', 'severity', 'state', 'submitter', 'text', 'multitext') {
	if ($input{$_} && $input{$_} ne 'summary') {
		# Check if the arguments provided by user are secure.
		# This is required to be able to run this script in
		# taint mode (perl -T)
		if ($input{$_} =~ /^([-^'\/\[\]\@\s\w.]+)$/) {
			$d = $1;
			$d =~ s/^"(.*)"$/$&/;
			$d =~ s/'/\\'/;
			$query_args .= " --${_}='$d'";
		} else {
			print "Insecure data in ${_}! Ignoring this filter.<br />".
			      "Only alphanumeric characters and ', /, -, [, ], ^, @ are allowed.";
		}
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

print &html_footer if $html_mode;

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
	printf("%d problem%s total.\n\n", $cnt, $cnt == 1 ? '' : 's');
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

    open(Q, 'query-pr.web --list-categories 2>/dev/null |') ||
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

    open(Q, 'query-pr.web --list-states 2>/dev/null |') ||
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

    open(Q, 'query-pr.web --list-classes 2>/dev/null |') ||
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

    foreach (@prs) {
	$state = $status{$_};
	$date = $date{$_};
	$resp = $resp{$_};
	$syn = $syn{$_};
	$severity = $sev{$_};
	($cat, $number) = m|^([^/]+)/(\d+)$|;

	next if (($report ne '') && (eval($report) == 0));

	if ($htmlmode) {
	    $title = "<a href='$query_pr_ref?pr=$cat/$number'>$_</a>";
	    $syn = &html_fixline($syn);
	    gnats_summary_line_html($counter, $state, $date, $title, $resp, $syn);
	} else {
	    $title = $_;
	    gnats_summary_line_text($counter, $state, $date, $title, $resp, $syn);
	}

	$counter++;
    }

    if ($htmlmode) {
	print "${table_e}\n" if $counter;
    } else {
	print "${pr_e}\n" if $counter;
    }

    $counter;
}

sub gnats_summary_line_html {
    local($counter)  = shift;
    local($state)    = shift;
    local($date)     = shift;
    local($title)    = shift;
    local($resp)     = shift;
    local($syn)      = shift;

    if ($counter == 0) {
       print "$table<tr><th>S</th><th>Submitted</th><th>Tracker</th><th>Resp.</th><th>Description</th></tr>\n"
    }

    print "<tr class='$state'><td>$state</td><td>$date</td><td>$title</td><td>$resp</td><td>$syn</td></tr>\n";
}

sub gnats_summary_line_text {
    local($counter)  = shift;
    local($state)    = shift;
    local($date)     = shift;
    local($title)    = shift;
    local($resp)     = shift;
    local($syn)      = shift;

    # Print the banner line if this is the first iteration.
    print "${pr}\nS Submitted  Tracker          Resp.     Description${hr}"
	if ($counter == 0);
    print "$state $date $title" .
	(' ' x (17 - length($_))) .
	$resp . (' ' x (10 - length($resp))) .
	substr($syn,0,39) . "\n";
}

sub displayform {
print qq`
<p>
Please select the items you wish to search for.  Multiple items are AND'ed
together.<br />
To generate current list of all open PRs in GNATS database, just press
the "Query PRs" button.
</p>
<form method='get' action='$self_ref'>

<table>
<tr>
<td><b>Category</b>:</td>
<td><select name='category'>
<option selected='selected' value=''>Any</option>`;

&get_categories;
foreach (sort @categories) {
    #print "<option value='$_'>$_ ($catdesc{$_})</option>\n";
    print "<option>$_</option>\n";
}

print qq`
</select></td>
<td><b>Severity</b>:</td>
<td><select name='severity'>
<option selected='selected' value=''>Any</option>
<option>non-critical</option>
<option>serious</option>
<option>critical</option>
</select></td>
</tr><tr>
<td><b>Priority</b>:</td>
<td><select name='priority'>
<option selected='selected' value=''>Any</option>
<option>low</option>
<option>medium</option>
<option>high</option>
</select></td>
<td><b>Class</b>:</td>
<td><select name='class'>
<option selected='selected' value=''>Any</option>
`;

&get_classes;
foreach (@classes) {
	#print "<option value='$_'>$_ ($classdesc{$_})</option>\n";
	print "<option>$_</option>\n";
}

print qq`</select></td>
</tr><tr>
<td><b>State</b>:</td>
<td><select name='state'>
<option selected='selected' value=''>Any</option>
`;

&get_states;
foreach (@states) {
	($us = $_) =~ s/^./\U$&/;
	print "<option value='$_'>";
	#print "$us ($statedesc{$_})</option>\n";
	print "$us</option>\n";
}

print qq`</select></td>
<td><b>Sort by</b>:</td>
<td><select name='sort'>
<option value='none'>No Sort</option>
<option value='lastmod'>Last-Modified</option>
<option value='category'>Category</option>
<option value='responsible'>Responsible Party</option>
</select></td>
</tr><tr>
<!-- We don't use submitter Submitter: -->
<td><b>Text in single-line fields</b>:</td>
<td><input type='text' name='text' /></td>
<td><b>Responsible</b>:</td>
<td><input type='text' name='responsible' /></td>
</tr><tr>
<td><b>Text in multi-line fields</b>:</td>
<td><input type='text' name='multitext' /></td>
<td><b>Originator</b>:</td>
<td><input type='text' name='originator' /></td>
</tr><tr>
<td><b>Closed reports too</b>:</td>
<td><input name='closedtoo' value='on' type='checkbox' /></td>
<td><b>Release</b>:</td>
<td><select name='release'>
<option selected='selected' value=''>Any</option>
<option value='^FreeBSD [2345]'>Pre-6.X</option>
<option value='^FreeBSD 6'>6.X only</option>
<option value='^FreeBSD 5'>5.X only</option>
<option value='^FreeBSD 4'>4.X only</option>
<option value='^FreeBSD 3'>3.X only</option>
<option value='^FreeBSD 2'>2.X only</option>
</select></td>
</tr>
</table>
<input type='submit' value='Query PRs' />
<input type='reset' value='Reset Form' />
</form>
`;
}
