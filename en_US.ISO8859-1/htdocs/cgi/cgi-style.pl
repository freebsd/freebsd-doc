# $FreeBSD$
#
# Perl routines to encapsulate various elements of HTML page style.

# For future reference, when is now?
($se,$mn,$hr,$md,$mo,$yr,$wd,$yd,$dst) = localtime(time);
$yr += 1900;
$mo += 1;
$timestamp = "$mo-$md-$yr";

if (!defined($hsty_base)) { 
    # $hsty_base should be relative if possible, so that mirrors
    # serve their local copy instead of going to the main site.
    # However, if we aren't running as a cgi, or if we're
    # running on cgi, hub, docs or people, use the absolute home path.
    if (!defined($ENV{'HTTP_HOST'}) ||
	$ENV{'HTTP_HOST'} =~ /(cgi|hub|docs|people|mailarchive.ysv).freebsd.org/i) {

	$hsty_base = '//www.FreeBSD.org'
    } else {
	$hsty_base = '..';
    }
}
if (!defined($hsty_email)) {
    $hsty_email = 'Contact';
}
if (!defined($hsty_author)) {
    $hsty_author = "<a href='$hsty_base/mailto.html'>$hsty_email</a>";
}

if (!defined($hsty_date)) {
    $hsty_date = '';
}

