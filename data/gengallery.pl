#!/usr/local/bin/perl
#
# gengallery.pl - script to convert tab-delimited gallery db file to
# a section of an SGML list (not a full SGML file!) for inclusion
# into another SGML file where the <UL></UL> list element pair is
# already in existence.
#
# Syntax: dump.pl type < galleryfile.db > galleryfile.inc
# where type is one of: commerical, nonprofit, personal
#
# yymmdd own comments
# ------ --- ------------------------------------------------
# 980311 nsj First pass
# 980312 jrf Added sorting
# 980313 nsj Wrapped file input routine with error checking

# Setup
# Which sort program are we using?
$sort	=	"/usr/bin/sort";

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

# Open a pipe from a unix sort of the db file (case insensitive)
if (-f $ARGV[1])
{
	$infile = $ARGV[1];
} else {
	die "File $ARGV[1] is unreadable or does not exist";
}

# Open the (sorted) file
open(DBFILE, "$sort -f $infile |");

# Iterate through each line, throwing out those that don't
# go in this gallery.  Output each entry as list elements.
while (<DBFILE>)
{
	# We only want entries of type $type; throw the rest out.
	next unless m/^$type/;

	# Translate out characters special to SGML (and HTML)
	s/&/&amp;/g;
	s/</&lt;/g;

	# Split the db line into its component parts.
	($dummy, $name, $url, $description, $email, $dateadd, $datever) = 
	m/([^\t]+)\t([^\t]+)\t([^\t]+)\t([^\t]*)\t([^\t]+)\t([^\t]+)\t([^\t]+)/;

	# Dump it out to the file, in SGML <LI> format
	if ($description ne "")
	{
		print "<LI><A HREF=\"$url\"><STRONG>$name</STRONG></A> -- $description</LI>\n";
	} else {
		print "<LI><A HREF=\"$url\"><STRONG>$name</STRONG></A></LI>\n";
	};

};

# Close the pipe like good little daemons.
close(DBFILE);
