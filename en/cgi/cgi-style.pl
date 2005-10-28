# $FreeBSD: www/en/cgi/cgi-style.pl,v 1.22 2005/09/17 15:48:23 remko Exp $
#
# Perl routines to encapsulate various elements of HTML page style.

# For future reference, when is now?
($se,$mn,$hr,$md,$mo,$yr,$wd,$yd,$dst) = localtime(time);
$yr += 1900;
$mo += 1;
$timestamp = "$mo-$md-$yr";

if (!defined($hsty_base)) { 
    $hsty_base = '..';
}
if (!defined($hsty_email)) {
    $hsty_email = 'www@FreeBSD.org';
}
if (!defined($hsty_author)) {
    $hsty_author = "<a href='$hsty_base/mailto.html'>$hsty_email</a>";
}

if (!defined($hsty_date)) {
    $hsty_date = '';
}

# This can be set to either a string containing an inline CSS stylesheet
# or to a <link> element that references an external CSS stylesheet, to
# make local modifications to the style of a CGI script's output.
$t_style = "";	# Don't allow script to override completely, just
		# let the script's setting cascade with the master.

$i_topbar = qq`
    <div id="containerwrap">
      <div id="container">
        <span class="txtoffscreen"><a href="#content"
        title="Skip site navigation" accesskey="1">Skip site
        navigation</a> (1)</span><span class="txtoffscreen"><a
        href="#contentwrap" title="Skip section navigation"
        accesskey="2">Skip section navigation</a> (2)</span>

        <div id="headercontainer">
          <div id="header">
            <h2 class="blockhide">Header And Logo</h2>

            <div id="headerlogoleft">
              <a href="$hsty_base" title="FreeBSD"><img
              src="$hsty_base/layout/images/logo.png" width="360"
              height="40" alt="FreeBSD" /></a>
            </div>

            <div id="headerlogoright">
              <h2 class="blockhide">Peripheral Links</h2>

              <div id="searchnav">
                <ul id="searchnavlist">
                  <li>Text Size: <a href="#"
                  onkeypress="return false;"
                  onclick="setActiveStyleSheet('Normal Text'); return false;"
                   title="Normal Text Size">Normal</a> / <a
                  href="#" onkeypress="return false;"
                  onclick="setActiveStyleSheet('Large Text'); return false;"
                   title="Large Text Size">Large</a></li>

                  <li><a href="$hsty_base/donations/"
                  title="Donate">Donate</a></li>

                  <li class="last-child"><a href="$hsty_base/mailto.html"
                  title="Contact">Contact</a></li>
                </ul>
              </div>

              <div id="search">
                <form
                action="http://www.FreeBSD.org/cgi/search.cgi"
                method="get">
                  <div>
                    <h2 class="blockhide"><label
                    for="words">Search</label></h2>
                    <input type="hidden" name="max"
                    value="25" /><input type="hidden" name="source"
                    value="www" /><input id="words" name="words"
                    type="text" size="20" maxlength="255"
                    onfocus="if( this.value==this.defaultValue ) this.value='';"
                     value="Search" />&nbsp;<input id="submit"
                    name="submit" type="submit" value="Search" />
                  </div>
                </form>
              </div>
            </div>
          </div>

          <h2 class="blockhide">Site Navigation</h2>

          <div id="topnav">
            <ul id="topnavlist">
              <li><a href="$hsty_base/" title="Home">Home</a></li>

              <li><a href="$hsty_base/about.html"
              title="About">About</a></li>

              <li><a href="$hsty_base/where.html" title="Get FreeBSD">Get
              FreeBSD</a></li>

              <li><a href="$hsty_base/docs.html"
              title="Documentation">Documentation</a></li>

              <li><a href="$hsty_base/community.html"
              title="Community">Community</a></li>

              <li><a href="$hsty_base/projects/index.html"
              title="Developers">Developers</a></li>

              <li><a href="$hsty_base/support.html"
              title="Support">Support</a></li>
            </ul>
          </div>
        </div>

	<div id="content">
`;

#XXX does anyone use this? I don't know what it should be in the new style.
if (!defined($hsty_home)) {
    $hsty_home = "<a href='$hsty_base/'><img src='$hsty_base/gifs/home.gif'
  alt='FreeBSD Home Page' border='0' align='right'></a>";
}

sub html_header {
    local ($title, $xhtml) = @_;

    return short_html_header($title, $xhtml) . "<h1>$title</h1>\n";
}

sub short_html_header {
    local ($title, $xhtml) = @_;

    $xhtml = 1 unless defined($xhtml);
    $doctype = $xhtml ?  '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">' : '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">';
    $endslash = $xhtml ? '/' : '';
    $csshack = $xhtml ? '' : q`<style type="text/css">
tr, td {
  margin: 0;
  padding: 0;
  font-family: verdana, sans-serif;
  font-size: 69%;
  color: #000;
}
</style>
`;

    return qq`Content-type: text/html

$doctype

<html xmlns='http://www.w3.org/1999/xhtml'>
<head><title>$title</title>
<meta http-equiv='content-type' content='text/html; charset=iso-8859-1' $endslash>
<meta name='robots' content='nofollow' $endslash>
    <link rel="stylesheet" media="screen"
    href="$hsty_base/layout/css/fixed.css" type="text/css"
    title="Normal Text" $endslash>
    <link rel="alternate stylesheet" media="screen"
    href="$hsty_base/layout/css/fixed_large.css" type="text/css"
    title="Large Text" $endslash>
$csshack
<script type="text/javascript" src="$hsty_base/layout/js/styleswitcher.js">
</script>
$t_style
</head>
<body>
$i_topbar
`;
}

sub html_footer {
    return qq`
	</div>
        <div id="footer">
          <a href="$hsty_base/copyright/">Legal Notices</a> | &copy; 1995-2005
          The FreeBSD Project. All rights reserved.<br />
	  <address>$hsty_author<br />$hsty_date</address>
        </div>
      </div>
    </div>
  </body>
</html>
`;


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

1;
