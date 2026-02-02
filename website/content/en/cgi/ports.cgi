#!/usr/local/bin/perl -T
#
# SPDX-License-Identifier: BSD-2-Clause
# Copyright (c) 1996-2026 Wolfram Schneider <wosch@FreeBSD.ORG>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
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
use JSON;

use warnings;

our $hsty_base;
require "./cgi-style.pl";

our $t_style = qq`
<style type="text/css">
h3 { font-size: 1.20em; border-bottom: thin solid black; max-width: 42em; }

form#ports > input[name='query'] { text-align: center; }
form#ports > input[name='query'] { width: 20em; }
form#ports > input, form#ports > button, form#ports > select { font-size: large; }

span.footer_links { font-size: small; }
span.space { font-size: xx-small; }

p#section_links, div#footer { max-width: 50em; }
hr { margin-left: 0em; max-width: 50em; }
a:link  { text-decoration:none; }
a:hover { text-decoration:underline; }
table, th, td { border: 1px solid black; border-collapse: collapse; }
th, td { padding-left: 0.5em; padding-right: 0.5em; }

span#noscript { color: red; font-size: normal; font-weight: bold; }
</style>

<link rel="search" type="application/opensearchdescription+xml" href="https://www.freebsd.org/opensearch/ports.xml" title="FreeBSD Ports" />
`;

my $no_javascript_warning = <<'EOF';
<span id="noscript">
<noscript>
<p>Please enable JavaScript in your browser for sorting columns. Thanks!</p>
</noscript>
</span>
EOF

my $pkg_javascript = <<'EOF';

<script type="text/javascript">
let sort_directions = {}; // remember asc/desc per column

function sort_table(column_index) {
    const table = document.getElementById("pkg-result");
    const tbody = table.tBodies[0];
    const rows = Array.from(tbody.rows);

    // toggle direction
    const current = sort_directions[column_index] || "asc";
    const direction = current === "asc" ? "desc" : "asc";
    sort_directions[column_index] = direction;

    rows.sort((a, b) => {
        const a_text = a.cells[column_index].textContent.trim();
        const b_text = b.cells[column_index].textContent.trim();

        cmp = a_text.localeCompare(b_text, undefined, {
            numeric: true,
            sensitivity: "base"
        });

        return direction === "asc" ? cmp : -cmp;
    });

    // re-append in sorted order
    rows.forEach(row => tbody.appendChild(row));
}

// always sort by release
document.addEventListener("DOMContentLoaded", function() { sort_table(0) });
</script>

EOF

# No unlimited result set. A HTML page with 1000 results can be 10MB big.
my $max_hits         = 1000;
my $max_hits_default = 250;
my $max_hits_pkg     = 400;
my $max;

my $debug = 1;

# feature flags
my $enable_packages_link = 1;

