#!/usr/bin/perl -T
#
# Copyright (c) 1996-2017 Wolfram Schneider <wosch@FreeBSD.ORG>
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

use POSIX qw(strftime);
use Time::Local;

require "./cgi-style.pl";
$t_style = qq`<style type="text/css">
h3 { font-size: 1.2em; border-bottom: thin solid black; }
</style>
<link rel="search" type="application/opensearchdescription+xml" href="https://www.freebsd.org/search/opensearch/ports.xml" title="FreeBSD Ports" />
`;

sub init_variables {
    $localPrefix = '/usr/ports';    # ports prefix

    # Directory of the up-to-date INDEX*
    $portsDatabaseHeadDir = "/usr/local/www/ports";

    # Ports database file to use
    if ( -f "$portsDatabaseHeadDir/INDEX-12" ) {
        $ports_database = 'INDEX-12';
    }
    elsif ( -f "$portsDatabaseHeadDir/INDEX-11" ) {
        $ports_database = 'INDEX-11';
    }
    else {
        $ports_database = 'INDEX';
    }

    # URL of ports tree for browsing
    $remotePrefixFtp = 'ports';

    # 'ftp://ftp.FreeBSD.org/pub/FreeBSD/branches/-current/ports';

    # where to get -current packages
    local ($p)        = 'ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/i386';
    local ($palpha)   = 'ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/alpha';
    local ($pamd64)   = 'ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/amd64';
    local ($pia64)    = 'ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/ia64';
    local ($psparc64) = 'ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/sparc64';

    $remotePrefixFtpPackagesDefault = '6-STABLE/i386';

    # This is currently unused
    %remotePrefixFtpPackages = (
        '7-CURRENT/i386', "$p/packages-7-current/All",
        '6-STABLE/i386',  " $p/packages-6-stable/All",
        '5-STABLE/i386',  " $p/packages-5-stable/All",
        '4-STABLE/i386',  " $p/packages-4-stable/All",

        '6.0-RELEASE/i386',  "$p/packages-6.0-release/All",
        '5.4-RELEASE/i386',  "$p/packages-5.4-release/All",
        '4.11-RELEASE/i386', "$p/packages-4.11-release/All",

        '4-STABLE/alpha', "$palpha/packages-4-stable/All",

        '5.4-RELEASE/alpha',  "$palpha/packages-5.4-release/All",
        '4.11-RELEASE/alpha', "$palpha/packages-4.11-release/All",

        '7-CURRENT/amd64', "$pamd64/packages-7-current/All",
        '6-STABLE/amd64',  "$pamd64/packages-6-stable/All",
        '5-STABLE/amd64',  "$pamd64/packages-5-stable/All",

        '6.0-RELEASE/amd64', "$pamd64/packages-6.0-release/All",
        '5.4-RELEASE/amd64', "$pamd64/packages-5.4-release/All",

        '7-CURRENT/ia64', "$pia64/packages-7-current/All",
        '6-STABLE/ia64',  "$pia64/packages-6-stable/All",

        '6.0-RELEASE/ia64', "$pia64/packages-6.0-release/All",
        '5.4-RELEASE/ia64', "$pia64/packages-5.4-release/All",

        '7-CURRENT/sparc64', "$psparc64/packages-7-current/All",
        '6-STABLE/sparc64',  "$psparc64/packages-6-stable/All",
        '5-STABLE/sparc64',  "$psparc64/packages-5-stable/All",

        '6.0-RELEASE/sparc64', "$psparc64/packages-6.0-release/All",
        '5.4-RELEASE/sparc64', "$psparc64/packages-5.4-release/All",
    );

    $remotePrefixHtml = "$hsty_base/ports";

    # Web interface for the Ports tree
    $remotePrefixRepo = 'https://svnweb.FreeBSD.org/ports/head';

    # Ports documentation
    $portsDesc = "$hsty_base/ports/";

    # location of the tiny BSD daemon
    $daemonGif =
"<img src='$hsty_base/gifs/littlelogo.gif' alt='Really small BSD Daemon'>";

    # visible E-Mail address, plain text
    $mailto = 'www@FreeBSD.org';

    # Mailinglist for FreeBSD Ports
    $mailtoList = 'ports@FreeBSD.org';

    # use mailto:email?subject
    $mailtoAdvanced = 'yes';

    # the URL if you click at the E-Mail address (see below)
    $mailtoURL = "mailto:$mailto" if !$mailtoURL;

    # security
    $ENV{'PATH'} = '/bin:/usr/bin';

    # extension type for packages
    $packageExt = 'tbz';

    local ($packageDB) = '../ports/packages.exists';
    &packages_exist( $packageDB, *packages ) if -f $packageDB;

}

