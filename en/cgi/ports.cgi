#!/usr/bin/perl
#
# Copyright (c) 1996-1998 Wolfram Schneider <wosch@FreeBSD.ORG>, Berlin.
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
# $FreeBSD$
#
# ports.cgi - search engine for FreeBSD ports
#             	o search for a port by name or description
#               o search for new or updated ports
#
#
# If you want use this script on your own host this line must
# work for you: $ cvs rdiff -D'last week' ports/INDEX


sub init_variables {
    $cvsroot = '/home/ncvs';	# $CVSROOT
    $localPrefix = '/usr/ports';	# ports prefix
    $ports_database = 'ports/INDEX';
    # unset $ENV{'CVSROOT'};

    @cvscmd = ('cvs', '-Q', '-R', '-d', $cvsroot);

    # URL of ports tree for browsing
    $remotePrefixFtp =
	'ftp://ftp.freebsd.org/pub/FreeBSD/FreeBSD-current/ports';

    # URL of ports tree for download 
    $remotePrefixFtpDownload =
    #    'ftp://ftp.cs.tu-berlin.de/pub/FreeBSD/FreeBSD-current/ports';
	'ftp://ftp.freebsd.org/pub/FreeBSD/FreeBSD-current/ports';

    # where to get -current packages
    local($p) = 'ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386';

    $remotePrefixFtpPackagesDefault = '3.2-stable';
    %remotePrefixFtpPackages = 
	(
	 '4.0-current', "$p/packages-current/All",
	 '3.2-stable', "$p/packages-stable/All",
	 '3.2-release', "$p/3.2-RELEASE/All",
	);

    %relDate = 
	(
	 '4.0-current', 'today',
	 '3.2-stable', 'today',
	 '3.2-release', "1999-05-14 11:54:54 UTC",
	  );

    $remotePrefixHtml =
	'../ports';

    # CVS Web interface
    $remotePrefixCvs =
	'http://www.freebsd.org/cgi/cvsweb.cgi/ports';

    # Ports documentation
    $portsDesc = '../ports/';

    # location of the tiny BSD daemon
    $daemonGif = '<IMG SRC="/gifs/littlelogo.gif">';

    # visible E-Mail address, plain text
    $mailto = 'www@FreeBSD.org';

    # Mailinglist for FreeBSD Ports
    $mailtoList = 'ports@FreeBSD.org';

    # use mailto:email?subject
    $mailtoAdvanced = 'yes';

    # the URL if you click at the E-Mail address (see below)
    $mailtoURL = 'http://www.freebsd.org/ports/';
    $mailtoURL = "mailto:$mailto" if !$mailtoURL;

    # security
    $ENV{'PATH'} = '/bin:/usr/bin';

    # ports download sources script
    $pds = 'pds.cgi';

    # make plain text URLs clickable cgi script
    $url = 'url.cgi';

    local($packageDB) = '../ports/packages.exists';
    &packages_exist($packageDB, *packages) if -f $packageDB;

}

sub packages_exist {
    local($file, *p) = @_;

    open(P, $file) || do {
        warn "open $file: $!\n";
        warn "Cannot create packages links\n";
        return 1;
    };

    while(<P>) {
        chop;
        $p{$_} = 1;
    }
    close P;
    return 0;
}


