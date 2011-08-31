<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD Fragment//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>
<!--
     $FreeBSD$
     $FreeBSDde: de-www/index.xsl,v 1.92 2011/08/31 16:09:40 jkois Exp $
     basiert auf: 1.174
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

  <xsl:output type="html" encoding="iso-8859-1"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title>&title;</title>

	<meta name="description" content="The FreeBSD Project"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Ports,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="&enbase;/favicon.ico" type="image/x-icon"/>

<!--
FUER UEBERSETZER - ACHTUNG:

Die zwei Attribute "Normal Text" und "Large Text" in den beiden naechsten
Zeilen NICHT uebersetzen!  Es handelt sich dabei nicht um Text, sondern um
JavaScript-Parameter.  Eine Uebersetzung dieser Parameter fuehrt zu
Problemen bei der Darstellung der Webseiten.
-->

	<link rel="stylesheet" media="screen" href="&enbase;/layout/css/fixed.css?20060509" type="text/css" title="Normal Text" />
	<link rel="alternate stylesheet" media="screen" href="&enbase;/layout/css/fixed_large.css" type="text/css" title="Large Text" />
	<script type="text/javascript" src="&enbase;/layout/js/styleswitcher.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Ank&#252;ndigungen" href="&enbase;/news/news.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Sicherheits-Hinweise" href="&enbase;/security/advisories.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="Ank&#252;ndigungen des FreeBSD GNOME Projects"
	  href="&enbase;/gnome/news.rdf" />

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
				<h1>
				  Auf BSD UNIX&reg; basierend
				</h1>
				<p>FreeBSD&reg; ist ein modernes Betriebssystem f&#252;r
				  Server, Desktops und eingebettete Systeme, das auf
				  zahlreichen <a
				  href="&base;/platforms/index.html">Plattformen</a>
				  l&#228;uft.  Der Quellcode von FreeBSD wird seit
				  mehr als 30 Jahren kontinuierlich weiterentwickelt,
				  verbessert und optimiert.  Das System wird
				  von einer <a
				  href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">
				  gro&#223;en Entwicklergruppe</a> gepflegt und erweitert.
				  FreeBSD bietet Ihnen leistungsf&#228;hige
				  und beeindruckende Netzwerk- und
				  Sicherheitsfunktionen und eine exzellente
				  Performance und wird deswegen beispielsweise von
				  einigen der gr&#246;&#223;ten <a
				  href="&enbase;/doc/&url.doc.langcode;/books/handbook/nutshell.html#INTRODUCTION-NUTSHELL-USERS">
				  Internet-Seiten</a> und von zahlreichen Anbietern
				  eingebetteter Netzwerk- und Speicherger&#228;te
				  eingesetzt.</p>

				  <div id="TXTFRONTFEATURELINK"> &#187;<a
				    href="&base;/about.html" title="Learn More">Mehr Informationen</a>
				  </div> <!-- TXTFRONTFEATURELINK -->
			</div> <!-- FRONTFEATURECONTENT -->
		</div> <!-- FRONTFEATURELEFT -->

		<div id="FRONTFEATUREMIDDLE">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div>&nbsp;</div>&nbsp;</div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">FreeBSD beziehen</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div>&nbsp;</div>&nbsp;</div>
			</div> <!-- frontgetroundbox -->

			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
				  <h2><a href="&base;/releases/">AKTUELLE VERSIONEN</a></h2>
				  <ul id="FRONTRELEASESLIST">
					<li>
					  <a href="&u.rel.announce;">Produktion:&nbsp;&rel.current;</a>
					</li>
					<li>
					  <a href="&u.rel2.announce;">Produktion (alt):&nbsp;&rel2.current;</a>
					</li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
					  <li>
					    <a href="&base;/where.html#helptest">Test:&nbsp;
					      &betarel.current;-&betarel.vers;</a>
					  </li>
			    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
					  <li>
					    <a href="&base;/where.html#helptest">Test:&nbsp;
					      &betarel2.current;-&betarel2.vers;</a>
					  </li>
			    </xsl:if>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="FRONTFEATURERIGHT">
			<h2 class="blockhide">Sprachauswahl</h2>
			<div id="LANGUAGENAV">
				<ul id="LANGUAGENAVLIST">
				  <li>
					<a href="&enbase;/de/" title="Deutsch">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="Englisch">en</a>
				  </li>
				  <li>
					<a href="&enbase;/es/" title="Spanisch">es</a>
				  </li>
				  <li>
					<a href="&enbase;/fr/" title="Franz&#246;sisch">fr</a>
				  </li>
				  <li>
					<a href="&enbase;/hu/" title="Ungarisch">hu</a>
				  </li>
				  <li>
					<a href="&enbase;/it/" title="Italienisch">it</a>
				  </li>
				  <li>
					<a href="&enbase;/nl/" title="Holl&#228;ndisch">nl</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="Japanisch">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/ru/" title="Russisch">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_CN/" title="Chinesisch (vereinfacht)">zh_CN</a>
				  </li>
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="MIRROR">
			  <form action="&cgibase;/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="MIRRORSEL">Mirror</label></h2>
				  <select id="MIRRORSEL" name="goto">
					  <xsl:call-template name="html-index-mirrors-options-list">
					    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
					  </xsl:call-template>
				  </select>
				</div> <!-- unnamed -->
				<input type="submit" value="OK" />
			  </form>
			</div> <!-- MIRROR -->

			<div id="FRONTSHORTCUTS">
			  <div id="FRONTSHORTCUTSCONTENT" class="txtshortcuts">
				  <h2>SHORTCUTS</h2>
				  <ul id="FRONTSHORTCUTSLIST">
					<li>
					  <a href="&base;/community/mailinglists.html" title="Mailinglisten">Mailinglisten</a>
					</li>
					<li>
					  <a href="&base;/support/bugreports.html" title="Einen Fehler melden">
					    Einen Fehler melden</a>
					</li>
					<li>
					  <a href="&enbase;/doc/&url.doc.langcode;/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/index.html" title="Handbook">Handbuch</a>
                                        </li>
					<li>
					  <a href="&base;/ports/index.html" title="Ports">Ports-Sammlung</a>
					</li>
				  </ul>
			  </div> <!-- FRONTSHORTCUTSCONTENT -->
			</div> <!-- FRONTSHORTCUTS -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div>&nbsp;</div>&nbsp;</div>
			    <div class="frontnewcontent">
			      <a href="&base;/projects/newbies.html">FreeBSD-Einsteiger?</a>
			    </div> <!-- frontnewCONTENT -->
			  <div class="frontnewbot"><div>&nbsp;</div>&nbsp;</div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- featureright -->

            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="FRONTNEMSCONTAINER">
            	<div id="FRONTNEWS">
            	   <div id="FRONTNEWSCONTENT" class="txtnewsevent">
			<h2>NEUIGKEITEN</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/news/newsflash.html" title="Weitere Neuigkeiten">Weitere Neuigkeiten</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/news/news.rdf" title="News RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTEVENTS">
		   <div id="FRONTEVENTSCONTENT" class="txtnewsevent">

			<h2>VERANSTALTUNGEN</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&enbase;/events/" title="Weitere Veranstaltungen">Weitere Veranstaltungen</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTMEDIA">
		   <div id="FRONTMEDIACONTENT" class="txtnewsevent">

			<h2>AUS DER PRESSE</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&base;/news/press.html" title="Weitere Berichte">Weitere Berichte</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
            	</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="FRONTSECURITY">
		   <div id="FRONTSECURITYCONTENT" class="txtnewsevent">

			<h2>SICHERHEITS-HINWEISE</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&enbase;/security/advisories.html" title="Weitere Security Advisories">Mehr</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/security/rss.xml" title="Security Advisories RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>FEHLER-HINWEISE</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			</xsl:call-template>

			<div>
			  <ul class="newseventslist">
			    <li class="first-child">
			      <a href="&enbase;/security/notices.html" title="Weitere Errata-Hinweise">Mehr</a>
			    </li>
			    <li class="last-child">
			      <a href="&enbase;/security/errata.xml" title="Errata Notices RSS Feed">
				<img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27"
				height="12" alt="Errata Notices RSS Feed" /></a>
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
      <div id="footer">
        &copyright;

	Die Marke FreeBSD ist ein registriertes Warenzeichen der
	FreeBSD Foundation und wird vom FreeBSD Project mit Erlaubnis
	der <a
	href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">
	FreeBSD Foundation</a> verwendet.

      </div> <!-- footer -->
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
