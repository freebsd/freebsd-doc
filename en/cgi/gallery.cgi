#!/usr/bin/perl
##################################################################
# A CGI form processor for FreeBSD Gallery submissions
# 
# John Fieber <jfieber@indiana.edu>
# Modified for new gallery.db format by Nate Johnson <nsj@freebsd.org>
# $FreeBSD$
##################################################################

$curator = "gallery\@freebsd.org";
$subject = "Another gallery submission...";

require 'cgi-lib.pl';
&ReadParse;

$hsty_date = '$FreeBSD$';
#$h_base = "..";
#$d_author = "
require 'cgi-style.pl';

# Construct the gallery entry in HTML form
$entry = "<li><a href=\"$in{'url'}\"><strong>$in{'organization'}</strong> " .
    "-- $in{'description'}</a></li>";

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
"<form action=\"gallery.cgi\" method=\"POST\">
<input type=hidden name=action value=\"preview\">
<input type=hidden name=return value=\"$in{'return'}\">
<table>
<tr>
<td right>Organization:</td>
<td><input type=text name=organization size=\"50\"></td>
</tr>
<tr>
<td right>Description:</td>
<td><input type=text name=description size=\"50\"></td>
</tr>
<tr>
<td right>URL:</td>
<td><input type=text name=url size=\"50\"></td>
</tr>
<tr>
<td right>Category:</td>
<td>
<input type=radio name=category value=\"Commercial\" checked> Commercial<br>
<input type=radio name=category value=\"NonProfit\"> Non-Profit<br>
<input type=radio name=category value=\"Personal\"> Personal
</td>
</tr>
<tr>
<td right>Email Contact:</td>
<td><input type=text name=\"contact\" size=\"50\"></td>
</tr>
<tr>
<td colspan=\"2\" right><input type=submit value=\" Preview Entry \"></td>
</tr>
</table>
</form>
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
    $year -= 1900;
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
