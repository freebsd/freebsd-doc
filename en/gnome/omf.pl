#!/usr/bin/perl

#
# omf.pl - a script to add proper OMF handling to port PLISTs
# usage: omf.pl [plist] [plist] [...]
#
# $Id: omf.pl,v 1.1 2004-06-27 21:41:07 marcus Exp $
#

use strict;

if (scalar(@ARGV) == 0) {

        # If no arguments were given, assume we're using the pkg-plist in the
        # current directory.
        push @ARGV, "./pkg-plist";
}

foreach (@ARGV) {
        unless (open(INFILE, $_)) {
                warn "Unable to open $_: $!\n";
                next;
        }

        my @file = <INFILE>;

        close(INFILE);

        my @omfs;
        for (my $i = 0 ; $i < scalar(@file) ; $i++) {
                next unless $file[$i] =~ /\.omf\n$/;
                my $omf = $file[$i];
                chomp $omf;
                my $install =
                    "\@exec scrollkeeper-install -q \%D/$omf 2>/dev/null || /usr/bin/true\n";
                if ($file[$i + 1] eq $install) {
                        next;
                }
                splice @file, $i + 1, 0, $install;
                push (@omfs, $omf);
                $i++;
        }

        foreach my $omf (@omfs) {
                my $uninstall =
                    "\@unexec scrollkeeper-uninstall -q \%D/$omf 2>/dev/null || /usr/bin/true\n";
                push @file, $uninstall;
        }

        unless (open(OUTFILE, ">" . $_)) {
                warn "Failed to open $_: $!\n";
                next;
        }

        print OUTFILE @file;

        close(OUTFILE);
}
