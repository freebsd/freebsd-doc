#!/usr/bin/perl
#
# mail-archive.pl  --  a CGI interface to a wais indexed maling list archive.
#
# Origin:
#   Tony Sanders <sanders@bsdi.com>, Nov 1993
#
# Hacked beyond recognition by:
#   John Fieber <jfieber@cs.smith.edu>, Nov 1994
#
# Format the mail messages a little nicer.
# Add code to check database status before searching.
#   John Fieber <jfieber@indiana.edu>, Aug 1996
#
# Disclaimer:
#   This is pretty ugly in places.


$server_root = '/usr/local/www';
$waisq = "/usr/local/www/bin/waisq";
$sourcepath = "$server_root/db/index";
$hints = "/search/searchhints.html"; 
$searchpage = '/search/search.html';   
$myurl = $ENV{'SCRIPT_NAME'};

require "open2.pl";
require "cgi-lib.pl";
require "cgi-style.pl";

@months = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

sub do_wais {
    &ReadParse;
    
    @FORM_words = split(/ /, $in{"words"});
    @FORM_source = split(/\0/, $in{"source"});
    $FORM_max = $in{"max"};
    $FORM_docnum = $in{"docnum"};
    
    @AVAIL_source = &checksource(@FORM_source);
    if ($#FORM_source != $#AVAIL_source) {
    	$j = 0;
    	$k = 0;
    	foreach $i (0 .. $#FORM_source) {
    	    if ($FORM_source[$i] ne $AVAIL_source[$j]) {
    	    	$badsource[$k] = $FORM_source[$i];
    	    	$k++;
    	    } else {
    	    	$j++;
    	    }
    	}
    	$badsource = join("</em>, <em>", @badsource);
    	$badsource =~ s/,([^,]*)$/ and $1/;
    	if ($#FORM_source - $#AVAIL_source > 1) {
    	    $availmsg = "<p>[The <em>$badsource</em> archives are currently unavailable.]</p>";
    	} else {
    	    $availmsg = "<p>[The <em>$badsource</em> archive is currently unavailable.]</p>";
    	}
    }
    if ($#AVAIL_source < 0) {
    	$i = join("</em>, <em>", @FORM_source);
    	$i =~ s/,([^,]*)$/ and $1/;
    	print &html_header("Mail Archive Search") .
    	    "<p>None of the archives you requested (<em>$i</em>) are " .
		" available at this time.</p>\n";
    	print "<p>Please try again later, or return to the " .
    	    "search page and select a different archive.</p>\n";
	print &html_footer;
    	exit 0;
    }

    # Now we formulate the question to ask the server
    foreach $i (@AVAIL_source) {
	$w_sources .=  "(:source-id\n        :filename \"$i.src\"\n        )  ";
    }
    $w_question = "\n  (:question 
    :version  2 
    :seed-words \"@FORM_words\"
    :relevant-documents 
    (  )
    :sourcepath \"$sourcepath/:\"
    :sources 
    (  $w_sources      )
    :maximum-results  $FORM_max 
    :result-documents 
    (  ) 
    )\n";
    

    #
    # First case, no document number so this is a regular search
    #
    print &html_header("Search Results");
    print $availmsg;
    if ($#AVAIL_source > 0) {
	$src = join("</em>, <em>", @AVAIL_source);
	$src =~ s/,([^,]*)$/ and $1/;
	print "<p>The archives <em>$src</em> contain ";
    }
    else {
	print "The archive <em>@AVAIL_source</em> contains ";
    }
    print " the following items relevant to \`@FORM_words\':\n";
    print "<OL>\n";

    &open2(WAISOUT, WAISIN, $waisq, "-g");
    print WAISIN $w_question;

    local(@mylist) = ();
    local($hits, $score, $headline, $lines, $bytes, $docid, $date, $file);

    while (<WAISOUT>) {
	/:original-local-id.*#\(\s+([^\)]*)/ && 
	    ($docid = pack("C*", split(/\s+/, $1)),
	     $docid =~ s/\s+/+/g);
	/:score\s+(\d+)/ && ($score = $1);
	/:filename "(.*)"/ && ($file = $1);
	/:number-of-lines\s+(\d+)/ && ($lines = $1);
	/:number-of-bytes\s+(\d+)/ && ($bytes = $1);
	/:headline "(.*)"/ && ($headline = $1, 
			       $headline =~ s/[Rr]e://);  # XXX
	/:date "(\d+)"/ && ($date = $1, $hits++, 
			    push(@mylist, join("\t", $date, $headline, $docid, 
					       $bytes, $lines, $file, $score, $hits)));
    }

    if ($in{'sort'} eq "date") {
	foreach (reverse sort {$a <=> $b} @mylist) {
	    ($date, $headline, $docid, $bytes, $lines, 
	     $file, $score, $hits) = split("\t");
	    &docdone;
	}
    } elsif ($in{'sort'} eq "subject") {
	local(@a, @c, $b, $d);
	foreach (@mylist) {
	    @a = split("\t");
	    $b = $a[0];
	    # swap date and subject
	    if ($a[1] =~ /(^[^:]+)(Re:.*)/) {
		$a[0] = "$2\t$1";
	    } else {
		$a[0] = "$a[1]\t.";
	    }
	    $a[1] = $b;
	    push(@c, join("\t", @a));
	} 
	local($subject, $author);
	foreach (sort {$a cmp $b} @c) {
	    ($subject, $author, $date, $docid, $bytes, 
	     $lines, $file, $score, $hits) = split("\t");
	    $headline = $author . $subject;
	    &docdone;
	}

    } elsif ($in{'sort'} eq "author") {
	local(@a, @c, $b);
	foreach (@mylist) {
	    @a = split("\t");
	    # swap date and subject
	    $b = $a[0]; $a[0] = $a[1]; $a[1] = $b;
	    push(@c, join("\t", @a));
	} 
	foreach (sort {$a cmp $b} @c) {
	    ($headline, $date, $docid, $bytes, 
	     $lines, $file, $score, $hits) = split("\t");
	    &docdone;
	}

    } else {
	foreach (@mylist) {
	    ($date, $headline, $docid, $bytes, 
	     $lines, $file, $score, $hits) = split("\t");
	    &docdone;
	}
    }
    #print qq[in: $in{'sort'}\n];

    print "</OL>\n";

    print "<p>Didn't get what you expected? ";
    print "<a href=\"$hints\">Look here for searching hints</a>.</p>";

    print qq{<p><a href="$searchpage">Return to the search page</a></p>\n};

    if ($hits == 0) {
	print "Nothing found.\n";
    }

    print &html_footer;
    close(WAISOUT);
    close(WAISIN);

}			     

