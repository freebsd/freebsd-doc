#!/usr/bin/perl -w
#
# $FreeBSD$
#
# Script for parsing the xearth committers markers file and generating a
# heat map with countries of the world colored according to how many committers
# reside there.
#
# Creates an image of the following form :
# http://chart.apis.google.com/chart?chco=ffffff,ffbe38,600000&chd=s:BEICCFKEDBXICMMCBDBFPDBBBBBEDBBBBBQDBBJE9B&chf=bg,s,EAF7FE&chld=ARATAUBEBGBRCACHCNCZDEDKESFRGBGRHUIEINITJPKRKZMNMOMXMYNLNONZPEPLPTRORUSESISKTWUAUSZA&chs=440x220&cht=t&chtm=world
# 
# See http://code.google.com/apis/chart/
#
# Murray Stokely, March 30, 2008
#

use strict;

my %country_iso3166 = (
    'western australia', 'AU',
    'usa', 'US',
    'poland', 'PL',
    'canada', 'CA',
    'ukraine', 'UA',
    'sweden', 'SE',
    'uk', 'GB',
    'russia', 'RU',
    'bulgaria', 'BG',
    'switzerland', 'CH',
    'czech republic', 'CZ',
    'denmark', 'DK',
    'mexico', 'MX',
    'portugal', 'PT',
    'ca usa', 'US',
    'romania', 'RO',
    'india', 'IN',
    'malaysia', 'MY',
    'the netherlands', 'NL',
    'greece', 'GR',
    'spain', 'ES',
    'japan', 'JP',
    'taiwan', 'TW',
    'austria', 'AT',
    'brazil', 'BR',
    'hungary', 'HU',
    'south africa', 'ZA',
    'italy', 'IT',
    'belgium', 'BE',
    'france', 'FR',
    'mongolia', 'MN',
    'united kingdom', 'GB',
    'slovakia', 'SK',
    'peru', 'PE',
    'ireland', 'IE',
    'south korea', 'KR',
    'norway', 'NO',
    'australia', 'AU',
    'new zealand', 'NZ',
    'slovenia', 'SI',
    'macau sar', 'MO',
    'argentina', 'AR',
    'china', 'CN',
    'germany', 'DE',
    'kazakhstan', 'KZ',
    );

sub printUsage() {
    print STDERR "Usage : heatmap.pl <xearth markers file>\n\n";
}

# This is an encoding of data values from 0 to 61 into [A-Za-z0-9].
# See http://code.google.com/apis/chart/#simple_values
sub simple_encode($) {
    my $num = int($_[0]);
    if ($num >= 0) {
        if ($num <=25) {
            return chr(ord('A')+$num);
	} elsif ($num<=51) {
            return chr(ord('a')+$num);
        } elsif ($num<=61) {
            return chr(ord('0') + $num - 52);
	} else {
	    die "Can not simple encode $num!";
	}
    }
}

if ($#ARGV < 0) {
    printUsage();
    exit;
}

open(FIN, "$ARGV[0]") || die "Could not open $ARGV[0] : $!";

# ISO country code => number of committers from there.
my %country_hash;
foreach my $line (<FIN>) {
    chomp $line;
# Match a line like this and extract number of usernames in quotes
# and human-readable country
# 37.40,         -122.07,        "murray"			# (CORE) Mountain View, CA, USA
    if ($line =~ m/\s*\d+\.\d+,?\s+-?\d+\.\d+,?\s*"([^"]+)"[^#]*#(.*)$/g) {
	my @people = split(/\s*,\s*/, $1);
	my $rawcountry = $2;
	my $len = 0;
	foreach my $person (@people) {
	    $len++ if ($person =~ m/\S+/);
	}
	if ($len == 0) {
	    print STDERR "Couldn't parse: $line\n";
	    next;
	}
	my @components = split(/,/, $rawcountry);
	my $country_name = $components[$#components];
	$country_name =~ s/^\s*//;
	$country_name =~ s/\s*$//;
	if ($country_iso3166{lc($country_name)}) {
	    $country_hash{$country_iso3166{lc($country_name)}} += $len;
	} else {
	    print STDERR "Unknown ISO code for country: $country_name\n";
	}
    }
}
close(FIN);

my %worldmap;
# Parameters for the Charts API.
$worldmap{'chs'} = '440x220';
$worldmap{'chco'} = 'ffffff,ffbe38,600000';
$worldmap{'cht'} = 't';
$worldmap{'chtm'} = 'world';
$worldmap{'chld'} = '';
$worldmap{'chd'} = 's:';
$worldmap{'chf'} = 'bg,s,EAF7FE';

# country_hash - country name -> committers from there
# Find the largest number of committers in one country, so we can normalize
my $max_ppl = (reverse sort {$a <=> $b} values %country_hash)[0];
my %country_pct;

# country_pct - iso countr code -> pct committers from there.
foreach my $country (keys %country_hash) {
    $country_pct{$country} = simple_encode(sprintf "%d", (((60 * $country_hash{$country}) / $max_ppl) + 1));
}

foreach my $key (sort (keys %country_pct)) {
    $worldmap{'chld'} .= $key;
    $worldmap{'chd'} .= $country_pct{$key};
}

my $CHART_URL = 'http://chart.apis.google.com/chart?';
foreach my $key (sort (keys %worldmap)) {
    $CHART_URL .= sprintf '%s=%s&', $key, $worldmap{$key};
}
chop $CHART_URL;
print $CHART_URL;
