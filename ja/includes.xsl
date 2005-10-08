<?xml version="1.0" encoding="EUC-JP" ?>

<!-- $FreeBSD: www/ja/includes.xsl,v 1.29 2005/10/04 17:15:06 hrs Exp $ -->
<!-- Original revision: 1.20 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../share/sgml/includes.xsl" />

  <xsl:variable name="url.doc.langcode" select="'ja_JP.eucJP'" />

  <!-- default format for date string -->
  <xsl:param name="param-l10n-date-format-YMD"
             select="'%Y 年 %M %D 日'" />
  <xsl:param name="param-l10n-date-format-YM"
             select="'%Y 年 %M'" />
  <xsl:param name="param-l10n-date-format-MD"
             select="'%M %D 日'" />

  <xsl:variable name="section" select="''"/>

  <xsl:variable name="header1">
    <head><title><xsl:value-of select="$title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <meta name="MSSmartTagsPreventParsing" content="TRUE" />
    <link rel="shortcut icon" href="{$enbase}/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="{$enbase}/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" media="screen" href="{$enbase}/layout/css/fixed.css" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="{$enbase}/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="{$enbase}/layout/js/styleswitcher.js"></script>
    </head>
  </xsl:variable>

  <xsl:variable name="header2">
            <span class="txtoffscreen"><a href="#content" title="Skip site navigation" accesskey="1">Skip site navigation</a> (1)</span>
            <span class="txtoffscreen"><a href="#contentwrap" title="Skip section navigation" accesskey="2">Skip section navigation</a> (2)</span>
            <div id="headercontainer">

              <div id="header">
      	      <h2 class="blockhide">Header And Logo</h2>
                <div id="headerlogoleft">
                  <a href="{$base}" title="FreeBSD"><img src="{$enbase}/layout/images/logo.png" width="360" height="40" alt="FreeBSD" /></a>
                </div> <!-- headerlogoleft -->
                <div id="headerlogoright">
      			<h2 class="blockhide">Peripheral Links</h2>
      			  <div id="searchnav">
      				<ul id="searchnavlist">
      				  <li>
      					文字サイズ: <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Normal Text'); return false;" title="Normal Text Size">中</a> / <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Large Text'); return false;" title="Large Text Size">大</a>
      				  </li>
      				  <li>
      					<a href="{$enbase}/donations/" title="寄付・寄贈">寄付・寄贈</a>
      				  </li>
      				  <li class="last-child">
      					<a href="{$base}/mailto.html" title="Contact">連絡先</a>
      				  </li>
      				</ul>
      			  </div> <!-- searchnav -->
      			<div id="search">
      			  <form action="{$enbase}/cgi/search.cgi" method="get">
      				<div>
      			      <h2 class="blockhide"><label for="words">Search</label></h2>
      				  <input type="hidden" name="max" value="25" /> <input type="hidden" name="source" value="www" /><input id="words" name="words" type="text" size="20" maxlength="255" onfocus="if( this.value==this.defaultValue ) this.value='';" value="Search" />&#160;<input id="submit" name="submit" type="submit" value="Search" />
      				</div>
      			  </form>
      			</div> <!-- search -->
                </div> <!-- headerlogoright -->

              </div> <!-- header -->

        	<h2 class="blockhide">Site Navigation</h2>
              <div id="topnav">
                <ul id="topnavlist">
		  <li>
			<a href="{$base}/" title="Home">ホーム</a>
		  </li>
		  <li>
			<a href="{$base}/about.html" title="About">FreeBSD とは</a>
		  </li>
		  <li>
			<a href="{$base}/where.html" title="Get FreeBSD">FreeBSD の入手</a>
		  </li>
		  <li>
			<a href="{$base}/docs.html" title="ドキュメント">ドキュメント</a>
		  </li>
		  <li>
			<a href="{$base}/community.html" title="Community">コミュニティ</a>
		  </li>
		  <li>
			<a href="{$base}/projects/index.html" title="開発">開発</a>
		  </li>
		  <li>
			<a href="{$base}/support.html" title="サポート">サポート</a>
		  </li>
		</ul>
              </div> <!-- topnav -->
            </div> <!-- headercontainer -->
  </xsl:variable>

  <xsl:variable name="header3">
  	<h1><xsl:value-of select="$title"/></h1>
  </xsl:variable>

  <xsl:variable name="sidenav">
	<div id="sidewrap">

	<div id="sidenav">
	<h2 class="blockhide">Section Navigation</h2>

	<xsl:if test="$section = 'about'" >
		<ul>
		<li><a href="{$base}/about.html">About</a></li>
		<li><a href="{$base}/features.html">Features</a></li>
		<li><a href="{$base}/applications.html">Applications</a></li>
		<li><a href="{$base}/internet.html">Internetworking</a></li>
		<li><a href="{$enbase}/advocacy/">Advocacy</a></li>
		<li><a href="{$enbase}/marketing/">Marketing</a></li>
		<li><a href="{$base}/news/newsflash.html">News</a></li>
		<li><a href="{$enbase}/events/events.html">Events</a></li>
		<li><a href="{$base}/news/press.html">Press</a></li>
		<li><a href="{$enbase}/art.html">Artwork</a></li>
		<li><a href="{$enbase}/donations/">Donations</a></li>
		<li><a href="{$base}/copyright/">Legal Notices</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'community'" >
		<ul>
		<li><a href="{$enbase}/community.html">Community</a></li>
		<!--li><a href="{$base}/community/mailinglists.html">Mailing Lists</a></li>
		<li><a href="{$base}/community/irc.html">IRC</a></li>
		<li><a href="{$base}/community/newsgroups.html">Newsgroups</a></li>
		<li><a href="{$base}/usergroups.html">User Groups</a></li>
		<li><a href="{$base}/community/webresources.html">Web Resources</a></li-->
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'developers'" >
		<ul>
		<li><a href="{$base}/projects/index.html">Developers</a></li>
		<li><a href="{$base}/doc/en_US.ISO8859-1/books/developers-handbook">Developer&#39;s Handbook</a></li>
		<li><a href="{$base}/doc/{$url.doc.langcode}/books/porters-handbook">Porter&#39;s Handbook</a></li>
		<li><a href="{$base}/support.html#cvs">CVS Repository</a></li>
		<li><a href="{$enbase}/releng/index.html">Release Engineering</a></li>
		<li><a href="{$base}/platforms/">Platforms</a>
			<ul>
				<li><a href="{$base}/platforms/alpha.html">alpha</a></li>
				<li><a href="{$base}/platforms/amd64.html">amd64</a></li>
				<li><a href="{$base}/smp/">i386</a></li>
				<li><a href="{$base}/platforms/ia64.html">ia64</a></li>
				<li><a href="{$base}/platforms/pc98.html">pc98</a></li>
				<li><a href="{$base}/platforms/sparc.html">sparc64</a></li>
			</ul>
		</li>
		<li><a href="{$base}/doc/{$url.doc.langcode}/articles/contributing/index.html">Contributing</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'docs'" >
		<ul>
		<li><a href="{$base}/docs.html">Documentation</a></li>
		<li><a href="{$base}/doc/{$url.doc.langcode}/books/faq/">FAQ</a></li>
		<li><a href="{$base}/doc/{$url.doc.langcode}/books/handbook/">Handbook</a></li>
		<li><a href="{$base}/docs.html#man">Manual Pages</a>
			<ul>
				<li><a href="{$enbase}/cgi/man.cgi">Man Online</a></li>
			</ul>
		</li>
		<li><a href="{$base}/docs.html#books">Books and Articles Online</a></li>
		<li><a href="{$base}/publish.html">Publications</a></li>
		<li><a href="{$base}/docs.html#links">Web Resources</a></li>
		<li><a href="{$base}/projects/newbies.html">For Newbies</a></li>
		<li><a href="{$base}/docproj/">Documentation Project</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'download'" >
		<ul>
		<li><a href="{$base}/where.html">Get FreeBSD</a></li>
		<li><a href="{$base}/releases/">Release Information</a>
			<ul>
				<li><a href="{$u.rel.announce}">Production Release: {$rel.current}</a></li>
				<li><a href="{$u.rel2.announce}">Production (Legacy) Release:  {$rel2.current}</a></li>
				<li><a href="{$enbase}/snapshots/">Snapshot Releases</a></li>
			</ul>
		</li>
		<li><a href="{$base}/ports/">Ported Applications</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'support'" >
		<ul>
		<li><a href="{$base}/support.html">Support</a></li>
		<li><a href="{$base}/commercial/">Vendors</a>
			<ul>
				<li><a href="{$enbase}/commercial/software_bycat.html">Software</a></li>
				<li><a href="{$enbase}/commercial/hardware.html">Hardware</a></li>
				<li><a href="{$enbase}/commercial/consult_bycat.html">Consulting</a></li>
				<li><a href="{$enbase}/commercial/isp.html">Internet Service Providers</a></li>
				<li><a href="{$enbase}/commercial/misc.html">Miscellaneous</a></li>
			</ul>
		</li>
		<li><a href="{$base}/security/">Security Information</a></li>
		<li><a href="{$base}/support.html#gnats">Bug Reports</a>
			<ul>
				<li><a href="{$base}/send-pr.html">Submit a Problem Report</a></li>
			</ul>
		</li>
		<li><a href="{$base}/support.html#general">Web Resources</a></li>
		</ul>
	</xsl:if>

	</div> <!-- sidenav -->

	</div> <!-- sidewrap -->
  </xsl:variable>

  <xsl:variable name="footer">
	<div id="footer">
	<xsl:copy-of select="$copyright"/><br />
	<xsl:copy-of select="$date"/>
	</div> <!-- footer -->
  </xsl:variable>

  <xsl:variable name="u.rel.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel.announce">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/announce.html</xsl:variable>

  <xsl:variable name="u.rel.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/errata.html</xsl:variable>

  <xsl:variable name="u.rel.installation">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/installation.html</xsl:variable>

  <xsl:variable name="u.rel.early">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/early-adopter.html</xsl:variable>

  <xsl:variable name="u.rel.migration">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/migration-guide.html</xsl:variable>

<!--
  <xsl:variable name="u.rel2.notes">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/relnotes.html</xsl:variable>
-->

<!--
  <xsl:variable name="u.rel2.announce">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/announce.html</xsl:variable>
-->

  <xsl:variable name="u.rel2.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/errata.html</xsl:variable>

  <xsl:variable name="u.rel2.installation">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/installation.html</xsl:variable>

</xsl:stylesheet>
