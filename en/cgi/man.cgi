#!/usr/bin/perl -T
#
# Copyright (c) 1996-1999 Wolfram Schneider <wosch@FreeBSD.org>. Berlin.
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
# man.cgi - HTML hypertext FreeBSD man page interface
#
# based on bsdi-man.pl,v 2.17 1995/10/05 16:48:58 sanders Exp
# bsdi-man -- HTML hypertext BSDI man page interface
# based on bsdi-man.pl,v 2.10 1993/10/02 06:13:23 sanders Exp
# by polk@BSDI.COM 1/10/95
#	BSDI	Id: bsdi-man,v 1.2 1995/01/11 02:30:01 polk Exp 
# Dual CGI/Plexus mode and new interface by sanders@bsdi.com 9/22/1995
#
# $Id: man.cgi,v 1.30 2001-03-11 10:32:58 wosch Exp $

#use Data::Dumper;
#use Carp;


$www{'title'} = 'FreeBSD Hypertext Man Pages';
$www{'home'} = 'http://www.FreeBSD.org';
$www{'head'} = qq[<A HREF="$www{'home'}">$www{'title'}</a> ] .
               qq[<IMG SRC="/gifs/littlelogo.gif">] .
                "";

$command{'man'} =     'man'; # 8Bit clean man
$command{'man'} =     '/home/wosch/bin/cgi-man'; # 8Bit clean man


# Config Options
# map sections to their man command argument(s)
%sections = (
    '', '',
    'All', '',
    '0', '',

    '1', '-S1',
    '1c', '-S1',
    '1C', '-S1',
    '1g', '-S1',
    '1m', '-S1',
    '2', '-S2',
    '2j', '-S2',
    '3', '-S3',
    '3S', '-S3',
    '3f', '-S3',
    '3j', '-S3',
    '3m', '-S3',
    '3n', '-S3',
    '3r', '-S3',
    '3s', '-S3',
    '3x', '-S3',
    '4', '-S4',
    '5', '-S5',
    '6', '-S6',
    '7', '-S7',
    '8', '-S8',
    '8c', '-S8',
    '9', '-S9',
    'l', '-Sl',
    'n', '-Sn',
);

$sectionpath = {
    'SunOS 5.8' => {
	'path' => '1:1m:1s:2:3:3c:3malloc:3dl:3nsl:3socket:3ldap:3krb:3nisdb:3rac:3resolv:3rpc:3slp:3xfn:3proc:3rt:3thr:3elf:3kvm:3kstat:3m:3mp:3pam:3sched:3aio:3bsm:3cpc:3sec:3secdb:3cfgadm:3crypt:3devid:3devinfo:3door:3lib:3libucb:3head:7:7d:7fs:7i:7m:7p:9:9e:9f:9s:4:5:4b:3gen:3dmi:3snmp:3tnf:3volmgt:3mail:3layout:3ext:1b:1c:1f:3ucb:3xnet:3curses:3plot:3xcurses:6:l:n',
    },
    'SunOS 5.7' => {
	'path' => '1:1m:1c:1f:1s:1b:2:3:3c:3s:3x:3xc:3n:3r:3t:3xn:3m:3k:3g:3e:3b:9f:9s:9e:9:4:5:7:7d:7i:7m:7p:7fs:4b:6:l:n',
    },
    'SunOS 5.6' => {
	'path' => '1:1m:1c:1f:1s:1b:2:3:3c:3s:3x:3xc:3xn:3r:3t:3n:3m:3k:3g:3e:3b:9f:9s:9e:9:4:5:7:7d:7i:7m:7p:7fs:4b:6:l:n',
    },
    'SunOS 5.5.1' => {
	'path' => '1:1m:1c:1f:1s:1b:2:3:3c:3s:3x:3xc:3xn:3r:3t:3n:3m:3k:3g:3e:3b:9f:9s:9e:9:4:5:7:7d:7i:7m:7p:7fs:4b:6:l:n',
    },
};

foreach my $os (keys %$sectionpath) {
    foreach my $section (split(/:/, $sectionpath->{$os}{'path'})) {
	$section =~ /(.)(.*)/;
	$sectionpath->{$os}{$1} .= 
	    ($sectionpath->{$os}{$1} ? ':' : '') . $section;
    }
}


%sectionName = 
    (
     '0', 'All Sections',
     '1', '1 - General Commands',
     '2', '2 - System Calls',
     '3', '3 - Subroutines',
     '4', '4 - Special Files',
     '5', '5 - File Formats',
     '6', '6 - Games',
     '7', '7 - Macros and Conventions',
     '8', '8 - Maintenance Commands',
     '9', '9 - Kernel Interface',
     'n', 'n - New Commands',
     );

$manLocalDir = '/usr/local/www/bsddoc/man';
$manPathDefault = 'FreeBSD 4.2-RELEASE';

