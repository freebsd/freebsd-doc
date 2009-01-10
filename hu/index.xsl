<?xml version="1.0" encoding="ISO-8859-2" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "A &os; Projekt">
]>

<!-- $FreeBSD: www/hu/index.xsl,v 1.14 2008/12/22 15:42:11 pgj Exp $ -->

<!-- FreeBSD Hungarian Documentation Project
     Translated by: Gabor Kovesdan <gabor@FreeBSD.org>
     %SOURCE%	en/index.xsl
     %SRCID%	1.167
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="advisories.xml" select="'none'"/>
  <xsl:param name="notices.xml" select="'none'"/>
  <xsl:param name="mirrors.xml" select="'none'"/>
  <xsl:param name="news.press.xml-master" select="'none'"/>
  <xsl:param name="news.press.xml" select="'none'"/>
  <xsl:param name="news.project.xml-master" select="'none'"/>
  <xsl:param name="news.project.xml" select="'none'"/>
  <xsl:param name="events.xml-master" select="'none'"/>
  <xsl:param name="events.xml" select="'none'"/>

  <xsl:output type="html" encoding="&xml.encoding;"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title>&title;</title>
	<meta name="description" content="A FreeBSD Projekt"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Ports,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" media="screen" href="&enbase;/layout/css/fixed.css?20060509" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="&enbase;/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="&enbase;/layout/js/styleswitcher.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Projekt H&iacute;rek" href="&base;/news/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Biztons&aacute;gi Bejelent&eacute;sek" href="&enbase;/security/rss.xml" />
	
	<!-- Formatted to be easy to spam harvest, please do not reformat. -->
	<xsl:comment>
        Spamtrap, do not email:
        &lt;a href="mailto:bruscar@freebsd.org"&gt;bruscar@freebsd.org&lt;/a&gt;
	</xsl:comment>
      </head>

      <body>

   <div id="CONTAINERWRAP">
    <div id="CONTAINER">
      &header2;
      <div id="CONTENT">

        <div id="FRONTCONTAINER">
          <div id="FRONTMAIN">
            <div id="FRONTFEATURECONTAINER">

		<div id="FRONTFEATURELEFT">
			<div id="FRONTFEATURECONTENT">
				<h1>A BSD &unix; alapjain</h1>

				<p>A &os;&reg; napjaink szerver, asztali
				  &eacute;s be&aacute;gyazott <a
				  href="&base;/platforms/">sz&aacute;m&iacute;t&oacute;g&eacute;peinek</a>
				  oper&aacute;ci&oacute;s rendszere.  A
				  &os; k&oacute;db&aacute;zisa t&ouml;bb
				  mint harminc &eacute;v folyamatos
				  fejleszt&eacute;s&eacute;nek,
				  munk&aacute;j&aacute;nak &eacute;s
				  optimaliz&aacute;l&aacute;s&aacute;nak
				  eredm&eacute;nye.  Jelenleg <a
				    href="&base;/doc/en/articles/contributors/staff-committers.html">egyéni
				    fejleszt&#245;k egy nagyobb csoportja</a>
				  tartja karban.  A &os; legfontosabb
				  jellemz&#245;i t&ouml;bbek k&ouml;zt a
				  fejlett
				  h&aacute;l&oacute;zatkezel&eacute;s, a
				  kifinomult biztons&aacute;gi
				  lehet&#245;s&eacute;gek &eacute;s a
				  vil&aacute;gsz&iacute;nvonal&uacute;
				  teljes&iacute;tm&eacute;ny, amelyet a
				  vil&aacute;gban <a
				    href="&base;/doc/en/books/handbook/nutshell.html/#INTRODUCTION-NUTSHELL-USERS">sz&aacute;mos forgalmasabb kiszolg&aacute;l&oacute;</a>,
				  hat&eacute;kony be&aacute;gyazott
				  rendszer &eacute;s
				  t&aacute;rol&oacute;eszk&ouml;z
				  haszn&aacute;l.</p>

				<div id="TXTFRONTFEATURELINK"> &#187;
				  <a href="&base;/about.html" title="B&#245;vebben">B&#245;vebben</a>
				</div> <!-- TXTFRONTFEATURELINK -->
			</div> <!-- FRONTFEATURECONTENT -->
		</div> <!-- FRONTFEATURELEFT -->

		<div id="FRONTFEATUREMIDDLE">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Let&ouml;lt&eacute;s</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
				  <h2><a href="&enbase;/releases/">FRISS KIAD&Aacute;SOK</a></h2>
				  <ul id="FRONTRELEASESLIST">
					<li>
					  <a
					    href="&u.rel.announce;">Stabil kiad&aacute;s: &rel.current;</a>
					</li>
					<li>
					  <a
					    href="&u.rel2.announce;">Stabil (hagyom&aacute;nyos) kiad&aacute;s: &rel2.current;</a>
					</li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
					<li>
					  <a
					    href="&base;/where.html#helptest">K&ouml;vetkez&#245; kiad&aacute;s: &betarel.current; - &betarel.vers;</a>
					</li>
			    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
					<li>
					  <a
					    href="&base;/where.html#helptest">K&ouml;vetkez&#245; kiad&aacute;s: &betarel2.current; - &betarel2.vers;</a>
					</li>
			    </xsl:if>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="FRONTFEATURERIGHT">
			<h2 class="blockhide">Nyelvek</h2>
			<div id="LANGUAGENAV">
				<ul id="LANGUAGENAVLIST">
				  <li>
					<a href="&enbase;/de/" title="N&eacute;met">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="Angol">en</a>
				  </li>
				  <li>
					<a href="&enbase;/es/" title="Spanyol">es</a>
				  </li>
				  <li>
					<a href="&enbase;/fr/" title="Francia">fr</a>
				  </li>
				  <li>
					<a href="&base;/" title="Magyar">hu</a>
				  </li>
				  <li>
					<a href="&enbase;/it/" title="Olasz">it</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="Jap&aacute;n">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/ru/" title="Orosz">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_CN/" title="K&iacute;nai (Egyszer&#251;s&iacute;tett)">zh_CN</a>
				  </li>
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="MIRROR">
			  <form action="&cgibase;/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="MIRRORSEL">T&uuml;kr&ouml;z&eacute;sek</label></h2>
				  <select id="MIRRORSEL" name="goto">
					  <xsl:call-template name="html-index-mirrors-options-list">
					    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
					  </xsl:call-template>
				  </select>
				</div> <!-- unnamed -->
				<input type="submit" value="Go" />
			  </form>
			</div> <!-- MIRROR -->

			<div id="FRONTSHORTCUTS">
			  <div id="FRONTSHORTCUTSCONTENT" class="txtshortcuts">
				  <h2>GYORSMEN&Uuml;</h2>
				  <ul id="FRONTSHORTCUTSLIST">
					<li>
					  <a
					    href="&base;/community/mailinglists.html" title="Levelez&eacute;si list&aacute;k">Levelez&eacute;si list&aacute;k</a>
					</li>
					<li>
					  <a
					    href="&base;/support/bugreports.html" title="Hibajelent&eacute;sek">Hibajelent&eacute;sek</a>
					</li>
					<li>
					  <a
					    href="&enbase;/doc/hu/books/faq/index.html" title="GYIK">GYIK</a>
					</li>
					<li>
					  <a
					    href="&enbase;/doc/hu/books/handbook/index.html" title="K&eacute;zik&ouml;nyv">K&eacute;zik&ouml;nyv</a>
					</li>
					<li>
					  <a
					    href="&enbase;/ports/index.html" title="Portok">Portok</a>
					</li>

				  </ul>
			  </div> <!-- FRONTSHORTCUTSCONTENT -->
			</div> <!-- FRONTSHORTCUTS -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div><b style="display: none">.</b></div></div>
			    <div class="frontnewcontent">
			      <a
				href="&enbase;/projects/newbies.html">&Uacute;j felhaszn&aacute;l&oacute;?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- FEATURERIGHT -->

            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="FRONTNEMSCONTAINER">
            	<div id="FRONTNEWS">
            	   <div id="FRONTNEWSCONTENT" class="txtnewsevent">
			<h2>FRISS H&Iacute;REK</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a
					  href="&enbase;/news/newsflash.html" title="Tov&aacute;bbi h&iacute;rek">Tov&aacute;bbi h&iacute;rek</a>
				  </li>
				  <li class="last-child">
					<a
					  href="&enbase;/news/rss.xml" title="H&iacute;rek RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="H&iacute;rek RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTEVENTS">
		   <div id="FRONTEVENTSCONTENT" class="txtnewsevent">

			<h2>ESEM&Eacute;NYEK</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a
					  href="&enbase;/events/" title="Tov&aacute;bbi esem&eacute;nyek">Tov&aacute;bbi esem&eacute;nyek</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTMEDIA">
		   <div id="FRONTMEDIACONTENT" class="txtnewsevent">

			<h2>A M&Eacute;DI&Aacute;BAN</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a
					  href="&enbase;/news/press.html" title="Tov&aacute;bb esem&eacute;nyek a m&eacute;di&aacute;ban">Tov&aacute;bb</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
            	</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="FRONTSECURITY">
		   <div id="FRONTSECURITYCONTENT" class="txtnewsevent">

			<h2>BIZTONS&Aacute;GI
			  FIGYELMEZTET&Eacute;SEK</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a
					  href="&enbase;/security/advisories.html" title="Tov&aacute;bbi biztons&aacute;gi figyelmeztet&eacute;sek">Tov&aacute;bb</a>
				  </li>
				  <li class="last-child">
					<a
					  href="&enbase;/security/rss.xml" title="Biztons&aacute;gi figyelmeztet&eacute;sek RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Biztons&aacute;gi figyelmeztet&eacute;sek RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>HIBAJEGYZ&Eacute;K</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			</xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="first-child">
				<a
				  href="&base;/security/" title="M&eacute;g t&ouml;bb sajt&oacute;hiba mutat&aacute;sa">B&#245;vebben</a>
			      </li>
			      <li class="last-child">
				<a href="&base;/security/errata.xml" title="Sajt&oacute;hib&aacute;k RSS feedben"><img class="rssimage" src="&base;/layout/images/ico_rss.png" width="27" height="12" alt="Sajt&oacute;hib&aacute;k RSS feedben"/></a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTSECURITYCONTENT -->
            	</div> <!-- FRONTSECURITY -->

		<br class="clearboth" />

            </div> <!-- FRONTNEMSCONTAINER -->
          </div> <!-- FRONTMAIN -->
        </div> <!-- FRONTCONTAINER -->

      </div> <!-- CONTENT -->
      <div id="FOOTER">
	&copyright;

	A &os; m&aacute;rkan&eacute;v a &os; Alap&iacute;tv&aacute;ny
	tulajdona, a &os; Projekt <a
	  href="http://www.freebsdfoundation.org/legal/guidelines.shtml">A &os; Alap&iacute;tv&aacute;ny</a>
	enged&eacute;ly&eacute;vel haszn&aacute;lja azt.

      </div> <!-- FOOTER -->
    </div> <!-- CONTAINER -->
   </div> <!-- CONTAINERWRAP -->

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

<!--
     Local Variables:
     mode: xml
     sgml-indent-data: t
     sgml-omittag: nil
     sgml-always-quote-attributes: t
     End:
-->
