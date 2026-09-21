#
# Perl routines to encapsulate various elements of HTML page style.

# For future reference, when is now?
( $se, $mn, $hr, $md, $mo, $yr, $wd, $yd, $dst ) = localtime(time);
$yr += 1900;
$mo += 1;
$timestamp = "$mo-$md-$yr";

if ( !defined($hsty_base) ) {

    # $hsty_base should be relative if possible, so that mirrors
    # serve their local copy instead of going to the main site.
    # However, if we aren't running as a cgi, or if we're
    # running on one of the subdomains listed below, use the absolute home path.
    if (   !defined( $ENV{'HTTP_HOST'} )
        || $ENV{'FREEBSD_WWW_PROD'}
        || $ENV{'HTTP_HOST'} =~
/(docs|docs-archive|mail-archive|man|man-dev|people|ports|ports-dev).freebsd.org/i
      )
    {
        $hsty_base = 'https://www.FreeBSD.org';
    }
    else {
        $hsty_base = '..';
    }
}

if ( !defined($hsty_email) ) {
    $hsty_email = 'Contact';
}
if ( !defined($hsty_author) ) {
    $hsty_author = "<a href='$hsty_base/contact/'>$hsty_email</a>";
}

if ( !defined($hsty_date) ) {
    $hsty_date = '';
}

if ( !defined($hsty_charset) ) {
    $hsty_charset = 'iso-8859-1';
}

# This can be set to either a string containing an inline CSS stylesheet
# or to a <link> element that references an external CSS stylesheet, to
# make local modifications to the style of a CGI script's output.
$t_style = "";    # Don't allow script to override completely, just
                  # let the script's setting cascade with the master.