%manPath = 
    (
     'FreeBSD 5.0-current',   "$manLocalDir/FreeBSD-5.0-current",
     'FreeBSD 4.2-RELEASE',   "$manLocalDir/FreeBSD-4.2-RELEASE",
     'FreeBSD 4.1.1-RELEASE', "$manLocalDir/FreeBSD-4.1.1-RELEASE",
     'FreeBSD 4.1-RELEASE',   "$manLocalDir/FreeBSD-4.1-RELEASE",
     'FreeBSD 4.0-RELEASE',   "$manLocalDir/FreeBSD-4.0-RELEASE",
     'FreeBSD 3.5.1-RELEASE',   "$manLocalDir/FreeBSD-3.5.1-RELEASE",
     'FreeBSD 3.4-RELEASE',   "$manLocalDir/FreeBSD-3.4-RELEASE",
     'FreeBSD 3.3-RELEASE',   "$manLocalDir/FreeBSD-3.3-RELEASE",
     'FreeBSD 3.2-RELEASE',   "$manLocalDir/FreeBSD-3.2-RELEASE",
     'FreeBSD 3.1-RELEASE',   "$manLocalDir/FreeBSD-3.1-RELEASE",
     'FreeBSD 3.0-RELEASE',   "$manLocalDir/FreeBSD-3.0-RELEASE",
     'FreeBSD 2.2.5-RELEASE',   "$manLocalDir/FreeBSD-2.2.5-RELEASE",
     'FreeBSD 2.2.6-RELEASE',   "$manLocalDir/FreeBSD-2.2.6-RELEASE",
     'FreeBSD 2.2.7-RELEASE',   "$manLocalDir/FreeBSD-2.2.7-RELEASE",
     'FreeBSD 2.2.8-RELEASE',   "$manLocalDir/FreeBSD-2.2.8-RELEASE",
     'FreeBSD 2.2.2-RELEASE',   "$manLocalDir/FreeBSD-2.2.2-RELEASE",
     'FreeBSD 2.2.1-RELEASE',   "$manLocalDir/FreeBSD-2.2.1-RELEASE",
     'FreeBSD 2.1.7.1-RELEASE', "$manLocalDir/FreeBSD-2.1.7.1-RELEASE",
     'FreeBSD 2.1.6.1-RELEASE', "$manLocalDir/FreeBSD-2.1.6.1-RELEASE",
     'FreeBSD 2.1.5-RELEASE', "$manLocalDir/FreeBSD-2.1.5-RELEASE",
     'FreeBSD 2.1.0-RELEASE', "$manLocalDir/FreeBSD-2.1.0-RELEASE",
     'FreeBSD 2.0.5-RELEASE', "$manLocalDir/FreeBSD-2.0.5-RELEASE",
     'FreeBSD 2.0-RELEASE',   "$manLocalDir/FreeBSD-2.0-RELEASE",
     'FreeBSD 1.1.5.1-RELEASE', "$manLocalDir/FreeBSD-1.1.5.1-RELEASE",
     'FreeBSD 1.1-RELEASE',   "$manLocalDir/FreeBSD-1.1-RELEASE",
     'FreeBSD 1.0-RELEASE',   "$manLocalDir/FreeBSD-1.0-RELEASE",
     'FreeBSD Ports',	      "$manLocalDir/FreeBSD-ports",

     'OpenBSD 2.0',           "$manLocalDir/OpenBSD-2.0",
     'OpenBSD 2.1',           "$manLocalDir/OpenBSD-2.1",
     'OpenBSD 2.2',           "$manLocalDir/OpenBSD-2.2",
     'OpenBSD 2.3',           "$manLocalDir/OpenBSD-2.3",
     'OpenBSD 2.4',           "$manLocalDir/OpenBSD-2.4",
     'OpenBSD 2.5',           "$manLocalDir/OpenBSD-2.5",
     'OpenBSD 2.6',           "$manLocalDir/OpenBSD-2.6",
     'OpenBSD 2.7',           "$manLocalDir/OpenBSD-2.7",
     'OpenBSD 2.8',           "$manLocalDir/OpenBSD-2.8",

    #'NetBSD 0.9',            "$manLocalDir/NetBSD-0.9",
     'NetBSD 1.0',            "$manLocalDir/NetBSD-1.0",
     'NetBSD 1.1',            "$manLocalDir/NetBSD-1.1",
     'NetBSD 1.2',            "$manLocalDir/NetBSD-1.2",
     'NetBSD 1.2.1',          "$manLocalDir/NetBSD-1.2.1",
     'NetBSD 1.3',            "$manLocalDir/NetBSD-1.3",
     'NetBSD 1.3.1',          "$manLocalDir/NetBSD-1.3.1",
     'NetBSD 1.3.2',          "$manLocalDir/NetBSD-1.3.2",
     'NetBSD 1.3.3',          "$manLocalDir/NetBSD-1.3.3",
     'NetBSD 1.4',            "$manLocalDir/NetBSD-1.4",
     'NetBSD 1.4.1',          "$manLocalDir/NetBSD-1.4.1",
     'NetBSD 1.4.2',          "$manLocalDir/NetBSD-1.4.2",
     'NetBSD 1.4.3',          "$manLocalDir/NetBSD-1.4.3",
     'NetBSD 1.5',            "$manLocalDir/NetBSD-1.5",

     '2.8 BSD',             "$manLocalDir/2.8BSD",
     '2.9.1 BSD',             "$manLocalDir/2.9.1BSD",
     '2.10 BSD',              "$manLocalDir/2.10BSD",
     '2.11 BSD',              "$manLocalDir/2.11BSD",
     '386BSD 0.0',            "$manLocalDir/386BSD-0.0",
     '386BSD 0.1',            "$manLocalDir/386BSD-0.1",
     '4.3BSD Reno',	      "$manLocalDir/4.3BSD-Reno",
     '4.3BSD NET/2',          "$manLocalDir/net2",
     '4.4BSD Lite2',	      "$manLocalDir/4.4BSD-Lite2",

     'Linux Slackware 3.1',   "$manLocalDir/Slackware-3.1",
     'Red Hat Linux/i386 4.2', "$manLocalDir/RedHat-4.2",
     'Red Hat Linux/i386 5.0', "$manLocalDir/RedHat-5.0",
     'Red Hat Linux/i386 5.2', "$manLocalDir/RedHat-5.2-i386",
     'Red Hat Linux/i386 6.1', "$manLocalDir/RedHat-6.1-i386",
     'Red Hat Linux/i386 6.2', "$manLocalDir/RedHat-6.2-i386",
     'Red Hat Linux/i386 7.0', "$manLocalDir/RedHat-7.0-i386",

     'SuSE Linux/i386 7.1',   "$manLocalDir/Suse-7.1-i386",

     'SunOS 5.8',	      "$manLocalDir/SunOS-5.8",
     'SunOS 5.7',	      "$manLocalDir/SunOS-5.7",
     'SunOS 5.6',	      "$manLocalDir/SunOS-5.6",
     'SunOS 5.5.1',	      "$manLocalDir/SunOS-5.5.1",
     'SunOS 4.1.3',	      "$manLocalDir/SunOS-4.1.3",

     'XFree86 3.2',	      "$manLocalDir/XFree86-3.2",
     'XFree86 3.3',	      "$manLocalDir/XFree86-3.3",
     'XFree86 3.3.6',	      "$manLocalDir/XFree86-3.3.6",
     'XFree86 4.0',	      "$manLocalDir/XFree86-4.0",
     'XFree86 4.0.2',	      "$manLocalDir/XFree86-4.0.2",

     'ULTRIX 4.2',	      "$manLocalDir/ULTRIX-4.2",
     'Plan 9',		      "$manLocalDir/plan9",
     'Minix 2.0',             "$manLocalDir/Minix-2.0",
     'Unix Seventh Edition',  "$manLocalDir/v7man",
     'deutsch - Linux/GNU',   "$manLocalDir/Linux-de",
);

