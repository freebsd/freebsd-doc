#!/usr/bin/perl

require 'cgi-lib.pl';
require 'cgi-style.pl';


$newloc = "http://www.FreeBSD.org/";

print &html_header("FTP Download");

open (MIRRORS, "ftp.mirrors");

print "<h2>Download <em>$ARGV[0]</em> from one of the following mirror sites:</h2>\n";

$oldplace = "";

while (<MIRRORS>) {
    if (/.*:.*:/ && !/^#/) {
    ($place, $site, $root) = split(':',$_);
	chop $root; $root =~ s/ *$//;
	if ($place ne $oldplace) {
	    if ($oldplace ne "") {
		print "</ul>\n";
	    }
	    print "<strong>$place</strong>\n<ul>\n";
	    $oldplace = $place;
	}
	print "<li><a href='ftp://${site}${root}/$ARGV[0]'>$site</a></li>\n";
    }
}

close (MIRRORS);

print "</ul>\n";
print &html_footer;