$i_topbar = qq`
<header>
  <div class="header-container">
    <div class="logo-menu-bars-container">
      <a href="$hsty_base/" class="logo">
        <img src="$hsty_base/images/FreeBSD-monochromatic.svg" width="160" height="50" alt="FreeBSD logo">
      </a>
      <label class="menu-bars" for="menu-bars">
        <span class="menu-bars-icon" aria-hidden="true"></span>
      </label>
    </div>
    <input id="menu-bars" type="checkbox">
    <nav>
      <ul class="menu">
        <li class="menu-item">
          <input id="about" type="checkbox">
          <label class="menu-item-description" for="about">
            About
            <i class="fa fa-angle-down fa-lg" aria-hidden="true"></i>
          </label>
          <ul class="sub-menu">
            <li class="title">
              <a href="$hsty_base/about">About</a>
            </li>
            <li>
              <a href="$hsty_base/projects/newbies">Introduction</a>
            </li>
            <li>
              <a href="$hsty_base/features">Features</a>
            </li>
            <li>
              <a href="$hsty_base/privacy">Privacy Policy</a>
            </li>
            <li>
              <a href="$hsty_base/projects">Projects</a>
            </li>
          </ul>
        </li>
        <li class="menu-item">
          <input id="download" type="checkbox">
          <label class="menu-item-description" for="download">
            Get FreeBSD
            <i class="fa fa-angle-down fa-lg" aria-hidden="true"></i>
          </label>
          <ul class="sub-menu">
            <li class="title">
              <a href="$hsty_base/where">Get FreeBSD</a>
            </li>
            <li>
              <a href="$hsty_base/releases">Release Information</a>
            </li>
            <li>
              <a href="$hsty_base/releng">Release Engineering</a>
            </li>
            <li>
              <a href=/ports>Ported Applications</a>
            </li>
          </ul>
        </li>
        <li class="menu-item">
          <input id="documentation" type="checkbox">
          <label class="menu-item-description" for="documentation">
            Documentation
            <i class="fa fa-angle-down fa-lg" aria-hidden="true"></i>
          </label>
          <ul class="sub-menu">
            <li class="title">
              <a href="https://docs.FreeBSD.org/en/">Documentation</a>
            </li>
            <li>
              <a href="https://docs.FreeBSD.org/en/books/handbook/">Handbook</a>
            </li>
            <li>
              <a href="https://docs.FreeBSD.org/en/books/faq/">FAQ</a>
            </li>
            <li>
              <a href="https://docs.FreeBSD.org/en/books/porters-handbook/">Porter&#39;s Handbook</a>
            </li>
            <li>
              <a href="https://docs.FreeBSD.org/en/books/fdp-primer">Documentation Project Primer</a>
            </li>
            <li>
              <a href="https://man.FreeBSD.org">Manual pages</a>
            </li>
            <li>
              <a href="https://papers.FreeBSD.org">Presentations and papers</a>
            </li>
            <li>
              <a href="https://docs.FreeBSD.org/en/books">Books</a>
            </li>
            <li>
              <a href="https://docs.FreeBSD.org/en/articles">Articles</a>
            </li>
          </ul>
        </li>
        <li class="menu-item">
          <input id="community" type="checkbox">
          <label class="menu-item-description" for="community">
            Community
            <i class="fa fa-angle-down fa-lg" aria-hidden="true"></i>
          </label>
          <ul class="sub-menu">
            <li class="title">
              <a href="$hsty_base/community">Community</a>
            </li>
            <li>
              <a href="$hsty_base/community/mailinglists">Mailing lists</a>
            </li>
            <li>
              <a href="https://forums.FreeBSD.org">Forums</a>
            </li>
            <li>
              <a href="$hsty_base/usergroups">User Groups</a>
            </li>
            <li>
              <a href="$hsty_base/events">Events</a>
            </li>
            <li>
              <a href="https://freebsdfoundation.org/our-work/journal/">FreeBSD Journal</a>
            </li>
          </ul>
        </li>
        <li class="menu-item">
          <input id="developers" type="checkbox">
          <label class="menu-item-description" for="developers">
            Developers
            <i class="fa fa-angle-down fa-lg" aria-hidden="true"></i>
          </label>
          <ul class="sub-menu">
            <li class="title">
              <a href="$hsty_base/projects">Developers</a>
            </li>
            <li>
              <a href="https://wiki.FreeBSD.org/IdeasPage">Project Ideas</a>
            </li>
            <li>
              <a href="https://cgit.FreeBSD.org">Git Repository</a>
            </li>
            <li>
              <a href="https://github.com/freebsd">GitHub Mirror</a>
            </li>
            <li>
              <a href="https://reviews.FreeBSD.org">Code Review (Phabricator)</a>
            </li>
            <li>
              <a href="https://wiki.FreeBSD.org">Wiki</a>
            </li>
            <li>
              <a href="https://ci.FreeBSD.org">Continuous Integration Service</a>
            </li>
          </ul>
        </li>
        <li class="menu-item">
          <input id="support" type="checkbox">
          <label class="menu-item-description" for="support">
            Support
            <i class="fa fa-angle-down fa-lg" aria-hidden="true"></i>
          </label>
          <ul class="sub-menu">
            <li class="title">
              <a href="$hsty_base/support">Support</a>
            </li>
            <li>
              <a href="$hsty_base/commercial">Vendors</a>
            </li>
            <li>
              <a href="$hsty_base/security">Security Information</a>
            </li>
            <li>
              <a href="https://bugs.FreeBSD.org/search/">Bug Reports</a>
            </li>
            <li>
              <a href="$hsty_base/support">Submitting Bug Reports</a>
            </li>
            <li>
              <a href="$hsty_base/support/webresources">Web Resources</a>
            </li>
          </ul>
        </li>
      </ul>
    </nav>
    <div class="search-donate-container">
      
      <form
        class="search"
        method="get"
        id="search-header-form"
        action="https://duckduckgo.com"
        name="search-header-form"
        onsubmit="document.getElementById('words').value+=' site:FreeBSD.org'">
        <input type="hidden" name="DB" value="en">
        <input type="hidden" name="ka" value="v">
        <input type="hidden" name="kt" value="v">
        <input type="hidden" name="kh" value="1">
        <input type="hidden" name="kj" value="r2">
        <input
          id="words"
          name="q"
          type="text"
          size="20"
          maxlength="25"
          onfocus="if( this.value==this.defaultValue ) this.value='';"
          value=""
          placeholder="">
        <button>
          <i class="fa fa-search" aria-hidden="true"></i>
        </button>
      </form>
      <details class="i18n">
        <summary class="lang-toggle">
          <img src="$hsty_base/images/language.png" class="language-image" alt="" />
        </summary>
        <ul class="lang-dropdown">
          <li>
            <a href="$hsty_base/" class="current-lang" aria-current="page">English</a>
          </li>
          
            <li>
              <a href="$hsty_base/ru/" lang="ru">Russian</a>
            </li>
          
            <li>
              <a href="$hsty_base/zh-tw/" lang="zh-tw">繁體中文</a>
            </li>
          
        </ul>
      </details>
      <div class="donate">
        <a href="https://freebsdfoundation.org/donate/">
          <span class="heart">❤️</span>
          Donate
        </a>
      </div>
    </div>
  </div>
</header>


<main>
<div id="content">
  <!-- disable sidebar for cgi scripts
  <aside id="sidewrap">
    <div id="sidenav">
   </div>
  </aside>
  -->

  <div id="contentwrap">

`;