# delete not existing releases
while (($key,$val) = each %manPath) {
    if (! -d $val) {
	delete $manPath{"$key"} if $key ne $manPathDefault;
    }
}

# keywords must be in lower cases.
%manPathAliases = 
    (
     'freebsd', 'FreeBSD 4.2-RELEASE',
     'freebsd-current', 'FreeBSD 5.0-current',
     'slackware', 'Linux Slackware 3.1',
     'linux-de', 'deutsch - Linux/GNU',
     'redhat', 'Red Hat Linux/i386 7.0',
     'suse', 'SuSE Linux/i386 7.1',
     'linux', 'Red Hat Linux/i386 7.0',

     'netbsd', 'NetBSD 1.5',
     'openbsd', 'OpenBSD 2.8',
     'v7', 'Unix Seventh Edition', 
     'v7man', 'Unix Seventh Edition', 
     'x11', 'XFree86 4.0.2',
     'xfree86', 'XFree86 4.0.2',
     'ultrix', 'ULTRIX 4.2',
     'solaris', 'SunOS 5.7',
     'sunos5', 'SunOS 5.8',
     'sunos4', 'SunOS 4.1.3',
     'sunos', 'SunOS 4.1.3',
     'freebsd ports', 'FreeBSD Ports',
     'ports', 'FreeBSD Ports',
     'plan9', 'Plan 9',
);

foreach (sort keys %manPathAliases) {
    # delete non-existing aliases
    if (!defined($manPath{$manPathAliases{$_}})) {
	undef $manPathAliases{$_};
	next;
    }

    # add aliases, replases spaces with dashes
    if (/\s/) {
	local($key) = $_;
	$key =~ s/\s+/-/g;
	$manPathAliases{$key} = $manPathAliases{$_};
    }
}

@sections = keys %sections; shift @sections;	# all but the "" entry
$sections = join("|", @sections);		# sections regexp


# mailto - Author
# webmaster - who run this service
$mailto = 'wosch@FreeBSD.org';
$mailtoURL = 'http://wolfram.schneider.org';
$mailtoURL = "mailto:$mailto" if !$mailtoURL;
$webmaster = $mailto;
$webmasterURL = $mailtoURL;
$manstat = 'http://www.de.freebsd.org/de/stat/man';