sub init_variables {
    $localPrefix = '/usr/ports';    # ports prefix

    # Directory of the up-to-date INDEX*
    $portsDatabaseHeadDir = "/usr/local/www/ports";

    # Ports database file to use
    if ( -f "$portsDatabaseHeadDir/INDEX-15" ) {
        $ports_database = 'INDEX-15';
    }
    elsif ( -f "$portsDatabaseHeadDir/INDEX-14" ) {
        $ports_database = 'INDEX-14';
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
    $mailtoList = 'freebsd-ports@FreeBSD.org';

    # use mailto:email?subject
    $mailtoAdvanced = 'yes';

    # the URL if you click at the E-Mail address (see below)
    $mailtoURL = "mailto:$mailto" if !$mailtoURL;

    # security
    $ENV{'PATH'} = '/bin:/usr/bin';
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
    return "Last database update: @{[ &last_update ]}\n";
}

sub dec {
    local ($_) = @_;

    s/\+/ /g;                        # '+'   -> space
    s/%(..)/pack("c",hex($1))/ge;    # '%ab' -> char ab

    return ($_);
}

sub decode_form {
    local ( $form, *data ) = @_;

    foreach my $line ( split( /&/, $form ) ) {
        my ( $key, $val ) = split( /=/, $line, 2 );
        $val = "" if !defined $val;

        $val =~ s/\+/ /g;                                 # + -> space
        $key =~ s/\+/ /g;                                 # + -> space
        $val =~ s/%([\da-f]{1,2})/pack(C,hex($1))/eig;    # undo % escapes
        $key =~ s/%([\da-f]{1,2})/pack(C,hex($1))/eig;    # undo % escapes
        $data{$key} = $val;
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
    my (
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

    $rdepends //= "";
    $counter++;
    $pathB = $path;
    my $port_path = $path;
    $port_path =~ s,/usr/ports/,,;

    $pathB =~ s/^$localPrefix/ports/o;

    $path     =~ s/^$localPrefix/$remotePrefixFtp/o;
    $descfile =~ s/^$localPrefix/$remotePrefixFtp/o;
    $version = &encode_url($version);

    #$version =~ s/[\+,]/X/g;

    local ($l) = $path;
    $l =~ s%^$remotePrefixFtp%$remotePrefixRepo/log%o;
    local ($t) = $path;
    $t        =~ s%^$remotePrefixFtp%$remotePrefixRepo/tree%o;
    $descfile =~ s%^$remotePrefixFtp%$remotePrefixRepo/plain%o;

    print
      qq{<dt><b><a name="$version"></a><a href="$t">$version</a></b></dt>\n};
    print qq{<dd>}, &escapeHTML($comment), qq{<br />\n};

    print qq[<a href="$descfile?revision=HEAD">Description</a>\n];

    print qq[<b>:</b> <a href="$l">Changes</a>\n];
    print qq[<b>:</b> <a href="?stype=pkg&amp;query=], escapeHTML($port_path),
      qq[">Packages</a>\n]
      if $enable_packages_link;

    print qq[<br />\n];

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
sub package_links {
    my $q      = shift;
    my $filter = shift;

    my @system = (
        qw[env packagesize_dir=/usr/local/www/ports/packages /usr/local/www/bin/pkg-search.sh],
    );
    push @system, $q;

    if ( !open( PKG_IN, '-|' ) ) {
        if ( !exec(@system) ) {
            die join( " ", @system ) . " $!\n";
        }
    }

    binmode( PKG_IN, ":bytes" );

    my $hash;
    my $counter = 0;
    while (<PKG_IN>) {
        chomp;
        next if !(m,^(.*?)-(.*?)\.yaml:(.*),);

        my $arch     = $1;
        my $rel      = $1;
        my $snapshot = $2;
        my $path     = "$1/$2";
        my $perl     = decode_json($3);

        $arch =~ s,.*%3A,,;
        if ( $rel =~ /^FreeBSD%3A(\d+)%3A/ ) {
            $rel = ":$1:";
        }

        if ( $. == 1 ) {
            print qq[<h2>$perl->{"name"}: ], escapeHTML( $perl->{"comment"} ),
              qq[</h2>\n];

            print qq[homepage: <a href="], $perl->{"www"},
              qq[">] . $perl->{"www"} . "</a><br/>\n";
            print qq[FreeBSD ports git: <a href="$remotePrefixRepo/tree/]
              . $perl->{"origin"} . qq[">]
              . $perl->{"origin"}
              . qq[</a><br/>\n];
            print qq[maintainer: ], $perl->{"maintainer"}, "<br/>\n";

            print qq[<h3>Description</h3>\n];
            print "<pre>", escapeHTML( $perl->{"desc"} ), "</pre>\n";
            print qq[<h3>Download packages in *.pkg format</h3>\n];

            print $no_javascript_warning, $pkg_javascript;
            print qq{<table id="pkg-result">\n};
            print qq{<thead>\n};
            print qq{<tr>\n};
            print
qq{ <th onclick="sort_table(0)" title="click to sort asc/desc by release">Release &lt;&gt;</th>\n};
            print
qq{ <th onclick="sort_table(1)" title="click to sort asc/desc by version">Version &lt;&gt;</th>\n};
            print
qq{ <th onclick="sort_table(2)" title="click to sort asc/desc by build time">Build Time &lt;&gt;</th>\n};
            print qq{</tr>\n};
            print qq{</thead>\n};
            print qq{<tbody>\n};
        }

        my $release  = $perl->{"abi"} . " " . $snapshot;
        my $time     = $perl->{"annotations"}->{"build_timestamp"} // "";
        my $version  = $perl->{"version"};
        my $repopath = $perl->{"repopath"};
        my $flavor   = $perl->{"annotations"}->{"flavor"} // "";

        # show flavor
        if ($flavor) {
            $release = $release . " (" . $flavor . ")";
        }

        $time =~ s/\+\d{4}$//;
        $time =~ s/T(\d\d):(\d\d):(\d\d)$/ $1:$2/;

        my $pkg_opt = $repopath;
        $pkg_opt =~ s,.*/,,;
        $pkg_opt =~ s,\~.*,,;

        if ($filter) {
            next
              if index( $release, $filter ) < 0
              && index( $pkg_opt, $filter ) < 0
              && index( $version, $filter ) < 0
              && index( $time,    $filter ) < 0
              && index( $flavor,  $filter ) < 0;
        }

        next if $counter >= $max;
        $counter++;

        my $info =
          $time
          ? qq[pkg: $pkg_opt\n size: $perl->{"pkgsize"} bytes\n git_hash: $perl->{"annotations"}->{"port_git_hash"}\n ]
          . qq[ports_top_git_hash: $perl->{"annotations"}->{"ports_top_git_hash"}\nchecksum: $perl->{"sum"}\n]
          : "";

        print "<tr>\n";
        print "<td>", qq[<a href="https://pkg.freebsd.org/], escapeHTML($path),
          "/", escapeHTML($repopath), qq[">$release</a></td>\n];
        print "<td>",                       $version, "</td>\n";
        print qq[<td><span title="$info">], $time,    "</span></td>\n";

        print "</tr>\n";

        $hash->{'version'}->{$version}++;
        $hash->{'arch'}->{$arch}++;
        $hash->{'release'}->{$rel}++;
        $hash->{'flavor'}->{$flavor}++ if $flavor ne "";
        $hash->{'snapshot'}->{$snapshot}++
          if $snapshot eq 'latest' || $snapshot eq 'quarterly';
    }

    if ( $counter || $. >= 1 ) {
        print <<EOF;
  </tbody>
</table>
<br/>
EOF

        foreach my $key ( sort keys %$hash ) {
            print "<b>", escapeHTML($key), "</b>: \n";
            my $flag = 0;
            foreach my $k ( sort keys %{ $hash->{$key} } ) {
                print " - " if $flag++;
                print qq[<a title="counter=], $hash->{$key}->{$k},
                  qq[" href="?stype=pkg&amp;query=], escapeHTML($q),
                  qq[&amp;pkg_filter=], escapeHTML($k), qq[">], escapeHTML($k),
                  "</a>\n";
            }
            print "<br/>\n";
        }

        if ( $filter ne "" ) {
            print escapeHTML(">>>"), qq[ <a href="?stype=pkg&amp;query=],
              escapeHTML($q),
              qq[">reset filter</a> ], escapeHTML("<<<"), "\n";
        }

    }

    return $counter;
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
        elsif (
            $stype eq 'requires'
            && ( defined $a[7] && $a[7] =~ /$query/io
                || ( defined $a[8] && $a[8] =~ /$query/io ) )
          )
        {
            &out( $today{$key} );
        }

    }
}

sub forms {

    print qq{
<form id="ports" method="get" action="$script_name">
<input name="query" value="$query" type="text" autocapitalize="none" autofocus />
<select name="stype">
};

    local (%d);
    %d = (
        'name',       'Package Name', 'all',  'All',
        'maintainer', 'Maintainer',   'text', 'Description',
        'requires',   'Requires',
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

sub check_query {
    my ( $query, $sourceid ) = @_;

    $query =~ s/"/ /g;
    $query =~ s/^\s+//;
    $query =~ s/\s+$//;

    # XXX: Firefox opensearch autocomplete workarounds
    if ( $sourceid eq 'opensearch' ) {

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
                || $stype eq "pkg"
            )
          )
        {
            print
"unknown search type, use `all', `text', `name', 'requires', or `maintainer'\n";
            warn "unknown search type ``", escapeHTML($stype),
              "'', use `all', `text', `name', 'requires', or `maintainer'\n"
              if $debug >= 1;
            &exit(0);
        }
    }

    $max = int($max);
    if ( $max <= 0 || $max > $max_hits ) {
        my $old_max = $max;
        $max = $enable_packages_link
          && $stype eq 'pkg' ? $max_hits_pkg : $max_hits_default;
        warn "reset max=$old_max to $max\n";
    }
}

sub help {
    print <<EOF;
<br/>
<h1>FreeBSD Ports Search Help</h1>

<p>
The FreeBSD Ports and Packages Collection offers a simple way for
users and administrators to install applications.
</p>

<p>
<b>Package Name</b> searches for the name of a port or distribution.
<b>Description</b> searches case-insensitive in a short comment about the port.
<b>All</b> searches case-insensitive for the package name and in the
description about the port.
<b>Maintainer</b> searches for the email address of the port maintainer.
<b>Requires</b> searches for ports which depends on this port.

</p>

<h2>External Links</h2>

<dl>
  <dt><b>Description</b></dt>
  <dd>A more detailed description (text) via the git repo</dd>

  <dt><b>Changes</b></dt>
  <dd>Read the latest changes via the git repo</dd>

  <dt><b>Packages</b></dt>
  <dd>List of available packages for all supported releases and branches</dd>
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

<p>
@{[ &last_update_message ]}
</p>

<h2>Copyright</h2>
<pre>
Copyright (c) 1996-2026 <a href="https://wolfram.schneider.org">Wolfram Schneider</a> &lt;wosch\@FreeBSD.org&gt;
</pre>
<p/>

<h2>Misc</h2>
<ul>
<li><a href="https://forums.freebsd.org/categories/ports-and-packages.21/">FreeBSD Forums: Ports and Packages</a></li>
<li><a href="https://www.freshports.org/">FreshPorts -- The Place For Ports - Most recent commits</a></li>
</ul>

<h2>Questions</h2>
<p>
General questions about FreeBSD ports should be sent to 
the <a href="https://lists.freebsd.org/subscription/freebsd-ports">$mailtoList</a> mailing list.
</p>

@{[ &footer_links ]}
<hr noshade="noshade" />
EOF
}

sub footer_links {
    return <<EOF;
<span class="footer_links">
  <a href="$script_name">home</a>
  @{[ $stype eq "help" ? "" : qq, | <a href="$script_name?stype=help">help</a>, ]}
</span>
EOF
}

#
# Main
#

&init_variables;
$query_string = &env('QUERY_STRING');
$path_info    = &env('PATH_INFO') // "";
&decode_form( $query_string, *form );

$section     = $form{'sektion'};
$section     = 'all' if ( !$section );
$query       = $form{'query'}      // "";
$stype       = $form{'stype'}      // "";
$sourceid    = $form{'sourceid'}   // "";
$pkg_filter  = $form{'pkg_filter'} // "";
$script_name = &env('SCRIPT_NAME');
$max         = $form{'max'} // ( $enable_packages_link
      && $stype eq 'pkg' ? $max_hits_pkg : $max_hits_default );

if ( $path_info eq "/source" ) {
    print "Content-type: text/plain\n\n";
    open( R, $0 ) || do { warn "open $0: $!!\n"; &exit; };
    while (<R>) { print }
    close R;
    &exit;
}

if ( $stype eq "help" ) {
    print &short_html_header( "FreeBSD Ports Search Help", 1 );
    &help;
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

$query = &check_query( $query, $sourceid );

# no search menu for packages links
if ( $enable_packages_link && $stype eq 'pkg' ) {
}
else {
    &forms;
}

if ( $query_string eq "" || !$query ) {
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
    my $q = "";
    if ( $query =~ m,^([A-Za-z0-9\-]+)(\\/)([A-Za-z0-9\-_\+\.\\]+)$, ) {
        $q = "$1$2$3";
        $q =~ s,\\,,g;
    }

    if ( $q ne "" && $enable_packages_link && $stype eq 'pkg' ) {
        $counter = &package_links( $q, $pkg_filter );
    }
    else {
        &readindex( *today, *msec );
        &search_ports;
    }
}

if ( !$counter ) {
    print <<EOF;
<p>
Sorry, nothing found.
You may look for other <a href="https://www.freebsd.org/search/">FreeBSD Search Services</a>
</p>
@{[ &footer_links ]}
EOF
}

if ($counter) {
    print "</dl>\n" if $stype ne 'pkg';
    my $counter_message = $counter;
    if ( $counter >= $max ) {
        $counter_message .= " (max hit limit reached)";
        warn "$counter_message: query=$query stype=$stype section=$section\n"
          if $debug >= 1;
    }
    print "<p>Number of results: $counter_message\n</p>\n";
    print &footer_links;
}

print qq{<hr noshade="noshade" />\n};
print &html_footer;