sub html_header {
    local ( $title, $xhtml ) = @_;

    return short_html_header( $title, $xhtml ) . "\n<h2>$title</h2>\n";
}

sub short_html_header {
    local ( $title, $xhtml ) = @_;

    $xhtml = 1 unless defined($xhtml);
    $doctype =
      $xhtml
      ? '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
      : '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">';
    $html = $xhtml ? '<html xmlns="http://www.w3.org/1999/xhtml">' : '<html>';
    $endslash = $xhtml ? '/'                                       : '';

    $csshack = ( 1 || $xhtml ) ? '' : q`<style type="text/css">
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

<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="  ">
  <meta name="keywords" content="">
  <meta name="copyright" content="1995-2026 The FreeBSD Project">
  <link rel="canonical" href="https://www.freebsd.org/">

  <title>$title</title>

  <meta name="theme-color" content="#790000">
  <meta name="color-scheme" content="system light dark high-contrast">

  <link rel="shortcut icon" href="$hsty_base/favicon.ico">
  <link rel="stylesheet" href="$hsty_base/styles/main.min.css">
  <link rel="stylesheet" href="$hsty_base/css/font-awesome-min.css">

  <meta property="og:title" content="  " >
  <meta property="og:description" content="  " >
  <meta property="og:type" content="website">
  <meta property="og:image" content="/favicon.ico">
  <meta property="og:image:alt" content="FreeBSD Logo">
  <meta property="og:locale" content="en" >
  <meta property="og:url" content="https://www.freebsd.org/">
  <meta property="og:site_name" content="The FreeBSD Project">
  <script type="application/ld+json">
    {
      "@context": "http://schema.org",
      "@type": "Article",
      "url": "https:\/\/www.freebsd.org\/",
      "name": "The FreeBSD Project",
      "headline": "The FreeBSD Project",
      "description": ""
    }
  </script>
  
  <script defer src="$hsty_base/js/theme-chooser.min.js"></script>
  $csshack
  $t_style
  </head>

  <body>
    <input type="checkbox" class="theme-switch" id="theme-switch">
    <div id="page">

$i_topbar
`;
}