&secure_env;
# CGI Interface -- runs at load time
&do_man(&env('SCRIPT_NAME'), &env('PATH_INFO'), &env('QUERY_STRING'))
    unless defined($main'plexus_configured);

# Plexus Native Interface
sub do_man {
    local($BASE, $path, $form) = @_;
    local($_, %form, $query, $proto, $name, $section, $apropos);

    # spinner is buggy, shit
    local($u) = 'http://user.cs.tu-berlin.de/~wosch/man.cgi';
	local($u)= $BASE;

    return &faq_output($u) if ($path =~ /faq.html$/);
    return &copyright_output($u) if ($path =~ /copyright.html$/);
    return &get_the_sources if ($path =~ /source$/);

    return &include_output($path) if ($path =~ m%/usr/include/%);
    return &indexpage if ($form eq "");

    &decode_form($form, *form, 0);
    
    $format = $form{'format'};
    $format = 'html' if $format !~ /^(ps|ascii|latin1|dvi|troff)$/;

    local($fform) = &dec($form);
    if ($fform =~ m%^([a-zA-Z_\-]+)$%) {
	return &man($1, '');
    } elsif ($fform =~ m%^([a-zA-Z_\-]+)\(([0-9a-zA-Z]+)\)$%) {
	return &man($1, $2);
    }

    $name = $query = $form{'query'};
    $section = $form{'sektion'};
    $apropos = $form{'apropos'};
    $alttitle = $form{'title'};
    $manpath = $form{'manpath'};
    if (!$manpath) {
	$manpath = $manPathDefault;
    } elsif (!$manPath{$manpath}) {
	local($m) = ($manpath =~ y/A-Z/a-z/);
	if ($manPath{$manPathAliases{$manpath}}) {
	    $manpath = $manPathAliases{$manpath};
	} else {
	    $manpath = $manPathDefault;
	}
    }

    # download a man hierarchie as gzip'd tar file
    return &download if ($apropos > 1);

    # empty query
    return &indexpage if ($manpath && $form !~ /query=/);

    $section = "" if $section eq "ALL" || $section eq '';

    if (!$apropos && $query =~ m/^(.*)\(([^\)]*)\)/) {
	$name = $1; $section = $2;
    }
    
    $apropos  ?  &apropos($query)  :  &man($name, $section);
}

# --------------------- support routines ------------------------

sub debug {
    &http_header("text/plain");
    print @_,"\n----------\n\n\n";
}

sub get_the_sources {
    local($file) = '/usr/local/www/bsddoc/bin/man.cgi';
    $file = $0 if ! -f $file;

    open(R, $file) || &mydie("open $file: $!\n");
    print "Content-type: text/plain\n\n";
    while(<R>) { print }
    close R;
    exit;
}

# download a manual directory as gzip'd tar archive
sub download {

    $| = 1;
    print qq{Content-type: application/x-tar\n} .
	qq{Content-encoding: x-gzip\n\n};

    local($m) = $manPath{"$manpath"};
    $m =~ s%^$manLocalDir/?%%;

    chdir($manLocalDir) || do {
	print "chdir: $!\n"; exit(0);
    };

    sleep 1;
    system("find $m/* -print | cpio -o -H tar 2>/dev/null | gzip -cqf");
    exit(0);
}

sub http_header {
    local($content_type) = @_;
    if (defined($main'plexus_configured)) {
	&main'MIME_header('ok', $content_type);
    } else {
	print "Content-type: $content_type\n\n";
    }
}

sub env { defined($main'ENV{$_[0]}) ? $main'ENV{$_[0]} : undef; }

sub apropos {
    local($query) = @_;
    local($_, $title, $head, *APROPOS);
    local($names, $section, $msg, $key);
    local($prefix);

    $prefix = "Apropos ";
    if ($alttitle) {
	$prefix = "";
	$title = &encode_title($alttitle);
	$head = &encode_data($alttitle);
    } else {
	$title = &encode_title($query);
	$head = &encode_data($query);
    }

    &http_header("text/html");
    print &html_header("$www{'title'}: Apropos $title");
    print "<H1>$www{'head'}</H1>\n\n";
    &formquery;

    local($mpath) = ($manpath ? &dec($manpath) : $manPathDefault);

    open(APROPOS, "$manPath{$mpath}/whatis") || do {
	print "Cannot open whatis database for `$mpath'\n";
	print "</DL>\n</BODY>\n</HTML>\n";
	return;
    };

    local($q) = $query; 
    $q =~ s/(\W)/\\W/g;
    local($acounter) = 0;
    
    while (<APROPOS>) {
	next if !/$q/oi;
	$acounter++;

    	# matches whatis.db lines: name[, name ...] (sect) - msg
	$names = $section = $msg = $key = undef;
	($key, $section) = m/^([^()]+)\(([^)]*)\)/;
        $key =~ s/\s+$//;
        $key =~ s/.*\s+//;
        ($names, $msg) = m/^(.*\))\s+-\s+(.*)/;
	print "<DT><A HREF=\"$BASE?query=", &encode_url($key),
	    "&sektion=", &encode_url($section), "&apropos=0", 
            "&manpath=", &encode_url($manpath), "\">",
	    &encode_data("$names"), "</A>\n<DD>",
	    &encode_data($msg), "\n";
    }
    close(APROPOS);

    if (!$acounter) {
	print "Sorry, no data found for `$query'.\n";
	print qq{You may look for other } . 
	    qq{<a href="../../search.html">FreeBSD Search Services</a>.\n};
    }
    print "</DL>\n</BODY>\n</HTML>\n";
}

