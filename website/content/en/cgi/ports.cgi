#!/usr/bin/perl -T
#
# Copyright (c) 1996-2024 Wolfram Schneider <wosch@FreeBSD.ORG>
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
# ports.cgi - search engine for FreeBSD ports

use POSIX qw(strftime);
use Time::Local;

require "./cgi-style.pl";
$t_style = qq`
<style type="text/css">
h3 { font-size: 1.2em; border-bottom: thin solid black; }
span.footer_links { font-size: small; }

form#ports > input[name='query'] { text-align: center; }
form#ports > input[name='query'] { width: 14em; }
form#ports > input, form#ports > button, form#ports > select { font-size: large; }
</style>

<link rel="search" type="application/opensearchdescription+xml" href="https://www.freebsd.org/opensearch/ports.xml" title="FreeBSD Ports" />
`;

# No unlimited result set. A HTML page with 1000 results can be 10MB big.
my $max_hits = 1000;
my $max_hits_default = 250;
my $max;

my $debug = 1;

sub init_variables {
    $localPrefix = '/usr/ports';    # ports prefix

    # Directory of the up-to-date INDEX*
    $portsDatabaseHeadDir = "/usr/local/www/ports";

    # Ports database file to use
    if ( -f "$portsDatabaseHeadDir/INDEX-14" ) {
        $ports_database = 'INDEX-14';
    }
    elsif ( -f "$portsDatabaseHeadDir/INDEX-13" ) {
        $ports_database = 'INDEX-13';
    }
    else {
        $ports_database = 'INDEX';
    }

    # URL of ports tree for browsing
    $remotePrefixFtp = 'ports';

    # Web interface for the Ports tree
    $remotePrefixRepo = 'https://cgit.FreeBSD.org/ports';

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
    return "<p>Last database update: @{[ &last_update ]}</p>\n";
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
        $var{"$tmp[0]"} = $_;
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
              . qq{<a href="$remotePrefixRepo/tree/$1">Category $1</a>}
              . "</h3>\n<dl>\n";
            $out_sec = $1;
        }
    }

    $counter++;
    $pathB        = $path;
    $pathB =~ s/^$localPrefix/ports/o;

    $path         =~ s/^$localPrefix/$remotePrefixFtp/o;
    $descfile =~ s/^$localPrefix/$remotePrefixFtp/o;
    $version = &encode_url($version);

    #$version =~ s/[\+,]/X/g;

    local ($l) = $path;
    $l =~ s%^$remotePrefixFtp%$remotePrefixRepo/log%o;
    local ($t) = $path;
    $t =~ s%^$remotePrefixFtp%$remotePrefixRepo/tree%o;
    $descfile =~ s%^$remotePrefixFtp%$remotePrefixRepo/plain%o;

    print
      qq{<dt><b><a name="$version"></a><a href="$t">$version</a></b></dt>\n};
    print qq{<dd>}, &escapeHTML($comment), qq{<br />\n};

    print qq[<a href="$descfile?revision=HEAD">Description</a> <b>:</b>\n];

    print qq[<a href="$l">Changes</a> <br />\n];

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
            print qq{<a href="$remotePrefixRepo/tree/$_">$_</a> }
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
        next if $counter >= $max;

        @a    = split( /\|/, $today{$key} );
        $name = $a[0];                         #$name =~ s/(\W)/\\$1/g;
        $text = $a[3];                         #$text =~ s/(\W)/\\$1/g;

        if ( $section ne "all" ) {
            next if $a[6] !~ /\b$section\b/;
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
The FreeBSD Ports and Packages Collection offers a simple way for users and administrators to install applications.
</p>
};

    print qq{<p>
"Package Name" searches for the name of a port or distribution.
"Description" searches case-insensitive in a short comment about the port.
"All" searches case-insensitive for the package name and in the
description about the port.
</p>

<form id="ports" method="get" action="$script_name">
Search for:
<input name="query" value="$query" type="text" autocapitalize="none" autofocus />
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

    print qq{</select>
<input type="submit" value="Submit" />
</form>
<br/>
@{[ &footer_links ]}
<hr noshade="noshade" />
};

}

