#!/usr/bin/perl
# Copyright (c) June 1998 Wolfram Schneider <wosch@FreeBSD.org>, Berlin.
#
# site - create automatically a site map
#
# Format: <url> | <description>
# An empty url begin a new section
#
# $FreeBSD$


# print a dl list
# <dl><dt>foo</dt>
#     <dd>bla,foo,bar</dd>
# </dl> 

sub dl {
    $menu = 0;
    print "<dl>\n";

    while(<>) {
	# ignore comments and empty lines
	next if /^\s*#/;
	next if /^\s*$/;
	
	chop;
	($url, $description) = split('\|');
	$description =~ s/^\s+//;
	$description =~ s/\s+$//;
	
	# new section
	if (!$url && $description) {
	    # close last <dd>
	    if ($menu) {
		print "\n", "  </dd>\n", "\n";
	    }

	    $menu = 1;
	    print " <dt><strong>", $description, "</strong></dt>\n";
	    print "  <dd>\n";
	} 

	# entries for a section
	elsif ($menu) {
	    # a comma execpt for the last entry
	    print ",\n" if ($menu > 1);

	    print "   <a href=", '"', $url, '">', $description, "</a>";
	    $menu++;
	}
    }

    print "\n", "  </dd>\n";
    print "</dl>\n";
}

&dl;
