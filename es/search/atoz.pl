#!/usr/bin/perl
# Copyright (c) May 1997 Wolfram Schneider <wosch@FreeBSD.org>, Berlin.
#
# atoz - create automatically an `A-Z Index' from a pre-sorted database
#        (sort -uf) with the format `<titel>|<url>'
#
# $FreeBSD$

if ($ARGV[0] eq '-u' && $#ARGV > 0) { 
    $urlprefix = $ARGV[1]; shift; shift;  # prefix for relative URLs
} elsif ($ARGV[0] =~ /^-/) { die "usage: $0 [-u urlprefix] files ...\n" }

$top = 'ruebezahl';       # HTML tag name for `go to top of page'
$hr = "<HR NOSHADE>\n\n"; $h2 = 'H2';
$table = 1;               # use table output for alphabet
sub eol { "</UL>\n\n" }

$firstold = ''; @az = (); @list = ();
while(<>) {
    chop; next if /^\s*#/ || /^\s*$/; # ignore comments
    $first = substr($_, 0, 1); $first =~ y/a-z/A-Z/;

    if ($firstold ne $first) { # a new alphabet character
	push(@az, $first);
	push(@list, &eol) if $#az > 0; # close previous list
	push(@list, 
	     qq{<$h2><A NAME="$first" HREF="#$top">$first</a></$h2>\n<UL>\n});
    }
    $firstold = $first;
    ($title, $url) = split('\|', $_); $url =~ s/^\s+//; $url =~ s/\s+$//;
    $url = $urlprefix . $url unless 
	($url =~ m%^/% || $url =~ /^(news|mailto|ftp|http|telnet):/oi);
    push(@list, qq{<LI><A HREF="$url">$title</A>\n});
}
push(@list, &eol); # close last list

# Output header, list, and copyright
print qq{<A NAME="$top"></A>\n};
print qq{<TABLE BORDER=4><TR>\n} if $table;
foreach (@az) {
    if ($table) {
	print qq{<TD><A HREF="#$_">$_</A></TD>\n};
    } else { 
	print qq{<A HREF="#$_">$_</A>\n};
    }
}
print "</TR></TABLE>\n" if $table;
print $hr; print @list; 
#print qq{<link ref="made" href="http://www.de.freebsd.org/~wosch/">\n};