sub man {
    local($name, $section) = @_;
    local($_, $title, $head, *MAN);
    local($html_name, $html_section, $prefix);
    local(@manargs);
    local($query) = $name;

    # $section =~ s/^([0-9ln]).*$/$1/;
    $section =~ tr/A-Z/a-z/;

    $prefix = "Man ";
    if ($alttitle) {
	$prefix = "";
	$title = &encode_title($alttitle);
	$head = &encode_data($alttitle);
    } elsif ($section) {
	$title = &encode_title("${name}($section)");
	$head = &encode_data("${name}($section)");
    } else {
	$title = &encode_title("${name}");
	$head = &encode_data("${name}");
    }

    if ($format eq "html") {
	&http_header("text/html");
	print &html_header("$www{'title'}: $title");
	print "<H1>$www{'head'}</H1>\n\n";
	&formquery;
	print "<PRE>\n";
    } else {
	#$format =~ /^(ps|ascii|latin1|dvi|troff)$/')
	$ENV{'NROFF_FORMAT'} = $format;

	# Content-encoding: x-gzip
	if ($format eq "ps") {
	    &http_header("application/postscript");
	} elsif ($format eq "dvi") {
	    &http_header("application/x-dvi");
	} elsif ($format eq "troff") {
	    &http_header("application/x-troff-mandoc");
	} else {
	    &http_header("text/plain");
	}
    }

    $html_name = &encode_data($name);
    $html_section = &encode_data($section);

    #print Dumper($sectionpath);
    #print "yy $section yy $manpath\n";
    if ($name =~ /^\s*$/) {	
	print "Empty input, no man page given.\n";
	return;
    }

    if (index($name, '*') != -1) {	
	print "Invalid character input '*': $name\n";
	return;
    }

    if ($section !~ /^[0-9ln]\w*$/ && $section ne '') {
	print "Sorry, section `$section' is not valid\n";
	return;
    }

    if (!$section) {
	if ($sectionpath->{$manpath}) {
	    $section = "-S " . $sectionpath->{$manpath}{'path'};
	} else {
	    $section =  '';
	}
    } else {
	if ($sectionpath->{$manpath}{$section}) {
	    $section = "-S " . $sectionpath->{$manpath}{$section};
	} else {
	    $section = "-S $section";
	}
    }

    @manargs = split(/ /, $section);
    if ($manpath) {
	if ($manPath{$manpath}) {
	    unshift(@manargs, ('-M', $manPath{$manpath}));
	} elsif ($manpath{&dec($manpath)}) {
	    unshift(@manargs, ('-M', $manPath{&dec($manpath)}));
	} else {
	    # unset invalid manpath
	    print "x $manpath x\n";
	    print "x " . &dec($manpath) . "x\n";
	    undef $manpath;
	}
    }

    # print "X $command{'man'} @manargs -- x $name x\n";
    &proc(*MAN, $command{'man'}, @manargs, "--", $name) ||
	&mydie ("$0: open of $command{'man'} command failed: $!\n");
    if (eof(MAN)) {
	# print "X $command{'man'} @manargs -- x $name x\n";
	print "Sorry, no data found for `$html_name" .
		($html_section ? "($html_section)": '') . "'.\n";
	print qq{You may look for other } . 
	    qq{<a href="../../search.html">FreeBSD Search Services</a>.\n};
	return;
    }

    if ($format ne "html") {
	if ($format eq "latin1" || $format eq "ascii") {
	    while(<MAN>) { s/.//g; print; }
	} else {
	    while(<MAN>) { print; }
	}
	close(MAN);
	exit(0);
    }

    local($space) = 1;
    local(@sect);
    local($i, $j);
    while(<MAN>) {
	# remove tailing white space
	if (/^\s+$/) {
	    next if $space;
	    $space = 1;
	} else {
	    $space = 0;
	}

	$_ = &encode_data($_);
	if(m,(<B>)?\#include(</B>)?\s+(<B>)?\&lt\;(.*\.h)\&gt\;(</B>)?,) {
	    $match = $4; ($regexp = $match) =~ s/\./\\\./;
	    s,$regexp,\<A HREF=\"$BASE/usr/include/$match\"\>$match\</A\>,;
        }
	/^\s/ && 			# skip headers
	    s,((<[IB]>)?[\w\_\.\-]+\s*(</[IB]>)?\s*\(([1-9ln][a-zA-Z]*)\)),&mlnk($1),oige;

	# detect E-Mail Addreses in manpages
	if (/\@/) {
	    s/([a-z0-9_\-\.]+\@[a-z0-9\-\.]+\.[a-z]+)/<A HREF="mailto:$1">$1<\/A>/gi;
	}

	# detect URLs in manpages
	if (m%tp://%) {
	    s,((ftp|http)://[^\s<>\)]+),<A HREF="$1">$1</A>,gi;
	}

	if (/^<B>\S+/ && m%^<B>([^<]+)%) {
	    $i = $1; $j = &encode_url($i);
	    s%^<B>([^<]+)</B>%<a name="$j" href="#end"><B>$i</B></a>%;
	    push(@sect, $1);
        }
	print;
    }
    close(MAN);
    print qq{</PRE>\n<a name="end">\n<hr noshade>\n};

    for ($i = 0; $i <= $#sect; $i++) {
	print qq{<a href="#} . &encode_url($sect[$i]) . 
            qq{">$sect[$i]</a>} . ($i < $#sect ? " |\n" : "\n");
    }

    print "</BODY>\n";
    print "</HTML>\n";

    # Sleep 0.35 seconds to avoid DoS attacs
    select undef, undef, undef, 0.35;
}

sub mlnk {
    local($matched) = @_;
    local($link, $section);
    ($link = $matched) =~ s/[\s]+//g;
    $link =~ s/<\/?[IB]>//g;
    ($link, $section) = ($link =~ m/^([^\(]*)\((.*)\)/);
    $link = &encode_url($link);
    $section = &encode_url($section);
    local($manpath) = &encode_url($manpath);
    return qq{<A HREF="$BASE?query=$link} . 
           qq{&sektion=$section&apropos=0&manpath=$manpath">$matched</A>};
}

sub proc {
    local(*FH, $prog, @args) = @_;
    local($pid) = open(FH, "-|");
    return undef unless defined($pid);
    if ($pid == 0) {
	exec $prog, @args;
	&mydie("exec $prog failed\n");
    }
    1;
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

sub dec {
    local($_) = @_;

    s/\+/ /g;                       # '+'   -> space
    s/%(..)/pack("c",hex($1))/ge;   # '%ab' -> char ab

    return($_);
}

#
# Splits up a query request, returns an array of items.
# usage: @items = &main'splitquery($query);
#
sub splitquery {
    local($query) = @_;
    grep((s/%([\da-f]{1,2})/pack(C,hex($1))/eig, 1), split(/\+/, $query));
}

# encode unknown data for use in a URL <A HREF="...">
sub encode_url {
    local($_) = @_;
    # rfc1738 says that ";"|"/"|"?"|":"|"@"|"&"|"=" may be reserved.
    # And % is the escape character so we escape it along with
    # single-quote('), double-quote("), grave accent(`), less than(<),
    # greater than(>), and non-US-ASCII characters (binary data),
    # and white space.  Whew.
    s/([\000-\032\;\/\?\:\@\&\=\%\'\"\`\<\>\177-\377 ])/sprintf('%%%02x',ord($1))/eg;
    s/%20/+/g;
    $_;
}
# encode unknown data for use in <TITLE>...</TITILE>
sub encode_title {
    # like encode_url but less strict (I couldn't find docs on this)
    local($_) = @_;
    s/([\000-\031\%\&\<\>\177-\377])/sprintf('%%%02x',ord($1))/eg;
    $_;
}
# encode unknown data for use inside markup attributes <MARKUP ATTR="...">
sub encode_attribute {
    # rfc1738 says to use entity references here
    local($_) = @_;
    s/([\000-\031\"\'\`\%\&\<\>\177-\377])/sprintf('\&#%03d;',ord($1))/eg;
    $_;
}
# encode unknown text data for using as HTML,
# treats ^H as overstrike ala nroff.
sub encode_data {
    local($_) = @_;
    local($str);

    # Escape &, < and >
    s,\010[><&],,g;
    s/\&/\&amp\;/g; 
    s/\</\&lt\;/g; 
    s/\>/\&gt\;/g;

    s,((_\010.)+),($str = $1) =~ s/.\010//g; "<I>$str</I>";,ge;
    s,(.\010)+,$1,g;

    if (!s,((.\010.)+\s+(.\010.)+),($str = $1) =~ s/.\010//g; "<B>$str</B>";,ge) {
    s,((.\010.)+),($str = $1) =~ s/.\010//g; "<B>$str</B>";,ge;
    }


    # Escape binary data except for ^H which we process below
    # \375 gets turned into the & for the entity reference
    #s/([^\010\012\015\032-\176])/sprintf('\375#%03d;',ord($1))/eg;
    # Process ^H sequences, we use \376 and \377 (already escaped
    # above) to stand in for < and > until those characters can
    # be properly escaped below.
    #s,\376[IB]\377_\376/[IB]\377,,g;
    #s/.[\b]//g;			# just do an erase for anything else
    # Now convert our magic chars into our tag markers
    #s/\375/\&/g; s/\376/</g; s/\377/>/g;

    $_;
}

sub indexpage {
    &http_header("text/html");
    print &html_header("$www{'title'}: Index Page") .
	 "<H1>$www{'head'}</H1>\n\n" . &intro;
    &formquery;

    local($m) = ($manpath ? $manpath : $manPathDefault);
    $m = &encode_url($m);

    print "<B><I>Section Indexes</I></B>: ";
    foreach ('1', '2', '3', '4', '5', '6', '7', '8', '9', 'n') {
	print qq{&#164; <A HREF="$BASE?query=($_)&sektion=&apropos=1&manpath=$m&title=Section%20$_Index">$_</A>\n};
    }

    print "<BR><B><I>Explanations of Man Sections:</I></B>";
    foreach ('1', '2', '3', '4', '5', '6', '7', '8', '9') {
	print qq{&#164; <A HREF="$BASE?query=intro&sektion=$_&apropos=0&manpath=$m&title=Introduction%20Section%20$_">intro($_)</A>\n};
    }

    print "<BR>\n<B><I>Quick Reference Categories:</I></B>\n";
    foreach ('database', 'disk', 'driver', 'ethernet', 'mail', 'net', 'nfs', 
             'nis', 'protocol', 'ppp', 'roff', 'string', 'scsi', 
	     'statistic', 'tcl', 'tcp', 'time') 
    {
	print qq{&#164; <A HREF="$BASE?query=$_&sektion=&apropos=1&manpath=$m&title=Quick%20Ref%20$_">$_</A>\n};
    }

    print <<ETX if $mailto;
<HR noshade>
<img ALIGN="RIGHT" src="/gifs/powerlogo.gif">
Please direct questions about this server to
<I><A HREF="$webmasterURL">$webmaster</A></I><br>
URL:  <A HREF="$BASE" target=_parent>$www{'home'}$BASE</a><br>
ETX

    print q{$Date: 2001-03-11 10:32:58 $ $Revision: 1.30 $};
    print "<br>\n";
    print "</BODY>\n</HTML>\n";
    0;
}

sub formquery {
    local($astring, $bstring);
    if (!$apropos) {
	$astring = " CHECKED";
    } else {
	$bstring = " CHECKED";
    }

    print <<ETX;
<FORM METHOD="GET" ACTION="$BASE">
<B><I>Man Page or Keyword Search:</I></B>
<INPUT VALUE="$query" NAME="query">
<INPUT TYPE="submit" VALUE="Submit">
<INPUT TYPE="reset" VALUE="Reset">
<BR>
<INPUT NAME="apropos" VALUE="0" TYPE="RADIO"$astring> <A HREF="$BASE?query=man&sektion=1&apropos=0">Man</A>
<SELECT NAME="sektion">
ETX


    while(($key, $value) = each %sectionName) {
	print "<OPTION" . (($key eq $section) ? ' SELECTED ' : ' ') .
	      qq{VALUE="$key">$value</OPTION>\n};
    };

    print qq{</SELECT>\n<SELECT NAME="manpath">\n};

    local($l) = ($manpath ? $manpath : $manPathDefault);
    foreach (sort keys %manPath) {
	$key = $_;
	print "<OPTION" . (($key eq $l) ? ' SELECTED ' : ' ') .
	      qq{VALUE="$key">$key</OPTION>\n};
    }

    local($m) = &encode_url($l);
    print <<ETX;
</SELECT>
<BR>
<INPUT NAME="apropos" VALUE="1" TYPE="RADIO"$bstring> <A HREF="$BASE?query=apropos&sektion=1&apropos=0">Apropos</A> Keyword Search (all sections)
<SELECT NAME="format">
ETX

    foreach ('html', 'troff', 'ps', 
	     # 'dvi', # you need a 8 bit clean man, e.g. jp-man
	     'ascii', 'latin1') {
	print qq{<OPTION VALUE="$_">$_</OPTION>\n};
    };

    print <<ETX;
</SELECT>
Output format
</FORM>

<A HREF="$BASE?manpath=$m">Index Page and Help</A> |
<A HREF="$BASE/faq.html">FAQ</A> |
<A HREF="$BASE/copyright.html">Copyright</A>
<HR>
ETX
    0;
}

sub copyright {
    return qq{\
<PRE>
Copyright (c) 1996-1999 Wolfram Schneider <A HREF="$mailtoURL">&lt;$mailto&gt;</A>. Berlin.
Copyright (c) 1993-1995 Berkeley Software Design, Inc.

This data is part of a licensed program from BERKELEY SOFTWARE
DESIGN, INC.  Portions are copyrighted by BSDI, The Regents of
the University of California, Massachusetts Institute of
Technology, Free Software Foundation, FreeBSD Inc., and others.

</PRE>\n
Copyright (c) for man pages by OS vendors.
<p>
<a href="ftp://ftp.2bsd.com">2.11 BSD</a>,
<a href="http://www.freebsd.org">FreeBSD</a>,
<a href="http://www.cs.vu.nl/~ast/minix.html">Minix</a>,
<a href="http://slackware.com">Linux Slackware</a>,
<a href="http://www.linux.de">Linux/de</a>,
<a href="http://www.netbsd.org">NetBSD</a>,
<a href="http://www.openbsd.org">OpenBSD</a>,
<a href="http://plan9.bell-labs.com/plan9/">Plan 9</a>,
<a href="http://www.sun.com">SunOS</a>,
<a href="http://www.digital.com">ULTRIX</a>,
<a href="ftp://elib.zib.de/pub/netlib/att/cs/v7man">Unix Seventh Edition</a>,
<a href="http://www.xfree86.org">XFree86</a>
};
}

sub faq {
    
    local(@list, @list2);
    local($url);
    foreach (sort keys %manPath) {
	$url = &encode_url($_);
	push(@list, 
	     qq{<li><a href="$BASE?apropos=2&manpath=$url">[download]} .
	     qq{</a> "$_" -> $BASE?manpath=$url});
    }

    foreach (sort keys %manPathAliases) {
	push(@list2, qq[<li>"$_" -> "$manPathAliases{$_}" -> ] .
	     "$BASE?manpath=" . 
	     &encode_url($_) . "\n") if $manPathAliases{$_};
    }

    return qq{\
<PRE>
Copyright (c) 1996-1999 Wolfram Schneider <a href="$mailtoURL">&lt;$mailto&gt;</a>. Berlin.
</PRE>

<h2>FAQ</h2>
<UL>
<li>Get the <a href="$BASE/source">source</a> of the man.cgi script
<li>Links to /usr/include works only for the OS version
which run on this server (FreeBSD-2.2.5)
<li>Troff macros works only if defined in FreeBSD/groff. OS specific
macros like `appeared in NetBSD version 1.2' are not supported.
<li>Netscape is buggy, you may press twice the link 'Index Page and Help'
<li>BSDI man pages are located at <a href="http://www.bsdi.com/bsdi-man/">http://www.bsdi.com/bsdi-man/</a>
<li>Other man pages, from <a href="http://www.yahoo.com/">
http://www.yahoo.com</a>
at <a href="http://www.yahoo.com/Computers_and_Internet/Information_and_Documentation/Man_Pages/">Computers_and_Internet/Information_and_Documentation/Man_Pages/</a>
<li>Some OSs provide only formated manual pages (catpages), e.g. NetBSD
and OpenBSD. In this case it is not possible to create Postscript
and troff output.
<li>Man page usage <a href="$manstat">statistic</a> of this script.
<li>The <a href="http://www.de.freebsd.org/de/ftp/unix-stammbaum">
Unix family tree, BSD part</a>.
<li>The <a href="http://www.freebsd.org/cgi/ports.cgi">
FreeBSD Ports Changes</a> script.
<li>Copyright (c) and download for man pages by <a href="$BASE/copyright.html">
OS vendors</a>
</UL>

<h2>Releases</h2>

Releases and Releases Aliases are information how 
to make a link to this script to the right OS version.
<p>
You may download the manpages as gzip'd tar archive
for private use. A tarball is usually 5MB big.
<p>
<ul>
@list
</ul>

<h2>Releases Aliases</h2>
Release aliases are for lazy people. Plus, they have a longer
lifetime, eg. 'openbsd' points always to the latest OpenBSD release.
<ul>
@list2
</ul>
};
}


sub intro {
    return qq{\
<P>
<I>Man Page Lookup</I> searches for man pages name and section as
given in the selection menu and the query dialog.  <I>Apropos
Keyword Search</I> searches the database for the string given in
the query dialog.  There are also several hypertext links provided
as short-cuts to various queries:  <I>Section Indexes</I> is apropos
listings of all man pages by section.  <I>Explanations of Man
Sections</I> contains pointers to the intro pages for various man
sections.  Or you can select a catagory from <I>Quick Reference
Categories</I> and see man pages relevant to the selected topic.
<P>
};
}

sub copyright_output {
    &http_header("text/html");
    print &html_header("HTML hypertext FreeBSD man page interface") .
	"<H1>$www{'head'}</H1>\n" . &copyright . qq{\
<HR>

<A HREF="$_[0]">Index Page and Help</A>
</BODY>
</HTML>
};
}

sub faq_output {
    &http_header("text/html");
    print &html_header("HTML hypertext FreeBSD man page interface") .
	"<H1>$www{'head'}</H1>\n" . &faq . qq{\
<HR>

<A HREF="$_[0]">Index Page and Help</A>
</BODY>
</HTML>
};
}

sub html_header {
    return qq{<HTML>
<HEAD>
<TITLE>$_[0]</TITLE>
<link rev="made" href="mailto:wosch\@FreeBSD.ORG">
<META name="robots" content="nofollow">
</HEAD> 
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">\n\n};
}

sub secure_env {
    $main'ENV{'PATH'} = '/bin:/usr/bin';
    $main'ENV{'MANPATH'} = $manPath{$manPathDefault};
    $main'ENV{'IFS'} = " \t\n";
    $main'ENV{'PAGER'} = 'cat';
    $main'ENV{'SHELL'} = '/bin/sh';
    $main'ENV{'LANG'} = 'en_US.ISO_8859-1';
    undef $main'ENV{'DISPLAY'};
}

sub include_output {
    local($inc) = @_;

    &http_header("text/plain");
    open(I, "$inc") || do { print "open $inc: $!\n"; exit(1) };
    while(<I>) { print }
    close(I);
}

# CGI script must die with error status 0
sub mydie {
	local($message) = @_;
	&http_header("text/html");
	print &html_header("Error");
	print $message;

print qq{
<p>
<A HREF="$BASE">Index Page and Help</A>
</BODY>
</HTML>
};

	exit(0);
}

1;