if (!defined($hsty_charset)) {
    $hsty_charset = 'iso-8859-1';
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
        href="#content" title="Skip section navigation"
        accesskey="2">Skip section navigation</a> (2)</span>

        <div id="headercontainer">
          <div id="header">
            <h2 class="blockhide">Header And Logo</h2>

            <div id="headerlogoleft">
              <a href="$hsty_base" title="FreeBSD"><img
              src="$hsty_base/layout/images/logo-red.png" width="457"
              height="75" alt="FreeBSD" /></a>
            </div>

            <div id="headerlogoright">
              <h2 class="blockhide">Peripheral Links</h2>

	      <div class="frontdonateroundbox">
		<div class="frontdonatetop">
		  <div>
		    <b style="display: none;">.</b>
		  </div>
		</div>
		<div class="frontdonatecontent">
		  <a href="https://www.FreeBSDFoundation.org/donate/">Donate to FreeBSD</a>
		</div>
		<div class="frontdonatebot">
		  <div>
		    <b style="display: none;">.</b>
		  </div>
		</div>
	      </div>

              <div id="search">
		<form method="get" id="search" action="https://duckduckgo.com/">
		  <h2 class="blockhide"><label for="words">Search</label></h2>
		  <input type="hidden" name="sites" value="www.FreeBSD.org,docs.FreeBSD.org,lists.FreeBSD.org,wiki.FreeBSD.org,forums.FreeBSD.org" />
		  <input type="hidden" name="ka" value="v" />
		  <input type="hidden" name="kt" value="v" />
		  <input type="hidden" name="kh" value="1" />
		  <input type="hidden" name="kj" value="r2" />
		  <input id="words" name="q" type="text" size="20"
		    maxlength="255"
		    onfocus="if( this.value==this.defaultValue ) this.value='';"
		    value="Search" />
		  <span>&nbsp;</span>
		  <input id="submit" name="submit" type="submit" value="Search" />
		</form>
              </div>
            </div>
          </div>

          <h2 class="blockhide">Site Navigation</h2>

	  <div id="menu">
	    <ul class="first">
	      <li><a href="$hsty_base/">Home</a></li>
	    </ul>
	    <ul>
	      <li><a href="$hsty_base/about.html">About</a>
		<ul>
		  <li><a href="$hsty_base/projects/newbies.html">Introduction</a></li>
		  <li><a href="$hsty_base/features.html">Features</a></li>
		  <li><a href="$hsty_base/advocacy/">Advocacy</a></li>
		  <li><a href="$hsty_base/marketing/">Marketing</a></li>
		</ul>
	      </li>
	    </ul>
	    <ul>
	      <li><a href="$hsty_base/where.html">Get FreeBSD</a>
		<ul>
		  <li><a href="$hsty_base/releases/">Release Information</a></li>
		  <li><a href="$hsty_base/releng/">Release Engineering</a></li>
		</ul>
	      </li>
	    </ul>
	    <ul>
	      <li><a href="$hsty_base/docs.html">Documentation</a>
		<ul>
		  <li><a href="$hsty_base/doc/en_US.ISO8859-1/books/faq/">FAQ</a></li>
		  <li><a href="$hsty_base/doc/en_US.ISO8859-1/books/handbook/">Handbook</a></li>
		  <li><a href="$hsty_base/doc/en_US.ISO8859-1/books/porters-handbook">Porter's Handbook</a></li>
		  <li><a href="$hsty_base/doc/en_US.ISO8859-1/books/developers-handbook">Developer's Handbook</a></li>
		  <li><a href="$hsty_base/cgi/man.cgi">Manual Pages</a></li>
		  <li><a href="$hsty_base/doc/en_US.ISO8859-1/books/fdp-primer">Documentation Project Primer</a></li>
		  <li><a href="$hsty_base/docs/books.html">All Books and Articles</a></li>
		</ul>
	      </li>
	    </ul>
	    <ul>
	      <li><a href="$hsty_base/community.html">Community</a>
		<ul>
		  <li><a href="$hsty_base/community/mailinglists.html">Mailing Lists</a></li>
		  <li><a href="https://forums.FreeBSD.org">Forums</a></li>
		  <li><a href="$hsty_base/usergroups.html">User Groups</a></li>
		  <li><a href="$hsty_base/events/events.html">Events</a></li>
		</ul>
	      </li>
	    </ul>
	    <ul>
	      <li><a href="$hsty_base/projects/index.html">Developers</a>
		<ul>
		  <li><a href="$hsty_base/projects/ideas/ideas.html">Project Ideas</a></li>
		  <li><a href="//svnweb.FreeBSD.org">SVN Repository</a></li>
		  <li><a href="//p4web.FreeBSD.org">Perforce Repository</a></li>
		</ul>
	      </li>
	    </ul>
	    <ul>
	      <li><a href="$hsty_base/support.html">Support</a>
		<ul>
		  <li><a href="$hsty_base/commercial/commercial.html">Vendors</a></li>
		  <li><a href="//security.FreeBSD.org/">Security Information</a></li>
		  <li><a href="https://bugs.freebsd.org/bugzilla/search/">Bug Reports</a></li>
		  <li><a href="$hsty_base/support.html">Submit Bug-report</a></li>
		</ul>
	      </li>
	    </ul>
	    <ul>
	      <li><a href="//www.freebsdfoundation.org/">Foundation</a>
		<ul>
		  <li><a href="//www.freebsdfoundation.org/donate/">Donate</a></li>
		</ul>
	      </li>
	    </ul>
	  </div> <!-- MENU -->
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
    $html = $xhtml ? '<html xmlns="http://www.w3.org/1999/xhtml">' : '<html>';
    $endslash = $xhtml ? '/' : '';
    $csshack = (1 || $xhtml) ? '' : q`<style type="text/css">
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
$html

<head><title>$title</title>
<meta http-equiv='content-type' content='text/html; charset=$hsty_charset' $endslash>
<meta name='robots' content='nofollow' $endslash>
    <link rel="stylesheet" media="screen"
    href="$hsty_base/layout/css/fixed.css" type="text/css"
    title="Normal Text" $endslash>
    <link rel="alternate stylesheet" media="screen"
    href="$hsty_base/layout/css/fixed_large.css" type="text/css"
    title="Large Text" $endslash>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="apple-touch-icon" href="/favicon.ico" type="image/x-icon" />
$csshack
<script type="text/javascript" src="$hsty_base/layout/js/google.js">
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
          <a href="$hsty_base/copyright/">Legal Notices</a> | &copy; 1995-2016
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
