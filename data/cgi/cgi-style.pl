# $Id: cgi-style.pl,v 1.1.1.1 1996-09-24 17:45:57 jfieber Exp $
#
# Perl routines to encapsulate various elements of HTML page style.

# For future reference, when is now?
($se,$mn,$hr,$md,$mo,$yr,$wd,$yd,$dst) = localtime(time);
$yr += 1900;
$timestamp = "$mo-$md-$yr";

# Colors for the body
$t_body = "<body text=\"#000000\" bgcolor=\"#ffffff\">";

if ($hsty_base eq "") { 
    $hsty_base = "..";
}
if ($hsty_author eq "") {
    $hsty_author = "<a href=\"$hsty_base/mailto.html\">www\@freebsd.org</a>";
}

$i_daemon = "<img src=\"$hsty_base/gifs/biglogo.gif\" alt=\"\">";

if ($hsty_home eq "") {
    $hsty_home = "<a href=\"$hsty_base/\"><img src=\"$hsty_base/gifs/home.gif\"
  alt=\"FreeBSD Home Page\" border=\"0\" align=\"right\"></a>";
}

sub html_header {
    local ($title) = @_;

    return &PrintHeader . "<html>\n<title>$title</title>\n</head>\n$t_body\n" .
	"<h1>$i_daemon $title</h1><hr noshade>\n";
}

sub html_footer {
    return "<hr noshade>$hsty_home<address>$hsty_author<br>$hsty_date</address>\n";
}
