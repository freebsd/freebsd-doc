#!/usr/bin/perl

#
# gconf.pl - a script to add proper gconf schema handling to port PLISTs
# usage: gconf.pl [plist] [plist] [...]
#
# $Id: gconf.pl,v 1.2 2004-07-17 15:48:45 marcus Exp $
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

        for (my $i = 0 ; $i < scalar(@file) ; $i++) {
                my ($install, $uninstall);
                next unless $file[$i] =~ m|^etc/gconf/schemas/.*\.schemas?\n$|;
                my $schema = $file[$i];
                chomp $schema;
                $uninstall =
                    "\@unexec env GCONF_CONFIG_SOURCE=xml::\%D/etc/gconf/gconf.xml.defaults gconftool-2 --makefile-uninstall-rule \%D/$schema > /dev/null || /usr/bin/true\n";

                if ($file[$i - 1] ne $uninstall) {
                        splice @file, $i, 0, $uninstall;
			$i++
                }

                $install =
                    "\@exec env GCONF_CONFIG_SOURCE=xml::\%D/etc/gconf/gconf.xml.defaults gconftool-2 --makefile-install-rule \%D/$schema > /dev/null || /usr/bin/true\n";
                if ($file[$i + 1] ne $install) {
                        splice @file, $i + 1, 0, $install;
                        $i++;
                }
        }

        unless (open(OUTFILE, ">" . $_)) {
                warn "Failed to open $_: $!\n";
                next;
        }

        print OUTFILE @file;

        close(OUTFILE);
}
