#!/usr/bin/perl -s
#
# cvsweb - a CGI interface to the CVS tree.
#
# Written by Bill Fenner <fenner@parc.xerox.com> on his own time.
#
# Copyright (c) 1996-1998 Bill Fenner
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
# $FreeBSD: www/en/cgi/cvsweb.cgi,v 1.34 1999/09/08 13:04:09 peter Exp $
#


#HTTP_USER_AGENT: Mozilla/1.1N (X11; I; SunOS 4.1.3_U1 sun4m) via proxy gateway CERN-HTTPD/3.0 libwww/2.17
#SERVER_NAME: www.freebsd.org
#QUERY_STRING: baz
#SCRIPT_FILENAME: /usr/local/www/cgi-bin/env.pl
#SERVER_PORT: 80
#HTTP_ACCEPT: */*, image/gif, image/x-xbitmap, image/jpeg
#SERVER_PROTOCOL: HTTP/1.0
#HTTP_COOKIE: s=beta26429821397802167
#PATH_INFO: /foo/bar
#REMOTE_ADDR: 13.1.64.94
#DOCUMENT_ROOT: /usr/local/www/data/
#PATH: /sbin:/bin:/usr/sbin:/usr/bin
#PATH_TRANSLATED: /usr/local/www/data//foo/bar
#GATEWAY_INTERFACE: CGI/1.1
#REQUEST_METHOD: GET
#SCRIPT_NAME: /cgi-bin/env.pl
#SERVER_SOFTWARE: Apache/1.0.0
#REMOTE_HOST: beta.xerox.com
#SERVER_ADMIN: webmaster@freebsd.org
#
require 'timelocal.pl';
require 'ctime.pl';

$hsty_base = "";
require 'cgi-style.pl';
#&get_the_source;

%CVSROOT = (
	    'freebsd', '/home/ncvs',
	    'learn', '/c/learncvs',
	    );

%CVSROOTdescr = (
	    'freebsd', 'FreeBSD',
	    'learn', 'Learn',
	    );

%mirrors = (
	    'Germany', 'http://www.de.freebsd.org/cgi/cvsweb.cgi',
	    'Spain', 'http://www.es.freebsd.org/cgi/cvsweb.cgi',
	    'California', 'http://www.freebsd.org/cgi/cvsweb.cgi',
	    'Japan', 'http://www.jp.freebsd.org/cgi/cvsweb.cgi',
	   );

$cvstreedefault = 'freebsd';
$cvstree = $cvstreedefault;
$cvsroot = $CVSROOT{"$cvstree"} || "/home/ncvs";


$intro = "
This is a WWW interface to the FreeBSD CVS tree.
You can browse the file hierarchy by picking directories
(which have slashes after them, e.g. <b>src/</b>).
If you pick a file, you will see the revision history
for that file.
Selecting a revision number will download that revision of
the file.  There is a link at each revision to display
diffs between that revision and the previous one, and
a form at the bottom of the page that allows you to
display diffs between arbitrary revisions.
<p>
If you would like to use this CGI script on your own web server and
CVS tree, see <A HREF=\"http://www.freebsd.org/~fenner/cvsweb/\">
the CVSWeb distribution site</A> or the <a 
href=\"http://www.freebsd.org/cgi/cvsweb.cgi/www/data/cgi/cvsweb.cgi\">current</a> FreeBSD version.
<p>
Please send any suggestions, comments, etc. to
<A HREF=\"mailto:fenner\@freebsd.org\">Bill Fenner &lt;fenner\@freebsd.org&gt;</A>
";
$shortinstr = "
Click on a directory to enter that directory. Click on a file to display
its revision history and to get a
chance to display diffs between revisions. 
";

$verbose = $v;
($where = $ENV{'PATH_INFO'}) =~ s|^/||;
$where =~ s|/$||;
($scriptname = $ENV{'SCRIPT_NAME'}) =~ s|^/?|/|;
$scriptname =~ s|/$||;
$scriptwhere = $scriptname . '/' . $where;
$scriptwhere =~ s|/$||;