# return the date of the last ports database update
sub last_update {
    local($file) = "$cvsroot/$ports_database,v";
    local($date) = 'unknown';

    open(DB, $file) || do {
	&warn("$file: $!\n"); &exit;
    };
    local($head);
    while(<DB>) {
	$head = $1 if (/^head\s+([0-9.]+);?\s*$/);
	if (/^date/ && /^date\s+([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+);\s+/) {
	    $date = ($1 + 1900) . qq{-$2-$3 $4:$5:$6 UTC};
	    last;
	}
    }
    close DB;
    return $date . "; based on  revision " . $head;
}

sub last_update_message {
    return "<p>Last database update: " . &last_update . "<br>\n";
}

sub dec {
    local($_) = @_;

    s/\+/ /g;                       # '+'   -> space
    s/%(..)/pack("c",hex($1))/ge;   # '%ab' -> char ab

    return($_);
}

sub header {
    print "Content-type: text/html\n";
    print "\n";
}


# $indent is a bit of optional data processing I put in for
# formatting the data nicely when you are emailing it.
# This is derived from code by Denis Howe <dbh@doc.ic.ac.uk>
# and Thomas A Fine <fine@cis.ohio-state.edu>
sub decode_form {
    local($form, *data, $indent, $key, $_) = @_;
    foreach $_ (split(/&/, $form)) {
	($key, $_) = split(/=/, $_, 2);
	$_   =~ s/\+/ /g;				# + -> space
	$key =~ s/\+/ /g;				# + -> space
	$_   =~ s/%([\da-f]{1,2})/pack(C,hex($1))/eig;	# undo % escapes
	$key =~ s/%([\da-f]{1,2})/pack(C,hex($1))/eig;	# undo % escapes
	$_   =~ s/[\r\n]+/\n\t/g if defined($indent);	# indent data after \n
	$data{$key} = $_;
    }
}


# encode unknown data for use in a URL <A HREF="...">
sub encode_url {
    local($_) = @_;
    s/([\000-\032\;\/\?\:\@\&\=\%\'\"\`\<\>\177-\377 ])/sprintf('%%%02x',ord($1))/eg;
    # s/%20/+/g;
    $_;
}

sub warn { print "$_[0]" }
sub env { defined($ENV{$_[0]}) ? $ENV{$_[0]} : undef; }
sub exit { exit 0 };

sub readindex {
    local($date, *var, *msec) = @_;
    local(@co) = ('co', '-p');

    if ($date =~ /^rev([1-9]+\.[0-9]+)$/) {
	# diff by revision
	push(@co, ('-r', $1));
    } else {
	# diff by date
	push(@co, ('-D', $date));
    }
    
    push(@co, $ports_database);


    local(@tmp, @s);

    open(C, "-|") || exec (@cvscmd, @co);

    while(<C>) {
	chop;
	@tmp = split(/\|/);
	$var{"$tmp[4]"} = $_;
	@s = split(/\s+/, $tmp[6]);
	foreach (@s) {
	    $msec{"$tmp[4],$_"} = 1;
	}
    }
    close C;
}

# extract sub collections
sub readcoll {
    local(@co) = ('co', '-p', 'ports/INDEX');

    open(C, "-|") || exec (@cvscmd, @co);

    local(@a, @b, %key);
    while(<C>) {
	chop;

	@a = split('\|');
	@b = split(/\s+/, $a[6]);

	foreach (@b) {
	    if (!defined($key{$_})) {
		$key{$_} = 1;
	    }
	}
    }
    close C;

    @a = ();
    foreach (sort keys %key) {
	push(@a, $_);
    }

    return @a;
}

# basic function for HTML output
sub out {
    local($line, $old) = @_;
    local($version, $path, $local, $comment, $descfile, $email, 
	  $sections, $bdepends, $rdepends, @rest) =  split(/\|/, $line);

    if ($path =~ m%^$localPrefix/([^/]+)%o) {
	if (!$out_sec || $1 ne $out_sec) {
	    print "</DL>\n" if $counter > 0;
	    print qq{\n<H3>} .
		qq{<a href="$remotePrefixHtml/$1.html">Category $1</a>} .
                "</H3>\n<DL>\n";
	    $out_sec = $1;
	}
    }

    $counter++;
    $pathDownload = $path;
    $pathB= $path;
    $pathB =~ s/^$localPrefix/ports/o;

    $path =~ s/^$localPrefix/$remotePrefixFtp/o;
    $pathDownload =~ s/^$localPrefix/$remotePrefixFtpDownload/o;
    $descfile =~ s/^$localPrefix/$remotePrefixFtp/o;

    print qq{<DT><B><A NAME="$version">$version</A></B>\n};
    print qq{<DD>$comment<BR>\n};

    if ($old) {
	local($l) = $descfile;
	$l =~ s%^$remotePrefixFtp%$remotePrefixCvs%o;
	$l =~ s%/([^/]+)$%/Attic/$1%;

	print  qq{<I>Was Maintained by:</I> <A HREF="mailto:$email} .
           ($mailtoAdvanced ? 
              qq{?cc=$mailtoList&subject=FreeBSD%20Port:%20} .
              &encode_url($version) : '') .  qq{">$email</A><BR>} .
	   qq{<A HREF="$l">Removed why</A></DD>};

    } else {
	local($l) = $path;
	$l =~ s%^$remotePrefixFtp%$remotePrefixCvs%o;
	#$l .= '/Makefile';

	print  qq{<I>Maintained by:</I> <A HREF="mailto:$email} .
           ($mailtoAdvanced ? 
              qq{?cc=$mailtoList&subject=FreeBSD%20Port:%20} .
              &encode_url($version) : '') . qq{">$email</A><BR>};

	local(@s) = split(/\s+/, $sections);
	if ($#s > 0) {
	    print qq{<I>Also listed in:</I> };
	    foreach (@s) {
		print qq{<A HREF="$remotePrefixHtml/$_.html">$_</A> }
		    if $_ ne $out_sec;
	    }
	    print "<BR>\n";
	}
	
	if ($bdepends || $rdepends) {
	    local($flag) = 0; 
	    local($last) = '';
	    print qq{<I>Requires:</I> };
	    foreach (sort split(/\s+/, "$bdepends $rdepends")) {
		# delete double entries
		next if $_ eq $last;
		$last = $_;

		print ", " if $flag; 
		$flag++;
		print qq{<A HREF="$script_name?query=^$_&stype=name">$_</A>};
	    }
	    print "<BR>\n";
	}

	print qq[<A HREF="$url?$descfile">Description</A> <B>:</B>
<A HREF="$pds?$pathB">Sources</A> <B>:</B>\n];

	if (($release eq $remotePrefixFtpPackagesDefault &&
	    $packages{"$version.tgz"}) ||
	    $release ne $remotePrefixFtpPackagesDefault
	    ) {
	    print qq[<A HREF="$remotePrefixFtpPackages{$release}/$version.tgz">Package</A> <B>:</B>\n];
	}
print qq[<A HREF="$l">Changes</A> <B>:</B>
<A HREF="$path/">Browse</A> <B>:</B>
<A HREF="$pathDownload.tar">Download</A>
<p>
];

};


};

# new/updated/removed ports output
sub out_ports {

    if ($type eq "new") {
	foreach $key (sort keys %today) {
	    if (!$past{$key}) {
		if ($section eq "all" || $msec{"$key,$section"}) {
		    &out($today{$key}, 0);
		}
	    }
	}
    } elsif ($type eq "removed") {
	foreach $key (sort keys %past) {
	    if (!$today{$key}) {
		if ($section eq "all" || $msec{"$key,$section"}) {
		    &out($past{$key}, 1);
		}
	    }
	}
    } else { # changed
	foreach $key (sort keys %today) {
	    if ($past{$key} && $past{$key} ne $today{$key}) {
		@a = split(/\|/, $today{$key});
		@b = split(/\|/, $past{$key});
		next if $a[0] eq $b[0];
		if ($section eq "all" || $msec{"$key,$section"}) {
		    &out($today{$key}, 0);
		}
	    }
	}
    }
}

# search and output
sub search_ports {
    local(@a) = ();
    local($key, $name, $text);

    foreach $key (sort keys %today) {
	next if $today{$key} !~ /$query/oi;

	@a = split(/\|/, $today{$key});
	$name = $a[0]; #$name =~ s/(\W)/\\$1/g;
	$text = $a[3]; #$text =~ s/(\W)/\\$1/g;

	#warn "$stype:$query: $name $text\n";
	if ($stype eq "name" && $name =~ /$query/o) {
	    &out($today{$key}, 0);
	} elsif ($stype eq "text" && $text =~ /$query/oi) {
	    &out($today{$key}, 0);
	} elsif ($stype eq "all" &&
		 ($text =~ /$query/oi || $name =~ /$query/io)) {
	    &out($today{$key}, 0);
	} elsif ($stype eq 'maintainer' && $a[5] =~ /$query/io) {
	    &out($today{$key}, 0);
	} elsif ($stype eq 'requires' && 
		 ($a[7] =~ /$query/io || $a[8] =~ /$query/io)) {
	    &out($today{$key}, 0);
	}

    }
}


sub forms {
    print qq{<HTML>
<HEAD>
<TITLE>FreeBSD Ports Changes</TITLE>
</HEAD>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
<H1><a href="../">FreeBSD Ports Changes</A> $daemonGif</H1>

<P>
FreeBSD Ports [short description <a href="$portsDesc">followed</a> ...]
<a href="$script_name/faq.html">FAQ</a>
<p>
};

    print qq{
"Package Name" search for the name of port or distribution.
"Description" search case-insensitive in a short comment about the port.
"All" search case-insensitive for the package name and in the 
description about the port.
<p>

<FORM METHOD="GET" ACTION="$script_name">
Search for:
<INPUT NAME="query" VALUE="$query">
<SELECT NAME="stype">
};
    
    local(%d);
    %d = ('name', 'Package Name',
	  'all', 'All',
	  'maintainer', 'Maintainer',
	  'text', 'Description',
	  'requires', 'Requires',
	  );

    foreach ('all', 'name', 'text', 'maintainer', 'requires') {
	print "<OPTION" . (($_ eq $stype) ? ' SELECTED ' : ' ') .
	    qq{VALUE="$_">} . ($d{$_} ? $d{$_} : $_) . qq{</OPTION>\n};
    }


    print qq{</SELECT><SELECT NAME="release">\n};
    foreach (sort keys %remotePrefixFtpPackages) {
	print qq{<OPTION} . 
	    (($_ eq $release) ? ' SELECTED ' : ' ') . 
		qq{VALUE=$_>$_</OPTION>\n};
    }
    print qq{</SELECT>
<INPUT TYPE="submit" VALUE="Submit">
</FORM>
};

    print qq{<hr noshade>
<p>
"New" print ports which are new in the ports collection
or moved from an other ports section. "Changed" print updated ports.
"Removed" print ports which are deleted from ports collections
or moved to an other ports section.

<FORM METHOD="GET" ACTION="$script_name">
<SELECT NAME="type">
};

    foreach ('new', 'changed', 'removed') {
	print "<OPTION" . (($_ eq $type) ? ' SELECTED ' : ' ') .
	    qq{VALUE="$_">$_</OPTION>\n};
    }

    print qq{</SELECT>\n\n<SELECT NAME="time">\n};
    foreach ("1 week ago", "2 week ago", "3 week ago", "4 week ago",
	     "6 week ago", "8 week ago", "3 month ago", "4 month ago",
	     "6 month ago", "9 month ago", "12 month ago", "24 month ago") 
    {
	print "<OPTION" .
	    (($_ eq $time) ? ' SELECTED ' : ' ') .
		qq{VALUE="$_">$_</OPTION>\n};
    }

	print q{</SELECT>

<SELECT NAME="sektion">
<OPTION VALUE="all">All Sections</OPTION>
};

    foreach (@sec) {
	print "<OPTION" .
	    (($_ eq $section) ? ' SELECTED ' : ' ') .
		qq{VALUE="$_">$_</OPTION>\n};
    }

    print q{</SELECT>
<INPUT TYPE="submit" VALUE="Submit">
</FORM>
<HR noshade>
};

}

sub footer {

    print qq{
<img ALIGN="RIGHT" src="/gifs/powerlogo.gif">
&copy; 1996-1998 by Wolfram Schneider. All rights reserved.<br>
};
    #print q{$Date: 1997/03/20 21:43:48} . "<br>\n";
    print qq{Please direct questions about this service to
<I><A HREF="$mailtoURL">$mailto</A></I><br>\n};
    print qq{General questions about FreeBSD ports should be sent to } .
	qq{<a href="mailto:$mailtoList">} . 
	    qq{<i>$mailtoList</i></a><br>\n};
    print &last_update_message;
    print "<hr noshade>\n<P>\n";
}

sub footer2 {
    print "\n</BODY>\n</HTML>\n";
}


sub check_input {
    if ($query) {
	$stype = "all" if !$stype;
	if (!($stype eq "name" ||
	      $stype eq "text" ||
	      $stype eq "maintainer" ||
	      $stype eq "requires" ||
	      $stype eq "all")) {
	    &warn("unknown search type ``$type'', use `all', `text', `name', 'requires', or `maintainer'\n");
	    &exit(0);
	} else {
	    return;
	}
    }

    if (!($type eq "new" || $type eq "changed" || $type eq "removed")) {
	&warn("unknown type `$type', use `new', `changed', or `removed'\n");
	&exit(0);
    }

    if ($time !~ /^[1-9][0-9]*\s+(month|week)\s+ago$/ &&
	# support diff by revision too
	$time !~ /^rev[1-9]+\.[0-9]+$/
	) 
    {
	&warn("unkwnon date: `$time'\n");
	&exit(0);
    }
}

sub faq {
    print qq{<HEAD>\n<TITLE>FAQ</TITLE>\n</HEAD>
<BODY <BODY BGCOLOR="#FFFFFF" TEXT="#000000">
<H1>FreeBSD Ports Changed FAQ</h1>

<h2>Keywords</h2>
<dl>
<dt><b>Description</b><dd>A more detailed description.
<dt><b>Browse</b><dd>Traverse the ports directory.
<dt><b>Download</b><dd>Download the ports directory.
<dt><b>Package</b><dd>Download the pre-compiled software package.
<dt><b>Changes</b><dd>Read the latest changes.
<dt><b>Sources</b><dd>Links to all source files.
</dl>

<h2>Misc</h2>
All links point to the FreeBSD-stable
version and <b>not</b> to the latest releases.<p>

The script ports.cgi use the file 
<a href="$remotePrefixCvs/INDEX">
FreeBSD-CVS/ports/INDEX,v</a>
as database for all operation. INDEX,v will be updated by hand
by the portsmeister.<p>

You may also search the 
<a href="http://www.freebsd.org/cgi/man.cgi?manpath=FreeBSD+Ports">ports manual pages</a>.<p>

Get the <a href ="source">Source</a> of this script.<p>

<a href="$script_name">Back to the search engine</a><p>
<HR noshade>
};
}

#
# Main
#

&init_variables;
$query_string = &env('QUERY_STRING');
$path_info = &env('PATH_INFO');
&decode_form($query_string, *form);

$type = $form{'type'};
$time = $form{'time'};
$section = $form{'sektion'};
$query = $form{'query'};
$stype = $form{'stype'};
$release = $form{'release'};
$release = $remotePrefixFtpPackagesDefault
    if !$release  || !defined($remotePrefixFtpPackages{$release});
$script_name = &env('SCRIPT_NAME');

if ($path_info eq "/source") {
    print "Content-type: text/plain\n\n";
    open(R, $0) || do { print "ick!\n"; &exit; };
    while(<R>) { print }
    close R;
    &exit;
}

&header;
if ($path_info eq "/faq.html") {
    &faq;
    &footer; &footer2; &exit(0);
} 

# allow `/ports.cgi?netscape' where 'netscape' is the query port to search
# this make links to this script shorter
if (!$query && !$type && $query_string =~ /^([^=&]+)$/) {
    $query = $1;
}

# automatically read collections, need only 0.2 sec on a pentium
@sec = &readcoll;
&forms;

$query =~ s/^\s+//;
$query =~ s/\s+$//;

if ($query_string eq "" || (!$query && !$type)) {
    &footer; &footer2; &exit(0);
}

#warn "type: $type time: $time section: $section stype: $stype query: $query";
&check_input;
$counter = 0;

# search
if ($query) {
    &readindex($relDate{$release}, *today, *msec);
    $query =~ s/([^\w\^])/\\$1/g;
    &search_ports;
}

# ports changes
else {
    &readindex('today', *today, *msec);
    &readindex($time, *past, *msec);
    &out_ports;
}

if (!$counter) {
    print "Sorry, nothing found.\n";
    print qq{You may look for other } . 
	qq{<a href="/search/search.html">FreeBSD Search Services</a>.\n};
} else {
    print "</dl>\n";
}

print "<hr noshade>\n";
&footer;
&footer2;
