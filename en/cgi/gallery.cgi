#!/usr/bin/perl
##################################################################
# A CGI form processor for FreeBSD Gallery submissions
# 
# John Fieber <jfieber@indiana.edu>
# Modified for new gallery.db format by Nate Johnson <nsj@FreeBSD.org>
# $FreeBSD: www/en/cgi/gallery.cgi,v 1.20 2002/01/08 13:29:12 phantom Exp $
##################################################################

$curator = "gallery\@FreeBSD.org";
$subject = "Another gallery submission...";

require 'cgi-lib.pl';
&ReadParse;

$hsty_date = '$FreeBSD: www/en/cgi/gallery.cgi,v 1.20 2002/01/08 13:29:12 phantom Exp $';
# Replace Id string with commit date and time.
$hsty_date =~ s%\$FreeBSD. .* (.* .*) .* .* \$%Last modified: $1%;

#$h_base = "..";
#$d_author = "
require 'cgi-style.pl';

# Construct the gallery entry in HTML form
$entry = "<li><a href=\"$in{'url'}\"><strong>$in{'organization'}</strong></a> " .
    "-- $in{'description'}</li>";

# Try and figure out where the person came from so we can provide
# links back to the correct place.
$return = "";
if ($in{'return'} eq "") {
    if ($ENV{'HTTP_REFERER'} ne "") {
    	$in{'return'} = $ENV{'HTTP_REFERER'};
    }
}
if ($in{'return'} ne "") {
    $return = "<a href=\"$in{'return'}\">Return to the Gallery</a>";
}


# This is the form where the user enters the information.
$forma = &html_header("Gallery Submission") .
"<table>
<tr>
<td right><b>Because of the hard maintaince and low benefit the gallery
  pages bring to both the Project and the listed websites, it has been
  decided to spend the time working on other stuff related to FreeBSD
  than these pages. The gallery will be removed in two weeks, no
  further submissions will be processed.</b>
</td>
</tr>
<tr>
<td right><b>Note:</b> This has no influence on the commercial gallery!
</td>
</tr>
</table>
<p>$return</p>
" . &html_footer();

# This is the form where the user CHECKS the information they typed
$formb = &html_header("Your Gallery Submission") .
"<P>Here is your entry as it will appear in the
FreeBSD Gallery page.</p>
<p>Please check that the category and your e-mail
address are correct, and that the link actually works.
If anything is wrong, use your
browser's <em>back</em> button and correct it.
If everything is okay, press the <em>submit</em> button
below.</p>
<p>Contact person: <strong>$in{'contact'}</strong></p>
<hr><h2>$in{'category'}</h2>
<ul>
$entry
</ul>
<hr>
<form method=\"POST\" action=\"gallery.cgi\">
<input type=hidden name=action value=submit>
<input type=hidden name=organization value=\"$in{'organization'}\">
<input type=hidden name=description value=\"$in{'description'}\">
<input type=hidden name=url value=\"$in{'url'}\">
<input type=hidden name=category value=\"$in{'category'}\">
<input type=hidden name=contact value=\"$in{'contact'}\">
<input type=hidden name=return value=\"$in{'return'}\">
<input type=submit value=\" Submit this \">
</form>
<p>$return</p>
" . &html_footer();

# And this is where we thank them for submitting an entry.
$formc = &html_header("Thank You!") .
"<P>Thank you for your entry!  Please allow a few days for your
entry to be added to the Gallery.</p>
<p>$return</p>
" . &html_footer();


if ($in{'action'} eq "preview") {
    print $formb;
}
elsif ($in{'action'} eq "submit") {
    print $formc;
#    close(STDOUT);

    open(M, "| mail -s \"$subject\" $curator");
#    print M "\"$in{'category'}\" gallery entry:\n\n";
#    print M "<!-- from $in{'contact'} ($ENV{'REMOTE_HOST'}) on $timestamp -->\n";
#    print M "$entry\n";

    $category = $in{'category'};
    $category =~ tr/A-Z/a-z/;
    $category =~ tr/ //;

    ($mo,$da,$year) = $timestamp =~ m/(\d\d?)-(\d\d?)-(\d\d\d\d)/;
    $year -= 2000;
    $mo = join('','0',$mo) if ($mo =~ /^\d$/);
    $da = join('','0',$da) if ($da =~ /^\d$/);
    $date = join("",$year,$mo,$da);
    print M "$category\t$in{'organization'}\t$in{'url'}\t$in{'description'}\t$in{'contact'}\t$date\t000000\n";

    close(M);
}
else {
    print $forma;
}

exit 0;
