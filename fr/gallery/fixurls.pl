#!/usr/bin/perl

# This script is dedicated to check existing gallery XML file.
# Check its URLs for duplicates and fixup incorrectly submitted ones.
#
# History:
#   31082001	Alexey Zelkin	Initial version
#
# Usage:
#   fixurls.pl gallery.xml output.xml
#
# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.1

if (-f $ARGV[0]) {
	$src = $ARGV[0];
} else {
	die "Could not open source file!"
}

if ($ARGV[1] eq "") {
	die "Could not open output file!"
} else {
	$dst = $ARGV[1];
}

open (SRC, $src);
open (DST, ">$dst");

while (<SRC>) {
	if ($_ =~ /\<url\>.*\<\/url\>/) {
		chomp;
		s/.*url\>(.*)\<\/url.*/$1/;
		next if ($_ eq "");
		# add "http://" at the begining of the url unless it (or any
		# other (like "ftp://") protocol is already specified
		$_ = "http://" . $_ unless (m/^[a-z]*:\/\/.*$/);
		if (defined $hhash{$_}) {
			$hhash{$_}++;
		} else {
			$hhash{$_} = 1;
		}
		print DST "    <url>$_</url>\n";
	} else {
		print DST $_;
	}
}

close (SRC);
close (DST);

print "Duplicated URLs:\n";
foreach $key (sort keys %hhash) {
	print "$hhash{$key}: $key\n" if ($hhash{$key} > 1);
}