sub packages_exist {
    local ( $file, *p ) = @_;

    open( P, $file ) || do {
        warn "open $file: $!\n";
        warn "Cannot create packages links\n";
        return 1;
    };

    while (<p>) {
        chop;
        $p{$_} = 1;
    }
    close P;
    return 0;
}

# return the date of the last ports database update
sub last_update {
    local ($file) = "$portsDatabaseHeadDir/$ports_database";
    local ( $modtime, $modtimestr );

    $modtime = ( stat($file) )[9];
    if ( defined($modtime) && $modtime > 0 ) {
        $modtimestr = strftime( "%Y-%m-%d %H:%M:%S UTC", gmtime($modtime) );
    }
    else {
        $modtimestr = "Unknown";
    }

    return $modtimestr;
}

sub last_update_message {
    return "<p>Last database update: " . &last_update . "</p>\n";
}

sub dec {
    local ($_) = @_;

    s/\+/ /g;                        # '+'   -> space
    s/%(..)/pack("c",hex($1))/ge;    # '%ab' -> char ab

    return ($_);
}

# $indent is a bit of optional data processing I put in for
# formatting the data nicely when you are emailing it.
# This is derived from code by Denis Howe <dbh@doc.ic.ac.uk>
# and Thomas A Fine <fine@cis.ohio-state.edu>
sub decode_form {
    local ( $form, *data, $indent, $key, $_ ) = @_;
    foreach $_ ( split( /&/, $form ) ) {
        ( $key, $_ ) = split( /=/, $_, 2 );
        $_   =~ s/\+/ /g;                                 # + -> space
        $key =~ s/\+/ /g;                                 # + -> space
        $_   =~ s/%([\da-f]{1,2})/pack(C,hex($1))/eig;    # undo % escapes
        $key =~ s/%([\da-f]{1,2})/pack(C,hex($1))/eig;    # undo % escapes
        $_   =~ s/[\r\n]+/\n\t/g if defined($indent);     # indent data after \n
        $data{$key} = $_;
    }
}

