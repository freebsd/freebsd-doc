#!/usr/local/bin/perl
#
# dump.pl - script to convert tab-delimited gallery db file to
# a section of an SGML list (not a full SGML file!) for inclusion
# into another SGML file where the <UL></UL> list element pair is
# already in existence.
#
# Syntax: dump.pl type < galleryfile.db > galleryfile.inc
# where type is one of: commerical, nonprofit, personal
#
# yymmdd own comments
# ------ --- ------------------------------
# 980311 nsj First pass

# What gallery are we processing?
$type	=	$ARGV[0];
if ($type =~ m/commercial/i) {
	$type = "commercial";
} elsif ($type =~ m/nonprofit/i) {
	$type = "nonprofit";
} elsif ($type =~ m/personal/i) {
	$type = "personal";
} else {
	die "I don't understand type $type";
}
open(FOO, "sort -f $ARGV[1] |");

while (<FOO>)
{
	# We only want entries of type $type; throw the rest out.
	next unless m/^$type/;

	s/&/&amp;/g;
	s/</&lt;/g;

	($dummy, $name, $url, $description, $email, $dateadd, $datever) = 
	m/([^\t]+)\t([^\t]+)\t([^\t]+)\t([^\t]*)\t([^\t]+)\t([^\t]+)\t([^\t]+)/;

	# Dump it out to the file, in SGML <LI> format
	print "<LI><A HREF=\"$url\"><STRONG>$name</STRONG></A> -- $description</LI>\n";
};

close(FOO);
