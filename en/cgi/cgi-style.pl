# $FreeBSD: www/en/cgi/cgi-style.pl,v 1.15 2000/01/05 15:47:42 phantom Exp $
#
# Perl routines to encapsulate various elements of HTML page style.

# For future reference, when is now?
($se,$mn,$hr,$md,$mo,$yr,$wd,$yd,$dst) = localtime(time);
$yr += 1900;
$mo += 1;
$timestamp = "$mo-$md-$yr";

# Colors for the body
$t_body = "<body text=\"#000000\" bgcolor=\"#ffffff\">";

if (!defined($hsty_base)) { 
    $hsty_base = "..";
}
if (!defined($hsty_email)) {
    $hsty_email = "www\@FreeBSD.org";
}
if (!defined($hsty_author)) {
    $hsty_author = "<a href=\"$hsty_base/mailto.html\">$hsty_email</a>";
}

if (!defined($hsty_date)) {
    $hsty_date = "";
}

$i_topbar = "<IMG SRC=\"$hsty_base/gifs/bar.gif\" ALT=\"Navigation Bar\" WIDTH=\"565\" HEIGHT=\"33\" BORDER=0 usemap=\"#bar\">
<map name=\"bar\">
<area shape=\"rect\" coords=\"1,1,111,31\" href=\"$hsty_base/index.html\" ALT=\"Top\">
<area shape=\"rect\" coords=\"112,11,196,31\" href=\"$hsty_base/ports/index.html\" ALT=\"Applications\">
<area shape=\"rect\" coords=\"196,12,257,33\" href=\"$hsty_base/support.html\" ALT=\"Support\">
<area shape=\"rect\" coords=\"256,12,365,33\" href=\"$hsty_base/docs.html\" ALT=\"Documentation\"> 
<area shape=\"rect\" coords=\"366,13,424,32\" href=\"$hsty_base/commercial/commercial.html\" ALT=\"Vendors\">
<area shape=\"rect\" coords=\"425,16,475,32\" href=\"$hsty_base/search/search.html\" ALT=\"Search\">
<area shape=\"rect\" coords=\"477,16,516,33\" href=\"$hsty_base/search/index-site.html\" ALT=\"Index\">
<area shape=\"rect\" coords=\"516,15,562,33\" href=\"$hsty_base/index.html\" ALT=\"Top\">
<area shape=\"rect\" href=\"$hsty_base/index.html\" coords=\"0,0,564,32\" ALT=\"Top\">
</map>";

if (!defined($hsty_home)) {
    $hsty_home = "<a href=\"$hsty_base/\"><img src=\"$hsty_base/gifs/home.gif\"
  alt=\"FreeBSD Home Page\" border=\"0\" align=\"right\"></a>";
}

sub html_header {
    local ($title) = @_;

    return "Content-type: text/html\n\n" . 
	"<html>\n<head><title>$title</title>\n" .
	    "<meta name=\"robots\" content=\"nofollow\">\n</head>\n$t_body\n" .
	"$i_topbar <h1><font color=\"#660000\">$title</font></h1>\n";
}

sub short_html_header {
    local ($title) = @_;

    return "Content-type: text/html\n\n" .
	"<html>\n<head><title>$title</title>\n" . 
	    "<meta name=\"robots\" content=\"nofollow\">\n</head>\n$t_body\n" .
        "$i_topbar";
}

sub html_footer {
    return "<hr><address>$hsty_author<br>$hsty_date</address>\n";
}

sub get_the_source {
    return if $ENV{'PATH_INFO'} ne '/get_the_source';

    open(R, $0) || do { 
	print "Oops! open $0: $!\n";  # should not reached
	exit;
    };

    print "Content-type: text/plain\n\n";
    while(<R>) { print }
    close R;
    exit;
}            