sub escapeHTML {
    my $toencode = shift;
    return "" unless defined($toencode);

    $toencode =~ s{&}{&amp;}gso;
    $toencode =~ s{<}{&lt;}gso;
    $toencode =~ s{>}{&gt;}gso;
    $toencode =~ s{"}{&quot;}gso;
    return $toencode;
}

# encode unknown data for use in a URL <a href="...">
sub encode_url {
    local ($_) = @_;
s/([\000-\032\;\/\?\:\@\&\=\%\'\"\`\<\>\177-\377 ])/sprintf('%%%02x',ord($1))/eg;

    # s/%20/+/g;
    $_;
}

sub warn { print "$_[0]" }
sub env  { defined( $ENV{ $_[0] } ) ? $ENV{ $_[0] } : undef; }
sub exit { exit 0 }

sub readindex {
    local ( *var, *msec ) = @_;
    local ($localportsdb) = "$portsDatabaseHeadDir/$ports_database";
    local ( @tmp, @s );

    open( C, $localportsdb ) || do {
        warn "Cannot open ports database $localportsdb: $!\n";
        &exit;
    };

    while (<C>) {
        next if $query && !/$query/oi;
        chop;

        @tmp            = split(/\|/);
        $var{"$tmp[1]"} = $_;
        @s              = split( /\s+/, $tmp[6] );
        foreach (@s) {
            $msec{"$tmp[1],$_"} = 1;
        }
    }
    close C;
}

# extract sub collections
sub readcoll {

    local ( @a, @b, %key );
    local ($file)         = '../ports/categories';
    local ($localportsdb) = "$portsDatabaseHeadDir/$ports_database";

    if ( -r $file && open( C, $file ) ) {
        while (<C>) {
            chop;

            if (/^\s*([^,]+),\s*"([^"]+)",\s*([A-Z]+)/) {
                @b = split( /\s+/, $1 );
                foreach (@b) {
                    if ( !defined( $key{$_} ) ) {
                        $key{$_} = 1;
                    }
                }
            }
        }
    }
    else {
        if ( -r $localportsdb ) {
            open( C, $localportsdb ) || do {
                warn "Cannot open ports database $localportsdb: $!\n";
                &exit;
              }
        }

        while (<C>) {
            chop;

            @a = split('\|');
            @b = split( /\s+/, $a[6] );

            foreach (@b) {
                if ( !defined( $key{$_} ) ) {
                    $key{$_} = 1;
                }
            }
        }
    }
    close C;

    @a = ();
    foreach ( sort keys %key ) {
        push( @a, $_ );
    }

    return @a;
}

# basic function for HTML output
sub out {
    local ($line) = @_;
    local (
        $version, $path,     $local,    $comment,  $descfile,
        $email,   $sections, $bdepends, $rdepends, @rest
    ) = split( /\|/, $line );

    if ( $path =~ m%^$localPrefix/([^/]+)%o ) {
        if ( !$out_sec || $1 ne $out_sec ) {
            print "</dl>\n" if $counter > 0;
            print qq{\n<h3>}
              . qq{<a href="$remotePrefixHtml/$1.html">Category $1</a>}
              . "</h3>\n<dl>\n";
            $out_sec = $1;
        }
    }

    $counter++;
    $pathDownload = $path;
    $pathB        = $path;
    $pathB =~ s/^$localPrefix/ports/o;

    $path         =~ s/^$localPrefix/$remotePrefixFtp/o;
    $descfile =~ s/^$localPrefix/$remotePrefixFtp/o;
    $version = &encode_url($version);

    #$version =~ s/[\+,]/X/g;

    local ($l) = $path;
    $l =~ s%^$remotePrefixFtp%$remotePrefixRepo%o;
    $descfile =~ s%^$remotePrefixFtp%$remotePrefixRepo%o;

    print
      qq{<dt><b><a name="$version"></a><a href="$l">$version</a></b></dt>\n};
    print qq{<dd>}, &escapeHTML($comment), qq{<br />\n};

    print qq[<a href="$descfile?revision=HEAD">Description</a> <b>:</b>\n];

  # Link package in "default" arch/release. Verify it's existence on ftp-master.
    if ( $packages{"$version.$packageExt"} ) {
        print
qq[<a href="$remotePrefixFtpPackages{$remotePrefixFtpPackagesDefault}/$version.$packageExt">Package</a> <b>:</b>\n];
    }

    print qq[<a href="$l/?view=log">Changes</a> <br />\n];

    print qq{<i>Maintained by:</i> <a href="mailto:$email}
      . (
        $mailtoAdvanced
        ? qq{?cc=$mailtoList&amp;subject=FreeBSD%20Port:%20}
          . &encode_url($version)
        : ''
      ) . qq{">$email</a><br />\n};

    local (@s) = split( /\s+/, $sections );
    if ( $#s > 0 ) {
        print qq{<i>Also listed in:</i> };
        foreach (@s) {
            print qq{<a href="$remotePrefixHtml/$_.html">$_</a> }
              if $_ ne $out_sec;
        }
        print "<br />\n";
    }

    if ( $bdepends || $rdepends ) {
        local ($flag) = 0;
        local ($last) = '';
        print qq{<i>Requires:</i> };
        foreach ( sort split( /\s+/, "$bdepends $rdepends" ) ) {

            # delete double entries
            next if $_ eq $last;
            $last = $_;

            print ", " if $flag;
            $flag++;
            print qq{<a href="$script_name?query=^$_&amp;stype=name">$_</a>};
        }
        print "<br />\n";
    }

    print qq[</dd>];

    # XXX: should be done in a CSS
    print qq[<dd>&nbsp;</dd>];
    print qq[\n\n];

}

# search and output
sub search_ports {
    local (@a) = ();
    local ( $key, $name, $text );

    foreach $key ( sort keys %today ) {
        next if $today{$key} !~ /$query/oi;

        @a    = split( /\|/, $today{$key} );
        $name = $a[0];                         #$name =~ s/(\W)/\\$1/g;
        $text = $a[3];                         #$text =~ s/(\W)/\\$1/g;

        if ( $section ne "all" ) {
            next if $a[6] !~ /^$section(\s|$)/;
        }

        #warn "$stype:$query: $name $text\n";
        if ( $stype eq "name" && $name =~ /$query/o ) {
            &out( $today{$key} );
        }
        elsif ( $stype eq "text" && $text =~ /$query/oi ) {
            &out( $today{$key} );
        }
        elsif ( $stype eq "all"
            && ( $text =~ /$query/oi || $name =~ /$query/io ) )
        {
            &out( $today{$key} );
        }
        elsif ( $stype eq 'maintainer' && $a[5] =~ /$query/io ) {
            &out( $today{$key} );
        }
        elsif ( $stype eq 'requires'
            && ( $a[7] =~ /$query/io || $a[8] =~ /$query/io ) )
        {
            &out( $today{$key} );
        }

    }
}

sub forms {
    print qq{<p>
FreeBSD Ports [short description <a href="$portsDesc">followed</a> ...]
<a href="$script_name?stype=faq">FAQ</a>
</p>
};

    print qq{<p>
"Package Name" searches for the name of a port or distribution.
"Description" searches case-insensitive in a short comment about the port.
"All" searches case-insensitive for the package name and in the
description about the port.
</p>

<form method="get" action="$script_name">
Search for:
<input name="query" value="$query" type="text" autocapitalize="none" />
<select name="stype">
};

    local (%d);
    %d = (
        'name',       'Package Name',     'all',      'All',
        'maintainer', 'Maintainer',       'text',     'Description',
        'requires', 'Requires',
    );

    foreach ( 'all', 'name', 'text', 'maintainer', 'requires' ) {
        print "<option"
          . ( ( $_ eq $stype ) ? ' selected="selected" ' : ' ' )
          . qq{value="$_">}
          . ( $d{$_} ? $d{$_} : $_ )
          . qq{</option>\n};
    }

    print qq{</select>

<select name="sektion">
<option value="all">All Sections</option>
};

    foreach (@sec) {
        print "<option"
          . ( ( $_ eq $section ) ? ' selected="selected" ' : ' ' )
          . qq{value="$_">$_</option>\n};
    }

    print q{</select>
<input type="submit" value="Submit" />
</form>
<hr noshade="noshade" />
};

}

sub footer {

    print qq{
<img align="right" src="$hsty_base/gifs/powerlogo.gif" alt="Powered by FreeBSD" />
&copy; 1996-2017 by Wolfram Schneider. All rights reserved.<br />
};

#print q{$FreeBSD$} . "<br />\n";
    print qq{General questions about FreeBSD ports should be sent to }
      . qq{<a href="mailto:$mailtoList">}
      . qq{<i>$mailtoList</i></a><br />\n};
    print &last_update_message;
    print qq{<hr noshade="noshade" />\n<p />\n};
}

sub check_input {
    if ($query) {
        $stype = "all" if !$stype;
        if (
            !(
                   $stype eq "name"
                || $stype eq "text"
                || $stype eq "maintainer"
                || $stype eq "requires"
                || $stype eq "all"
            )
          )
        {
            &warn(
"unknown search type ``$type'', use `all', `text', `name', 'requires', or `maintainer'\n"
            );
            &exit(0);
        }
        else {
            return;
        }
    }
}

sub faq {
    print qq{<H1>FreeBSD Ports Search FAQ</h1>

<h2>Keywords</h2>
<dl>
<dt><b>Description</b><dd>A more detailed description.
<dt><b>Changes</b><dd>Read the latest changes.
</dl>

<h2>Misc</h2>

<p>
The script ports.cgi use the file
<a href="$hsty_base/ports/$ports_database.bz2">$ports_database</a>
as database for it's operations. $ports_database is updated automatically every
two hours.</p>

<p>
You may also search the
<a href="https://www.FreeBSD.org/cgi/man.cgi?manpath=FreeBSD+Ports">ports manual pages</a>.</p>

<p>
<a href="$script_name">Back to the search engine</a></p>
<hr noshade="noshade" />
};
}

#
# Main
#

&init_variables;
$query_string = &env('QUERY_STRING');
$path_info    = &env('PATH_INFO');
&decode_form( $query_string, *form );

$section     = $form{'sektion'};
$section     = 'all' if ( !$section );
$query       = $form{'query'};
$stype       = $form{'stype'};
$script_name = &env('SCRIPT_NAME');

if ( $path_info eq "/source" ) {

    # XXX
    print "Content-type: text/plain\n\n";
    open( R, $0 ) || do { print "ick!\n"; &exit; };
    while (<R>) { print }
    close R;
    &exit;
}

if ( $stype eq "faq" ) {
    print &short_html_header( "FreeBSD Ports Search FAQ", 1 );
    &faq;
    &footer;
    print &html_footer;
    &exit(0);
}

print &html_header( "FreeBSD Ports Search", 1 );

# allow `/ports.cgi?netscape' where 'netscape' is the query port to search
# this make links to this script shorter
if ( !$query && $query_string =~ /^([^=&]+)$/ ) {
    $query = $1;
}

# automatically read collections, need only 0.2 sec on a pentium
@sec = &readcoll;

$query =~ s/"/ /g;
$query =~ s/^\s+//;
$query =~ s/\s+$//;
&forms;

if ( $query_string eq "" || !$query ) {
    &footer;
    print &html_footer;
    &exit(0);
}

&check_input;
$counter = 0;

# search
if ($query) {
    &readindex( *today, *msec );
    $query =~ s/([^\w\^])/\\$1/g;
    &search_ports;
}

if ( !$counter ) {
    print "Sorry, nothing found.\n";
    print qq{You may look for other }
      . qq{<a href="/search/search.html">FreeBSD Search Services</a>.\n};
}
else {
    print "</dl>\n";
}

print qq{<hr noshade="noshade" />\n};
&footer;
print &html_footer;
