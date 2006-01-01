<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD$
     $FreeBSDde: de-www/includes.xsl,v 1.26 2006/01/01 10:20:00 jkois Exp $
     basiert auf: 1.20
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../share/sgml/includes.xsl" />
  <xsl:variable name="url.doc.langcode" select="'de_DE.ISO8859-1'" />

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="enbase" select="'..'"/>
  <xsl:variable name="debase" select="'http://www.freebsd.de'"/>

  <xsl:variable name="i.daemon">
    <img src="{$enbase}/gifs/daemon.gif" alt="" align="left" width="80" height="76"/>
  </xsl:variable>

  <xsl:variable name="i.new">
    <img src="{$enbase}/gifs/new.gif" alt="[Neu!]" width="28" height="11"/>
  </xsl:variable>

  <xsl:variable name="copyright">
    <a href="{$enbase}/copyright/index.html">Copyright</a> &#169; 1995-2006
    Das FreeBSD Projekt.  Alle Rechte vorbehalten.
  </xsl:variable>

  <xsl:variable name="email" select="'freebsd-questions'"/>
  <xsl:variable name="author">
    <a>
      <xsl:attribute name="href">
	<xsl:value-of select="concat($enbase, '/mailto.html')"/>
      </xsl:attribute>
      <xsl:value-of select="$email"/>@FreeBSD.org</a><br/><xsl:copy-of select="$copyright"/>
  </xsl:variable>

  <xsl:variable name="home">
    <a href="{$base}/index.html"><img src="{$enbase}/gifs/home.gif" alt="FreeBSD Home Page" border="0" align="right" width="101" height="33"/></a>
  </xsl:variable>

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
      					Schriftgr&#246;&#223;e: <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Normal Text'); return false;" title="Normale Schrift">Normal</a> / <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Large Text'); return false;" title="Gro&#223;e Schrift">Gro&#223;</a>
      				  </li>
      				  <li>
      					<a href="{$enbase}/donations/" title="Spenden">Spenden</a>
      				  </li>
      				  <li class="last-child">
      					<a href="{$base}/mailto.html" title="Kontakt">Kontakt</a>
      				  </li>
      				</ul>
      			  </div> <!-- searchnav -->
      			<div id="search">
      			  <form action="{$enbase}/cgi/search.cgi" method="get">
      				<div>
      			      <h2 class="blockhide"><label for="words">Suche</label></h2>
      				  <input type="hidden" name="max" value="25" /> <input type="hidden" name="source" value="www" /><input id="words" name="words" type="text" size="20" maxlength="255" onfocus="if( this.value==this.defaultValue ) this.value='';" value="Suche" />&#160;<input id="submit" name="submit" type="submit" value="Suche" />
      				</div>
      			  </form>
      			</div> <!-- search -->
                </div> <!-- headerlogoright -->

              </div> <!-- header -->

        	<h2 class="blockhide">Site Navigation</h2>
              <div id="topnav">
                <ul id="topnavlist">
		  <li>
			<a href="{$base}/" title="Startseite">Startseite</a>
		  </li>
		  <li>
			<a href="{$base}/about.html" title="&#220;ber FreeBSD">&#220;ber FreeBSD</a>
		  </li>
		  <li>
			<a href="{$base}/where.html" title="FreeBSD Bezugsquellen">FreeBSD Bezugsquellen</a>
		  </li>
		  <li>
			<a href="{$base}/docs.html" title="Dokumentation">Dokumentation</a>
		  </li>
		  <li>
			<a href="{$enbase}/community.html" title="Community">Community</a>
		  </li>
		  <li>
			<a href="{$enbase}/projects/index.html" title="Entwicklung">Entwicklung</a>
		  </li>
		  <li>
			<a href="{$base}/support.html" title="Hilfe">Hilfe</a>
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
		<li><a href="{$base}/about.html">&#220;ber FreeBSD</a></li>
		<li><a href="{$base}/features.html">Eigenschaften</a></li>
		<li><a href="{$base}/applications.html">Anwendungen</a></li>
		<li><a href="{$base}/internet.html">Netzwerkfunktionen</a></li>
		<li><a href="{$enbase}/advocacy/">FreeBSD bewerben</a></li>
		<li><a href="{$enbase}/marketing/">Marketing</a></li>
		<li><a href="{$base}/news/newsflash.html">Neuigkeiten</a></li>
		<li><a href="{$enbase}/events/events.html">Veranstaltungen</a></li>
		<li><a href="{$base}/news/press.html">Aus der Presse</a></li>
		<li><a href="{$enbase}/art.html">Kunst</a></li>
		<li><a href="{$enbase}/donations/">Spenden</a></li>
		<li><a href="{$enbase}/copyright/">Rechtliches</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'community'" >
		<ul>
		<li><a href="{$enbase}/community.html">Community</a></li>
		<!--li><a href="{$base}/community/mailinglists.html"> Mailinglisten</a></li>
		<li><a href="{$base}/community/irc.html">IRC</a></li>
		<li><a href="{$base}/community/newsgroups.html">Newsgroups</a></li>
		<li><a href="{$base}/usergroups.html">Benutzergruppen</a></li>
		<li><a href="{$base}/community/webresources.html">Web Ressourcen</a></li-->
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'developers'" >
		<ul>
		<li><a href="{$enbase}/projects/index.html">Entwicklung</a></li>
		<li><a href="{$enbase}/doc/en_US.ISO8859-1/books/developers-handbook">Developer&#39;s Handbook</a></li>
		<li><a href="{$enbase}/doc/en_US.ISO8859-1/books/porters-handbook">Porter&#39;s Handbook</a></li>
		<li><a href="{$base}/support.html#cvs">CVS Repository</a></li>
		<li><a href="{$base}/releng/index.html">Release Engineering</a></li>
		<li><a href="{$base}/platforms/">Plattformen</a>
			<ul>
				<li><a href="{$base}/platforms/alpha.html">alpha</a></li>
				<li><a href="{$base}/platforms/amd64.html">amd64</a></li>
				<li><a href="{$base}/platforms/i386.html">i386</a></li>
				<li><a href="{$base}/platforms/ia64/index.html">ia64</a></li>
				<li><a href="{$base}/platforms/pc98.html">pc98</a></li>
				<li><a href="{$base}/platforms/ppc.html">ppc</a></li>
				<li><a href="{$base}/platforms/sparc.html">sparc64</a></li>
			</ul>
		</li>
		<li><a href="{$enbase}/doc/{$url.doc.langcode}/articles/contributing/index.html">FreeBSD unterst&#252;tzen</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'docs'" >
		<ul>
		<li><a href="{$base}/docs.html">Dokumentation</a></li>
		<li><a href="{$enbase}/doc/{$url.doc.langcode}/books/faq/">FAQ</a></li>
		<li><a href="{$enbase}/doc/{$url.doc.langcode}/books/handbook/">Handbuch</a></li>
		<li><a href="{$base}/docs.html#man">Manual-Pages</a>
			<ul>
				<li><a href="{$enbase}/cgi/man.cgi">Manual-Pages (Online)</a></li>
			</ul>
		</li>
		<li><a href="{$base}/docs.html#books">B&#252;cher und Artikel (Online)</a></li>
		<li><a href="{$enbase}/publish.html">Publikationen</a></li>
		<li><a href="{$base}/docs.html#links">Internet-Ressourcen</a></li>
		<li><a href="{$base}/projects/newbies.html">F&#252;r Einsteiger</a></li>
		<li><a href="{$enbase}/docproj/">Documentation Project</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'download'" >
		<ul>
		<li><a href="{$base}/where.html">FreeBSD Bezugsquellen</a></li>
		<li><a href="{$base}/releases/">Release Informationen</a>
			<ul>
				<li><a href="{$u.rel.announce}">Produktionsreife: <xsl:value-of select="$rel.current"/></a></li>
				<li><a href="{$u.rel2.announce}">Ausgereift: <xsl:value-of select="$rel2.current"/></a></li>
				<li><a href="{$base}/snapshots/">Snapshot Releases</a></li>
			</ul>
		</li>
		<li><a href="{$enbase}/ports/">Anwendungen (Ports)</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'support'" >
		<ul>
		<li><a href="{$base}/support.html">Hilfe</a></li>
		<li><a href="{$enbase}/commercial/">Anbieter</a>
			<ul>
				<li><a href="{$enbase}/commercial/software_bycat.html">Software</a></li>
				<li><a href="{$enbase}/commercial/hardware.html">Hardware</a></li>
				<li><a href="{$enbase}/commercial/consult_bycat.html">Beratung</a></li>
				<li><a href="{$enbase}/commercial/isp.html">Internet Service Providers</a></li>
				<li><a href="{$enbase}/commercial/misc.html">Verschiedenes</a></li>
			</ul>
		</li>
		<li><a href="{$base}/security/">Sicherheit</a></li>
		<li><a href="{$base}/support.html#gnats">Fehlerberichte</a>
			<ul>
				<li><a href="{$enbase}/send-pr.html">Einreichen</a></li>
			</ul>
		</li>
		<li><a href="{$base}/support.html#general">Internetressourcen</a></li>
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

  <xsl:variable name="rel.current" select='"6.0"'/>
  <xsl:variable name="u.rel.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel.announce">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel.installation">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/installation.html</xsl:variable>
  <xsl:variable name="u.rel.readme">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/readme.html</xsl:variable>
  <xsl:variable name="u.rel.migration">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/migration-guide.html</xsl:variable>

  <xsl:variable name="rel2.current" select='"5.4"'/>
  <xsl:variable name="u.rel2.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel2.announce">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel2.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel2.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel2.installation">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/installation.html</xsl:variable>
  <xsl:variable name="u.rel2.readme">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/readme.html</xsl:variable>
</xsl:stylesheet>