if ($query = $ENV{'QUERY_STRING'}) {
    foreach (split(/&/, $query)) {
	s/%(..)/sprintf("%c", hex($1))/ge;	# unquote %-quoted
	if (/(\S+)=(.*)/) {
	    $input{$1} = $2;
	} else {
	    $input{$_}++;
	}
    }
    $query = "?" . $query;
}


$config = '/usr/local/etc/cvsweb';
do "$config" if -f $config;

if ($input{'cvsroot'}) {
    if ($CVSROOT{$input{'cvsroot'}}) {
	$cvstree = $input{'cvsroot'};
	$cvsroot = $CVSROOT{"$cvstree"};
    }
}
do "$config-$cvstree" if -f "$config-$cvstree";

$fullname = $cvsroot . '/' . $where;

if (!-d $cvsroot) {
	&fatal("500 Internal Error",'$CVSROOT not found!<P>The server on which the CVS tree lives is probably down.  Please try again in a few minutes.');
}

# Set up for FreeBSD repo options.
$ENV{'RCSLOCALID'} = 'FreeBSD=CVSHeader';
$ENV{'RCSINCEXC'}  = 'iFreeBSD';
$ENV{'CVSROOT'}    = $cvsroot;

{
    local(@foo, $i);
    local($scriptname) = $ENV{'SCRIPT_NAME'};
    foreach (sort keys %CVSROOT) {
	if (-d $CVSROOT{$_}) {
	    push(@foo, $_);
	}
    }
    if ($#foo > 1) {
	$intro .= "<p>\nThis script supports the following CVS trees:\n";
	for($i = 0; $i <= $#foo; $i++) {
	    $intro .= qq{<a href="$scriptname?cvsroot=$foo[$i]">} .
		($CVSROOTdescr{$foo[$i]} ? 
		 $CVSROOTdescr{$foo[$i]} : $foo[$i]) . qq{</a>} .
		     ($i == $#foo  ? ".\n" : ",\n");
	}
    }
}


{
    local(@mirrors) = sort keys %mirrors;;
    if ($#mirrors >= 0) {
	$intro .= "<p>\nThis script is mirrored in:\n";
	local($m);
	for($m = 0; $m <= $#mirrors; $m++) {
	    $intro .= qq(<a href="$mirrors{$mirrors[$m]}">$mirrors[$m]</a>);
	    $intro .= ',' if $m != $#mirrors;
	    $intro .= "\n";
	}
    }
}


if (-d $fullname) {
	opendir(DIR, $fullname) || &fatal("404 Not Found","$where: $!");
	@dir = readdir(DIR);
	closedir(DIR);
	if ($where eq '') {
	    print &html_header("FreeBSD CVS Repository");
	    print $intro;
	} else {
	    print &html_header("/$where");
	    print $shortinstr;
	}
	print "<p>";
	print "Current CVS tree: <b>",
		($CVSROOTdescr{"$cvstree"} ? $CVSROOTdescr{"$cvstree"} :
			$cvstree), "</b><br>\n";
	print "Current directory: <b>/$where</b>\n";
	print "<P><HR NOSHADE>\n";
	# Using <MENU> in this manner violates the HTML2.0 spec but
	# provides the results that I want in most browsers.  Another
	# case of layout spooging up HTML.
	print "<MENU>\n";
	lookingforattic:
	for ($i = 0; $i <= $#dir; $i++) {
		if ($dir[$i] eq "Attic") {
			last lookingforattic;
		}
	}
	$haveattic = 1 if ($i <= $#dir);
	if (!$input{"showattic"} && ($i <= $#dir) &&
				opendir(DIR, $fullname . "/Attic")) {
		splice(@dir, $i, 1,
			grep((s|^|Attic/|,!m|/\.|), readdir(DIR)));
		closedir(DIR);
	}
	# Sort without the Attic/ pathname.
	foreach (sort {($c=$a)=~s|.*/||;($d=$b)=~s|.*/||;($c cmp $d)} @dir) {
	    if ($_ eq '.') {
		next;
	    }
	    # ignore CVS lock and stale NFS files
	    next if /^#cvs\.|^,|^\.nfs/;

	    if (s|^Attic/||) {
		$attic = " (in the Attic)";
	    } else {
		$attic = "";
	    }
	    if ($_ eq '..') {
		next if ($where eq '');
		($updir = $scriptwhere) =~ s|[^/]+$||;
		print "<IMG SRC=\"/icons/back.gif\"> ",
		    &link("Previous Directory",$updir . $query), "<BR>";
#		print "<IMG SRC=???> ",
#		    &link("Directory-wide diffs", $scriptwhere . '/*'), "<BR>";
	    } elsif (-d $fullname . "/" . $_) {
		print "<IMG SRC=\"/icons/dir.gif\"> ",
		    &link($_ . "/", $scriptwhere . '/' . $_ . '/' . $query),
			    $attic, "<BR>";
	    } elsif (s/,v$//) {
# TODO: add date/time?  How about sorting?
		print "<IMG SRC=\"/icons/text.gif\"> ",
		    &link($_, $scriptwhere . '/' .
			    ($attic ? "Attic/" : "") . $_ . $query),
			    $attic, "<BR>";
	    }
	}
	print "</MENU>\n";
	if ($input{"only_on_branch"}) {
	    print "<HR><FORM METHOD=\"GET\" ACTION=\"${scriptwhere}\">\n";
	    print "Currently showing only branch $input{'only_on_branch'}.\n";
	    $input{"only_on_branch"}="";
	    foreach $k (keys %input) {
		print "<INPUT TYPE=hidden NAME=$k VALUE=$input{$k}>\n" if $input{$k};
	    }
	    print "<INPUT TYPE=SUBMIT VALUE=\"Show all branches\">\n";
	    print "</FORM>\n";
	}
	$formwhere = $scriptwhere;
	$formwhere =~ s|Attic/?$|| if ($input{"showattic"});
	if ($haveattic) {
		print "<HR><FORM METHOD=\"GET\" ACTION=\"${formwhere}\">\n";
		$input{"showattic"}=!$input{"showattic"};
		foreach $k (keys %input) {
		    print "<INPUT TYPE=hidden NAME=$k VALUE=$input{$k}>\n" if $input{$k};
		}
		print "<INPUT TYPE=SUBMIT VALUE=\"";
		print ($input{"showattic"} ? "Show" : "Hide");
		print " attic directories\">\n";
		print "</FORM>\n";
	}
	print &html_footer;
	print "</BODY></HTML>\n";
} elsif (-f $fullname . ',v') {
	if ($input{'rev'} =~ /^[\d\.]+$/) {
		&checkout($fullname, $input{'rev'});
		exit;
	}
	if ($input{'r1'} && $input{'r2'}) {
		&dodiff($fullname, $input{'r1'}, $input{'tr1'},
			$input{'r2'}, $input{'tr2'}, $input{'f'});
		exit;
	}
print("going to dolog($fullname)\n") if ($verbose);
	&dolog($fullname);
} elsif ($fullname =~ s/\.diff$// && -f $fullname . ",v" &&
				$input{'r1'} && $input{'r2'}) {
	# Allow diffs using the ".diff" extension
	# so that browsers that default to the URL
	# for a save filename don't save diff's as
	# e.g. foo.c
	&dodiff($fullname, $input{'r1'}, $input{'tr1'},
		$input{'r2'}, $input{'tr2'}, $input{'f'});
	exit;
} elsif (($newname = $fullname) =~ s|/([^/]+)$|/Attic/$1| &&
				 -f $newname . ",v") {
	# The file has been removed and is in the Attic.
	# Send a redirect pointing to the file in the Attic.
	($newplace = $scriptwhere) =~ s|/([^/]+)$|/Attic/$1|;
	&redirect($newplace);
	exit;
} elsif (0 && (@files = &safeglob($fullname . ",v"))) {
	print "Content-type: text/plain\n\n";
	print "You matched the following files:\n";
	print join("\n", @files);
	# Find the tags from each file
	# Display a form offering diffs between said tags
} else {
	# Assume it's a module name with a potential path following it.
	$xtra = $& if (($module = $where) =~ s|/.*||);
	# Is there an indexed version of modules?
	if (open(MODULES, "$cvsroot/CVSROOT/modules")) {
		while (<MODULES>) {
			if (/^(\S+)\s+(\S+)/o && $module eq $1
				&& -d "${cvsroot}/$2" && $module ne $2) {
				&redirect($scriptname . '/' . $2 . $xtra);
			}
		}
	}
	&fatal("404 Not Found","$where: no such file or directory");
}

sub htmlify {
	local($string, $pr) = @_;

	$string =~ s/&/&amp;/g;
	$string =~ s/</&lt;/g;
	$string =~ s/>/&gt;/g;

	if ($pr) {
		$string =~ s!\b((pr[:#]?\s*#?)|((bin|conf|docs|gnu|i386|kern|misc|ports)\/))(\d+)\b!<A HREF=http://www.freebsd.org/cgi/query-pr.cgi?pr=\5>$&</A>!ig;
	}

	$string;
}

sub link {
	local($name, $where) = @_;

	"<A HREF=\"$where\">$name</A>\n";
}

sub revcmp {
	local($rev1, $rev2) = @_;
	local(@r1) = split(/\./, $rev1);
	local(@r2) = split(/\./, $rev2);
	local($a,$b);

	while (($a = shift(@r1)) && ($b = shift(@r2))) {
	    if ($a != $b) {
		return $a <=> $b;
	    }
	}
	if (@r1) { return 1; }
	if (@r2) { return -1; }
	return 0;
}

sub fatal {
	local($errcode, $errmsg) = @_;
	print "Status: $errcode\n";
	print &html_header("Error");
#	print "Content-type: text/html\n";
#	print "\n";
#	print "<HTML><HEAD><TITLE>Error</TITLE></HEAD>\n";
#	print "<BODY>Error: $errmsg</BODY></HTML>\n";
	print "Error: $errmsg\n";
	print &html_footer;
	exit(1);
}

sub redirect {
	local($url) = @_;
	print "Status: 301 Moved\n";
	print "Location: $url\n";
	print &html_header("Moved");
#	print "Content-type: text/html\n";
#	print "\n";
#	print "<HTML><HEAD><TITLE>Moved</TITLE></HEAD>\n";
#	print "<BODY>This document is located <A HREF=$url>here</A>.</BODY></HTML>\n";
	print "This document is located <A HREF=$url>here</A>.\n";
	print &html_footer;
	exit(1);
}

sub safeglob {
	local($filename) = @_;
	local($dirname);
	local(@results);

	($dirname = $filename) =~ s|/[^/]+$||;
	$filename =~ s|.*/||;

	if (opendir(DIR, $dirname)) {
		$glob = $filename;
	#	transform filename from glob to regex.  Deal with:
	#	[, {, ?, * as glob chars
	#	make sure to escape all other regex chars
		$glob =~ s/([\.\(\)\|\+])/\\$1/g;
		$glob =~ s/\*/.*/g;
		$glob =~ s/\?/./g;
		$glob =~ s/{([^}]+)}/($t = $1) =~ s-,-|-g; "($t)"/eg;
		foreach (readdir(DIR)) {
			if (/^${glob}$/) {
				push(@results, $dirname . "/" .$_);
			}
		}
	}

	@results;
}

sub checkout {
	local($fullname, $rev) = @_;

	open(RCS, "co -p$rev '$fullname' 2>&1 |") ||
	    &fail("500 Internal Error", "Couldn't co: $!");
# /home/ncvs/src/sys/netinet/igmp.c,v  -->  standard output
# or
# /home/ncvs/src/sys/netinet/igmp.c,v  -->  stdout
# revision 1.1.1.2
# /*
	$_ = <RCS>;
	if (/^(\S+),v\s+-->\s+st(andar)?d ?out(put)?\s*$/o && $1 eq $fullname) {
	    # As expected
	} else {
	    &fatal("500 Internal Error",
		"Unexpected output from co: $_");
	}
	$_ = <RCS>;
	if ($rev eq ".") {
	    # latest rev requested, don't check
	} elsif (/^revision\s+$rev\s*$/) {
	    # As expected
	} else {
	    &fatal("500 Internal Error",
		"Unexpected output from co: $_");
	}
	$| = 1;
	print "Content-type: text/plain\n\n";
	print <RCS>;
	close(RCS);
}

sub dodiff {
	local($fullname, $r1, $tr1, $r2, $tr2, $f) = @_;

	if ($r1 =~ /([^:]+)(:(.+))?/) {
	    $rev1 = $1;
	    $sym1 = $3;
	}
	if ($rev1 eq 'text') {
	    $rev1 = $tr1;
	}
	if ($r2 =~ /([^:]+)(:(.+))?/) {
	    $rev2 = $1;
	    $sym2 = $3;
	}
	if ($rev2 eq 'text') {
	    $rev2 = $tr2;
	}
	if (!($rev1 =~ /^[\d\.]+$/) || !($rev2 =~ /^[\d\.]+$/)) {
	    &fatal("404 Not Found",
		    "Malformed query \"$ENV{'QUERY_STRING'}\"");
	}
#
# rev1 and rev2 are now both numeric revisions.
# Thus we do a DWIM here and swap them if rev1 is after rev2.
# XXX should we warn about the fact that we do this?
	if (&revcmp($rev1,$rev2) > 0) {
	    ($tmp1, $tmp2) = ($rev1, $sym1);
	    ($rev1, $sym1) = ($rev2, $sym2);
	    ($rev2, $sym2) = ($tmp1, $tmp2);
	}
#
#	XXX Putting '-p' here is a personal preference
	if ($f eq 'c') {
	    $difftype = '-p -c';
	    $diffname = "Context diff";
	} elsif ($f eq 's') {
	    $difftype = '--side-by-side --width=164';
	    $diffname = "Side by Side";
	} else {
	    $difftype = '-p -u';
	    $diffname = "Unidiff";
	}
# XXX should this just be text/plain
# or should it have an HTML header and then a <pre>
	print "Content-type: text/plain\n\n";
	open(RCSDIFF, "rcsdiff $difftype -r$rev1 -r$rev2 '$fullname' 2>&1 |") ||
	    &fail("500 Internal Error", "Couldn't rcsdiff: $!");
#
#===================================================================
#RCS file: /home/ncvs/src/sys/netinet/tcp_output.c,v
#retrieving revision 1.16
#retrieving revision 1.17
#diff -c -r1.16 -r1.17
#*** /home/ncvs/src/sys/netinet/tcp_output.c     1995/11/03 22:08:08     1.16
#--- /home/ncvs/src/sys/netinet/tcp_output.c     1995/12/05 17:46:35     1.17
#
# Ideas:
# - nuke the stderr output if it's what we expect it to be
# - Add "no differences found" if the diff command supplied no output.
#
#*** src/sys/netinet/tcp_output.c     1995/11/03 22:08:08     1.16
#--- src/sys/netinet/tcp_output.c     1995/12/05 17:46:35     1.17 RELENG_2_1_0
# (bogus example, but...)
#
	if ($difftype eq '-u') {
	    $f1 = '---';
	    $f2 = '\+\+\+';
	} else {
	    $f1 = '\*\*\*';
	    $f2 = '---';
	}
	while (<RCSDIFF>) {
	    if (m|^$f1 $cvsroot|o) {
		s|$cvsroot/||o;
		if ($sym1) {
		    chop;
		    $_ .= " " . $sym1 . "\n";
		}
	    } elsif (m|^$f2 $cvsroot|o) {
		s|$cvsroot/||o;
		if ($sym2) {
		    chop;
		    $_ .= " " . $sym2 . "\n";
		}
	    }
	    print $_;
	}
	close(RCSDIFF);
}

sub dolog {
	local($fullname) = @_;
	local($curbranch,$symnames);	#...

	print("Going to rlog '$fullname'\n") if ($verbose);
	open(RCS, "rlog '$fullname'|") || &fatal("500 Internal Error",
						"Failed to spawn rlog");
	while (<RCS>) {
	    print if ($verbose);
	    if (/^branch:\s+([\d\.]+)/) {
		$curbranch = $1;
	    }
	    if ($symnames) {
		if (/^\s+([^:]+):\s+([\d\.]+)/) {
		    $symrev{$1} = $2;
		    if ($revsym{$2}) {
			$revsym{$2} .= ", ";
		    }
		    $revsym{$2} .= $1;
		} else {
		    $symnames = 0;
		}
	    } elsif (/^symbolic names/) {
		$symnames = 1;
	    } elsif (/^-----/) {
		last;
	    }
	}

	if ($onlyonbranch = $input{'only_on_branch'}) {
	    ($onlyonbranch = $symrev{$onlyonbranch}) =~ s/\.0\././;
	    ($onlybranchpoint = $onlyonbranch) =~ s/\.\d+$//;
	}

# each log entry is of the form:
# ----------------------------
# revision 3.7.1.1
# date: 1995/11/29 22:15:52;  author: fenner;  state: Exp;  lines: +5 -3
# log info
# ----------------------------
	logentry:
	while (!/^=========/) {
	    $_ = <RCS>;
	    last logentry if (!defined($_));	# EOF
	    print "R:", $_ if ($verbose);
	    if (/^revision ([\d\.]+)/) {
		$rev = $1;
	    } elsif (/^========/ || /^----------------------------$/) {
		next logentry;
	    } else {
		# The rlog output is syntactically ambiguous.  We must
		# have guessed wrong about where the end of the last log
		# message was.
		# Since this is likely to happen when people put rlog output
		# in their commit messages, don't even bother keeping
		# these lines since we don't know what revision they go with
		# any more.
		next logentry;
#		&fatal("500 Internal Error","Error parsing RCS output: $_");
	    }
	    $_ = <RCS>;
	    print "D:", $_ if ($verbose);
	    if (m|^date:\s+(\d+)/(\d+)/(\d+)\s+(\d+):(\d+):(\d+);\s+author:\s+(\S+);\s+state:\s+(\S+);|) {
		$yr = $1;
		# damn 2-digit year routines
		if ($yr > 100) {
		    $yr -= 1900;
		}
		$date{$rev} = &timelocal($6,$5,$4,$3,$2 - 1,$yr);
		$author{$rev} = $7;
		$state{$rev} = $8;
	    } else {
		&fatal("500 Internal Error", "Error parsing RCS output: $_");
	    }
	    line:
	    while (<RCS>) {
		print "L:", $_ if ($verbose);
		next line if (/^branches:\s/);
		last line if (/^----------------------------$/ || /^=========/);
		$log{$rev} .= $_;
	    }
	    print "E:", $_ if ($verbose);
	}
	close(RCS);
	print "Done reading RCS file\n" if ($verbose);
#
# Sort the revisions into commit-date order.
	@revorder = sort {$date{$b} <=> $date{$a}} keys %date;
	print "Done sorting revisions\n" if ($verbose);
#
# HEAD is an artificial tag which is simply the highest tag number on the main
# branch, unless there is a branch tag in the RCS file in which case it's the
# highest revision on that branch.  Find it by looking through @revorder; it
# is the first commit listed on the appropriate branch.
	$headrev = $curbranch || "1";
	revision:
	for ($i = 0; $i <= $#revorder; $i++) {
	    if ($revorder[$i] =~ /^(\S*)\.\d+$/ && $headrev eq $1) {
		if ($revsym{$revorder[$i]}) {
		    $revsym{$revorder[$i]} .= ", ";
		}
		$revsym{$revorder[$i]} .= "HEAD";
		$symrev{"HEAD"} = $revorder[$i];
		last revision;
	    }
	}
	print "Done finding HEAD\n" if ($verbose);
#
# Now that we know all of the revision numbers, we can associate
# absolute revision numbers with all of the symbolic names, and
# pass them to the form so that the same association doesn't have
# to be built then.
#
# should make this a case-insensitive sort
	foreach (sort keys %symrev) {
	    $rev = $symrev{$_};
	    if ($rev =~ /^(\d+(\.\d+)+)\.0\.(\d+)$/) {
		push(@branchnames, $_);
		#
		# A revision number of A.B.0.D really translates into
		# "the highest current revision on branch A.B.D".
		#
		# If there is no branch A.B.D, then it translates into
		# the head A.B .
		#
		$head = $1;
		$branch = $3;
		$regex = $head . "." . $branch;
		$regex =~ s/\./\./g;
		#             <
		#           \____/
		$rev = $head;

		revision:
		foreach $r (@revorder) {
		    if ($r =~ /^${regex}/) {
			$rev = $head . "." . $branch;
			last revision;
		    }
		}
		$revsym{$rev} .= ", " if ($revsym{$rev});
		$revsym{$rev} .= $_;
		if ($rev ne $head) {
		    $branchpoint{$head} .= ", " if ($branchpoint{$head});
		    $branchpoint{$head} .= $_;
		}
	    }
	    $sel .= "<OPTION VALUE=\"${rev}:${_}\">$_\n";
	}
	print "Done associating revisions with branches\n" if ($verbose);
        print &html_header("CVS log for $where");
	($upwhere = $where) =~ s|(Attic/)?[^/]+$||;
	print "Up to ", &link($upwhere,$scriptname . "/" . $upwhere . $query);
	print "<BR>\n";
	print "<A HREF=\"#diff\">Request diff between arbitrary revisions</A>\n";
	print "<HR NOSHADE>\n";
	if ($curbranch) {
	    print "Default branch is ";
	    print ($revsym{$curbranch} || $curbranch);
	} else {
	    print "No default branch";
	}
	print "<BR><HR NOSHADE>\n";
# The other possible U.I. I can see is to have each revision be hot
# and have the first one you click do ?r1=foo
# and since there's no r2 it keeps going & the next one you click
# adds ?r2=foo and performs the query.
# I suppose there's no reason we can't try both and see which one
# people prefer...

	for ($i = 0; $i <= $#revorder; $i++) {
	    $_ = $revorder[$i];
	    ($br = $_) =~ s/\.\d+$//;
	    next if ($onlyonbranch && $br ne $onlyonbranch &&
					    $_ ne $onlybranchpoint);
	    print "<a NAME=\"rev$_\"></a>";
	    foreach $sym (split(", ", $revsym{$_})) {
		print "<a NAME=\"$sym\"></a>";
	    }
	    if ($revsym{$br} && !$nameprinted{$br}) {
		foreach $sym (split(", ", $revsym{$br})) {
		    print "<a NAME=\"$sym\"></a>";
		}
		$nameprinted{$br}++;
	    }
	    print "\n";
	    print "<A HREF=\"$scriptwhere?rev=$_" . 
		&cvsroot . "\"><b>$_</b></A>";
	    if (/^1\.1\.1\.\d+$/) {
		print " <i>(vendor branch)</i>";
	    }
	    print " <i>" . &ctime($date{$_}) . " UTC</i> by ";
	    print "<i>" . $author{$_} . "</i>\n";
	    if ($revsym{$_}) {
		print "<BR>CVS Tags: <b>$revsym{$_}</b>";
	    }
	    if ($revsym{$br})  {
		if ($revsym{$_}) {
		    print "; ";
		} else {
		    print "<BR>";
		}
		print "Branch: <b>$revsym{$br}</b>\n";
	    }
	    if ($branchpoint{$_}) {
		if ($revsym{$br} || $revsym{$_}) {
		    print "; ";
		} else {
		    print "<BR>";
		}
		print "Branch point for: <b>$branchpoint{$_}</b>\n";
	    }
	    # Find the previous revision on this branch.
	    @prevrev = split(/\./, $_);
	    if (--$prevrev[$#prevrev] == 0) {
		# If it was X.Y.Z.1, just make it X.Y
		if ($#prevrev > 1) {
		    pop(@prevrev);
		    pop(@prevrev);
		} else {
		    # It was rev 1.1 (XXX does CVS use revisions
		    # greater than 1.x?)
		    if ($prevrev[0] != 1) {
			print "<i>* I can't figure out the previous revision! *</i>\n";
		    }
		}
	    }
	    if ($prevrev[$#prevrev] != 0) {
		$prev = join(".", @prevrev);
		print "<BR><A HREF=\"${scriptwhere}.diff?r1=$prev";
		print "&r2=$_" . &cvsroot . "\">Diffs to $prev</A>\n";
		#
		# Plus, if it's on a branch, and it's not a vendor branch,
		# offer to diff with the immediately-preceding commit if it
		# is not the previous revision as calculated above
		# and if it is on the HEAD (or at least on a higher branch)
		# (e.g. change gets committed and then brought
		# over to -stable)
		if (!/^1\.1\.1\.\d+$/ && ($i != $#revorder) &&
					($prev ne $revorder[$i+1])) {
		    @tmp1 = split(/\./, $revorder[$i+1]);
		    @tmp2 = split(/\./, $_);
		    if ($#tmp1 < $#tmp2) {
			print "; <A HREF=\"${scriptwhere}.diff?r1=$revorder[$i+1]";
			print "&r2=$_" . &cvsroot .
                            "\">Diffs to $revorder[$i+1]</A>\n";
		    }
		}
	    }
	    if ($state{$_} eq "dead") {
		print "<BR><B><I>FILE REMOVED</I></B>\n";
	    }
	    print "<PRE>\n";
	    print &htmlify($log{$_}, 1);
	    print "</PRE><HR NOSHADE>\n";
	}
	print "<A NAME=diff>\n";
	print "This form allows you to request diff's between any two\n";
	print "revisions of a file.  You may select a symbolic revision\n";
	print "name using the selection box or you may type in a numeric\n";
	print "name using the type-in text box.\n";
	print "</A><P>\n";
	print "<FORM METHOD=\"GET\" ACTION=\"${scriptwhere}.diff\">\n";
        print "<INPUT TYPE=HIDDEN NAME=\"cvsroot\" VALUE=\"$cvstree\">\n"
             if &cvsroot;
	print "Diffs between \n";
	print "<SELECT NAME=\"r1\">\n";
	print "<OPTION VALUE=\"text\" SELECTED>Use Text Field\n";
	print $sel;
	print "</SELECT>\n";
	print "<INPUT TYPE=\"TEXT\" NAME=\"tr1\" VALUE=\"$revorder[$#revorder]\">\n";
	print " and \n";
	print "<SELECT NAME=\"r2\">\n";
	print "<OPTION VALUE=\"text\" SELECTED>Use Text Field\n";
	print $sel;
	print "</SELECT>\n";
	print "<INPUT TYPE=\"TEXT\" NAME=\"tr2\" VALUE=\"$revorder[0]\">\n";
	print "<BR><INPUT TYPE=RADIO NAME=\"f\" VALUE=u CHECKED>Unidiff<br>\n";
	print "<INPUT TYPE=RADIO NAME=\"f\" VALUE=c>Context diff<br>\n";
	print "<INPUT TYPE=RADIO NAME=\"f\" VALUE=s>Side-by-Side<br>\n";
	print "<INPUT TYPE=SUBMIT VALUE=\"Get Diffs\">\n";
	print "</FORM>\n";
	print "<HR noshade>\n";
	print "<A name=branch>\n";
	print "You may select to see revision information from only\n";
	print "a single branch.\n";
	print "</A><P>\n";
	print "<FORM METHOD=\"GET\" ACTION=\"$scriptwhere\">\n";
        print qq{<input type=hidden name=cvsroot value=$cvstree>\n}
             if &cvsroot;
	print "Branch: \n";
	print "<SELECT NAME=\"only_on_branch\">\n";
	print "<OPTION VALUE=\"\"";
	print " SELECTED" if ($input{"only_on_branch"} eq "");
	print ">Show all branches\n";
	foreach (sort @branchnames) {
		print "<OPTION";
		print " SELECTED" if ($input{"only_on_branch"} eq $_);
		print ">${_}\n";
	}
	print "</SELECT>\n";
	print "<INPUT TYPE=SUBMIT VALUE=\"View Branch\">\n";
	print "</FORM>\n";
        print &html_footer;
	print "</BODY></HTML>\n";
}

sub cvsroot {
    return '' if $cvstree eq $cvstreedefault;
    return "&cvsroot=" . $cvstree;
}