# Given an array of sources (sans .src extension), this routine
# checks to see if they actually exist, and if they do, if they
# are currently available (ie, not being updated).  It returns
# an array of sources that are actually available.

sub checksource {
    local (@sources) = @_;

    $j = 0;
    foreach $i (@sources) {
    	if (stat("$sourcepath/$i.src")) {
       	    if (!stat("$sourcepath/$i.update.lock")) {
    	    	$goodsources[$j] = $i;
    	    	$j++;
    	    }
    	}
    }
    return(@goodsources);
}

sub htmlescape {
    local ($data) = @_;
    $data =~ s/&/&amp;/g;
    $data =~ s/</&lt;/g;
    return $data;
}

sub docdone {
    $file =~ s/\.src$//;
    if ($headline =~ /Search produced no result/) {
	print "<p>The archive <em>$file</em> contains no relevant documents.</p>"
    } else {
        $headline = &htmlescape($headline);
        $headline =~ s/\\"/\"/g;
        if ($file eq "www") {
            print "<li><a href=\"$headline\">$headline</a>\n";
        } else {
            print "<li><A HREF=\"getmsg.cgi?fetch=${docid}\">$headline</A>\n";
        }
        print "<br>";
#	print "<input type=\"checkbox\" name=\"rf\" value=\"$docnum\">";
	print "Score: <em>$score</em>; ";
    	$_ = $date;
    	/(..)(..)(..)/ && ($yr = $1 + 1900, $mo = $months[$2 - 1], $dy = $3);
	print "Lines: <em>$lines</em>; ";
    	print "${dy}-${mo}-${yr}; ";
	print "Archive: <em>$file</em>";
	print "<p></p></li>\n";
    }
#    $score = $headline = $lines = $bytes = $docid = $date = $file = '';
}

$| = 1;
open (STDERR,"> /dev/null");
eval '&do_wais';