sub footer {

print <<EOF;
<span class="footer_links">
  <img align="right" src="$hsty_base/gifs/powerlogo.gif" alt="Powered by FreeBSD"/>
  &copy; 1996-2024 by Wolfram Schneider. All rights reserved.<br/>

  General questions about FreeBSD ports should be sent to 
  <a href="mailto:$mailtoList"><i>$mailtoList</i></a><br/>

  @{[ &last_update_message ]}
</span>
<hr noshade="noshade" />
<p/>

EOF
}

sub check_query {
    my ($query, $sourceid) = @_;

    $query =~ s/"/ /g;
    $query =~ s/^\s+//;
    $query =~ s/\s+$//;

    # XXX: Firefox opensearch autocomplete workarounds
    if ($sourceid eq 'opensearch') {
	# remove space before a dot 
	$query =~ s/ \././g;
	# remove space between double colon
	$query =~ s/: :/::/g;
    }

    return $query;
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
"unknown search type ``$stype'', use `all', `text', `name', 'requires', or `maintainer'\n"
            );
            &exit(0);
        }
    }

    $max = int($max);
    if ($max <= 0 || $max > $max_hits) {
        warn "reset max=$max to $max_hits_default\n";
        $max = $max_hits_default;
    }
}

sub faq {
    print <<EOF
<br/>
<h1>FreeBSD Ports Search Help</h1>

<h2>Keywords</h2>
<dl>
  <dt><b>Description</b></dt>
  <dd>A more detailed description (text).</dd>

  <dt><b>Changes</b></dt>
  <dd>Read the latest changes via the git repo</dd>
</dl>

<h2>Documentation</h2>
<p>
Handbook: <a href="https://docs.freebsd.org/en/books/handbook/ports/#ports-using">Using the Ports Collection</a>
</p>

<p>
You may also search the
<a href="https://man.FreeBSD.org/cgi/man.cgi?manpath=freebsd-ports">ports manual pages</a>.
</p>

<h2>Updates</h2>

<p>
The script ports.cgi use the file
<a href="https://download.FreeBSD.org/ports/index/$ports_database.xz">$ports_database</a>
as database for its operations. $ports_database is updated automatically every
two hours.
</p>


@{[ &footer_links ]}
<hr noshade="noshade" />
EOF
}

sub footer_links {
    return <<EOF;
<span class="footer_links">
  <a href="$script_name">home</a>
  @{[ $stype eq "faq" ? "" : qq, | <a href="$script_name?stype=faq">help</a>, ]}
</span>
EOF
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
$sourceid    = $form{'sourceid'} // "";
$script_name = &env('SCRIPT_NAME');
$max         = $form{'max'} // $max_hits_default;

if ( $path_info eq "/source" ) {

    # XXX
    print "Content-type: text/plain\n\n";
    open( R, $0 ) || do { print "ick!\n"; &exit; };
    while (<R>) { print }
    close R;
    &exit;
}

if ( $stype eq "faq" ) {
    print &short_html_header( "FreeBSD Ports Search Help", 1 );
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

$query = &check_query($query, $sourceid);
&forms;

if ( $query_string eq "" || !$query ) {
    &footer;
    print &html_footer;
    &exit(0);
}

&check_input;
$counter = 0;

# no prefix search for requires supported yet
$query =~ s/^\^// if $stype eq 'requires'; 

# quote non characters
$query =~ s/([^\w\^])/\\$1/g;

# search
if ($query) {
    &readindex( *today, *msec );
    &search_ports;
}

if ( !$counter ) {
    print <<EOF;
<p>
Sorry, nothing found.
You may look for other <a href="https://www.freebsd.org/search/">FreeBSD Search Services</a>
</p>
EOF
}

else {
    print "</dl>\n";
    my $counter_message = $counter;
    if ($counter >= $max) {
        $counter_message .= " (max hit limit reached)";
        warn "$counter_message: query=$query stype=$stype section=$section\n" if $debug >= 1;
    }
    print "<p>Number of hits: $counter_message\n</p>\n";
    print &footer_links;
}

print qq{<hr noshade="noshade" />\n};
&footer;
print &html_footer;
