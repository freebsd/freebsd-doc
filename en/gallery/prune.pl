#!/usr/bin/perl
#
# prune.pl - Script to prune gallery.db file of malformed
# and otherwise worthless entries.  And while we're at it,
# count the damned things.
#
# Syntax: prune.pl galleryfile.db outfile.db
#
# yymmdd own comment
# ------ --- ------------------------------------------------
# 981229 nsj First pass

# Setup
# Which sort and uniq programs are we using?
$sort	=	"/usr/bin/sort";
$uniq	=	"/usr/bin/uniq";

# Open a pipe from a unix sort of the db file (case insensitive)
if (-f $ARGV[0])
{
	$infile = $ARGV[0];
} else {
	die "File $ARGV[0] is unreadable or does not exist";
}

if ($ARGV[1] eq "") {
	die "You must supply an output filename.";
} else {
	# Open the output file for writing.
	open(OUTFILE,">$ARGV[1]");
};

# Open the (sorted) file
open(DBFILE, "$sort -f $infile | $uniq |");

# Set variables so that we can remove dupe entries.
my $lastname = "";
my $lasturl = "";

# Initialize counter variables.
$numc = 0;
$numnp = 0;
$nump = 0;

# Iterate through each line, throwing out those that don't
# go in this gallery.  Output each entry as list elements.
while (<DBFILE>)
{
	chomp;

	# Split the db line into its component parts.
	($type, $name, $url, $description, $email, $dateadd, $datever) = 
	m/([^\t]+)\t([^\t]+)\t([^\t]+)\t([^\t]*)\t([^\t]+)\t([^\t]+)\t([^\t]+)/;

	# Skip bogus and worthless entries while cleaning up malformed
	# http headers. 
	next if ($name =~ m/^$|^\s+$/);
	next if ($url =~ m/^$|^\s+$|^http:\/\/\s+$/);
	next if ( ($lastname eq $name) && ($lasturl eq $url) );
	$url = "http://" . $url unless ($url =~ m/^http:\/\/.*$/);

	print OUTFILE "$type\t$name\t$url\t$description\t$email\t$dateadd\t$datever\n";

	if ($type =~ m/commercial/) {
		$numc++;
		if (defined $chash{$url}) {
			$chash{$url}++;
		} else {
			$chash{$url} = 1;
		}
	};
	if ($type =~ m/non\s?profit/) {
		$numnp++;
		if (defined $nphash{$url}) {
			$nphash{$url}++;
		} else {
			$nphash{$url} = 1;
		}
	};
	if ($type =~ m/personal/) {
		$nump++;
		if (defined $phash{$url}) {
			$phash{$url}++;
		} else {
			$nphash{$url} = 1;
		}
	};

	$lastname = $name;
	$lasturl = $url;

};

# Close the pipe & file like good little daemons.
close(DBFILE);
close(OUTFILE);

# Print Statistics
print "Commercial: $numc\n";
foreach $key (sort keys %chash) {
	print "$chash{$key}: $key\n" if ($chash{$key} > 1);
}
print "Non-profit: $numnp\n";
foreach $key (sort keys %nphash) {
	print "$nphash{$key}: $key\n" if ($nphash{$key} > 1);
}
print "Personal: $nump\n";
foreach $key (sort keys %phash) {
	print "$phash{$key}: $key\n" if ($phash{$key} > 1);
}
print "Total: ",$numc+$numnp+$nump,"\n";