sub html_footer {
    return qq`
  </div>
</div>
</main>

<footer>
  <div class="footer-container">
    <section class="logo-column">
      <img src="$hsty_base/images/beastie-right.svg" width="160" height="250" alt="FreeBSD logo" />
      <div class="theme-container">
        <label for="theme-switch" class="theme-switch-label">
          <span class="theme-switch-label">Switch color theme</span>
          <i class="fa fa-moon-o theme-icon theme-icon-dark" aria-hidden="true"></i>
          <i class="fa fa-sun-o theme-icon theme-icon-light" aria-hidden="true"></i>
        </label>
      </div>
      </section>
      <section class="about-column">
        <h3 class="column-title">About</h3>
        <ul class="column-elements-container">
          <li>
            <a href="$hsty_base/about" class="column-element">FreeBSD</a>
          </li>
          <li>
            <a href="https://freebsdfoundation.org/" class="column-element">FreeBSD Foundation</a>
          </li>
          <li>
            <a href="https://freebsdfoundation.org/our-work/journal/" class="column-element">FreeBSD Journal</a>
          </li>
          <li>
            <a href="$hsty_base/where" class="column-element">Get FreeBSD</a>
          </li>
          <li>
            <a href="$hsty_base/internal/code-of-conduct" class="column-element">Code of Conduct</a>
          </li>
          <li>
            <a href="$hsty_base/security" class="column-element">Security Advisories</a>
          </li>
        </ul>
      </section>
      <section class="documentation-column">
        <h3 class="column-title">Documentation</h3>
        <ul class="column-elements-container">
          <li>
            <a href="https://docs.freebsd.org" class="column-element">Documentation portal</a>
          </li>
          <li>
            <a href="https://man.FreeBSD.org" target="_blank" class="column-element">Manual pages</a>
          </li>
          <li>
            <a href="https://ports.freebsd.org" target="_blank" class="column-element">Ported Applications</a>
          </li>
          <li>
            <a href="https://papers.FreeBSD.org" target="_blank" class="column-element">Presentations and papers</a>
          </li>
          <li>
            <a href="https://wiki.freebsd.org/" target="_blank" class="column-element">Wiki</a>
          </li>
        </ul>
      </section>
      <section class="community-column">
        <h3 class="column-title">Community</h3>
        <ul class="column-elements-container">
          <li>
            <a href="https://docs.FreeBSD.org/en/articles/contributing" class="column-element">Get involved</a>
          </li>
          <li>
            <a href="https://forums.freebsd.org/" target="_blank" class="column-element">Community forum</a>
          </li>
          <li>
            <a href="https://lists.freebsd.org/" target="_blank" class="column-element">Mailing lists</a>
          </li>
          <li>
            <a href="https://wiki.freebsd.org/IRC/Channels" target="_blank" class="column-element">IRC Channels</a>
          </li>
          <li>
            <a href="https://bugs.freebsd.org/bugzilla/" target="_blank" class="column-element">Bug Tracker</a>
          </li>
        </ul>
      </section>
      <section class="legal-column">
        <h3 class="column-title">Legal</h3>
        <ul class="column-elements-container">
          <li>
            <a href="$hsty_base/contact" class="column-element">Contact</a>
          </li>
          <li>
            <a href="https://freebsdfoundation.org/donate/" target="_blank" class="column-element">Donations</a>
          </li>
          <li>
            <a href="$hsty_base/copyright" class="column-element">Licensing</a>
          </li>
          <li>
            <a href="$hsty_base/privacy" class="column-element">Privacy Policy</a>
          </li>
        </ul>
      </section>
      <section class="copyright-column">
        <p>&copy; 1994-2026 The FreeBSD Project. All rights reserved</p>
        <span>Made with <span class="heart">❤️</span> by the FreeBSD Community</span>
      </section>
  </div>
</footer>

      </div>
    </div>
  </body>
</html>
`;

}

sub get_the_source {
    return if $ENV{'PATH_INFO'} ne '/get_the_source';

    open( R, $0 ) || do {
        print "Oops! open $0: $!\n";    # should not reached
        exit;
    };

    print "Content-type: text/plain\n\n";
    while (<R>) { print }
    close R;
    exit;
}

1;
