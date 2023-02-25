#!/usr/local/bin/perl -T
# Copyright (c) 2009-2023 Wolfram Schneider, https://wolfram.schneider.org
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
# man-autocomplete.cgi - autocomplete/suggestion service for FreeBSD manpages
#
# expected run time on a modern CPU:
#  FreeBSD Release: 12ms for perl cgi script and 5ms for GNU grep => 17ms
#  FreeBSD Release + Ports: 15ms for perl cgi script and 10ms for GNU grep => 25ms
#

use lib qw(. ../../lib);
use MyCgiSimple;

use strict;
use warnings;    # 3% slower

$ENV{PATH}   = "/usr/local/bin:/bin:/usr/bin";
$ENV{'LANG'} = 'C';

my $debug = 2;
binmode( \*STDIN,  ":bytes" );
binmode( \*STDOUT, ":bytes" );
binmode( \*STDERR, ":bytes" );

sub suggestion {
    my %args = @_;

    my $database = $args{'database'};
    my $icase    = $args{'icase'};
    my $manpath  = $args{'manpath'};
    my $query    = $args{'query'};
    my $limit    = $args{'limit'};

    if ( !-e $database ) {
        warn "$!: $database\n";
        return;
    }

    # GNU grep, ripgrep, agrep, BSD grep etc.
    my @command = ('grep');

    # read more data for prefix match <=> sub-string match
    my $limit_factor = 8;

    push @command, ( '-m', $limit * $limit_factor );
    push @command, '-i' if $icase == 1;
    push @command, ( '--', $query, $database );

    warn join( " ", @command ), "\n" if $debug >= 2;
    if ( !open( IN, '-|' ) ) {
        exec @command;
        die "@command: $! :: $?\n";
    }
    binmode( \*IN, ":bytes" );

    my @data = ();
    while (<IN>) {
        chomp;
        s,["\s/],,g;

        # XXX: workaround for Firefox which ignores entries with "::" or "." inside a string
        # Note: we have to undo this in man.cgi
        s/::/: :/g;
        s/\./ \./g;
        push @data, $_;

        last if scalar(@data) >= $limit * $limit_factor;
    }

    close IN;

    # a sorted list, but prefix matches first
    # e.g. 'sort(1)' is before 'alphasort(3) if you searched for 'sor'
    my $lc_query   = $icase ? lc($query) : $query;
    my @prefix     = grep { index( lc($_), $lc_query ) == 0 } @data;
    my @non_prefix = grep { index( lc($_), $lc_query ) != 0 } @data;

    # prefix first & real limit
    @data = ( @prefix, @non_prefix );
    @data = splice( @data, 0, $limit );

    warn "data: ", join( " ", @data ), "\n" if $debug >= 2;
    return @data;
}

sub escapeQuote {
    my $string = shift;

    $string =~ s/"/\\"/g;

    return $string;
}

# create devbridge autocomplete response JSON object
sub devbridge_autocomplete {
    my $query      = shift;
    my $suggestion = shift;

    my @suggestion = @$suggestion;

    print qq/{ query:"/, escapeQuote($query), qq/", suggestions:[/;
    print '"', join( '","', map { escapeQuote($_) } @suggestion ), '"'
      if scalar(@suggestion) > 0;
    print "] }\n";

    warn "query '$query', suggestions: ", join ", ", @suggestion, "\n"
      if $debug >= 1;
}

# create opensearch autocomplete response JSON object
sub opensearch_autocomplete {
    my $query      = shift;
    my $suggestion = shift;

    my @suggestion = @$suggestion;

    print '["', escapeQuote($query), '", [';

    print qq{"}, join( '","', map { escapeQuote($_) } @suggestion ), qq{"}
      if scalar(@suggestion) > 0;
    print "]]\n";

    warn "query '$query', suggestions: ", join ", ", @suggestion, "\n"
      if $debug >= 1;
}

######################################################################
# param alias: query, q:   search query
#              manpath, m: release or release + ports
#              icase,i :   case sensitive
#              debug, d:   debug level

my $max_suggestions = 24;
my $database_freebsd_release =
  '/usr/local/www/bsddoc/man/etc/autocomplete/freebsd-release.txt';
my $database_freebsd_release_ports =
  '/usr/local/www/bsddoc/man/etc/autocomplete/freebsd-release-ports.txt';

my $q = new MyCgiSimple;

my $test_street = "kurz";

my $query   = $q->param('query')   // $q->param('q') // $test_street;
my $manpath = $q->param('manpath') // $q->param('m') // "";
my $d       = $q->param('debug')   // $q->param('d') // $debug;

# we always use case insensive search for autocomplete
my $icase = $q->param('icase') // $q->param('i') // 1;

$query   = ( $query   =~ /^(.+)$/       ? $1 : "" );
$manpath = ( $manpath =~ /^([a-z\-]+)$/ ? $1 : "" );
$icase   = ( $icase   =~ /^([01])$/     ? $1 : 0 );
$debug   = ( $d       =~ /^([0-3])$/    ? $1 : $debug );

# not part of a filename
$query =~ s,["\s'/]+,,;

my $database =
    $manpath eq 'freebsd-release-ports'
  ? $database_freebsd_release_ports
  : $database_freebsd_release;

my $expire = $debug >= 2 ? '+1s' : '+1h';
print $q->header(
    -type    => 'text/javascript',
    -charset => 'utf-8',
    -expires => $expire,
);

my @suggestion = ();
if ( length($query) >= 2 ) {
    @suggestion = &suggestion(
        'database' => $database,
        'limit'    => $max_suggestions,
        'query'    => $query,
        'icase'    => $icase,
        'manpath'  => $manpath,
    );
}

# ns=devbridge, for jQuery devbridge plugin
# &devbridge_autocomplete( $query, \@suggestion );

# ns=opensearch (Firefox etc.)
&opensearch_autocomplete( $query, \@suggestion );

#EOF
