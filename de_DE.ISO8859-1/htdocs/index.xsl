<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD Fragment//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>
<!--
     $FreeBSD$
     $FreeBSDde$
     basiert auf: 51696
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
    <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

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
  <xsl:param name="html.header.script.google" select="'IGNORE'"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.content">
        <div id="frontcontainer">
          <div id="frontmain">
            <div id="frontfeaturecontainer">

		<div id="frontfeatureleft">
			<div id="frontfeaturecontent">
				<h1>
				  The &os; Project
				</h1>
				<p>FreeBSD&reg; ist ein Betriebssystem f�r
				  Server, Desktops und eingebettete Systeme, das auf
				  zahlreichen <a
				  href="&base;/platforms/index.html">Plattformen</a>
				  l�uft.  Der Quellcode von FreeBSD wird von einer <a
				  href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">
				  gro�en Entwicklergruppe</a> seit mehr als 30 Jahren
				  kontinuierlich weiterentwickelt, verbessert und
				  optimiert.  Seine leistungsf�higen und
				  beeindruckenden Netzwerk-, Sicherheits- und
				  Speicherfunktionen machen &os; zum Betriebssystem
				  der Wahl f�r einige der gr��ten <a
				  href="&enbase;/doc/&url.doc.langcode;/books/handbook/nutshell.html#introduction-nutshell-users">
				  Internet-Seiten</a> und f�r zahlreiche Anbieter
				  eingebetteter Netzwerk- und Speicherger�te.</p>

				  <div id="txtfrontfeaturelink"> �<a
				    href="&base;/about.html" title="Learn More">Mehr Informationen</a>
				  </div> <!-- TXTFRONTFEATURELINK -->

				  <div id="txtfrontjournalblock">
				    <br/>&#187;
				    <span
				     id="txtfrontjournallink">
				      Lesen Sie das <a
				       href="http://www.freebsdjournal.com/"
				       title="&os;&nbsp;Journal">&os;&nbsp;Journal</a>!
				    </span> <!-- TXTFRONTJOURNALLINK -->
				  </div> <!-- TXTFRONTJOURNALBLOCK -->

			  </div> <!-- FRONTFEATURECONTENT -->
		  </div> <!-- FRONTFEATURELEFT -->

		<div id="frontfeaturemiddle">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div>&nbsp;</div>&nbsp;</div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Download FreeBSD</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div>&nbsp;</div>&nbsp;</div>
			</div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2><a href="&base;/releases/">Unterst�tzte Versionen:</a></h2>
				  <ul id="frontreleaseslist">
					<li>
					  Produktion:&nbsp;<a href="&u.rel.announce;">&rel.current;</a>,
					  <a href="&u.rel1.announce;">&rel1.current;</a>
					</li>
			    <xsl:if test="'&beta.upcoming;' != 'IGNORE'">
					<li>Test:&nbsp;<a
				href="&u.betarel.schedule;">&betarel.current;</a></li>
			    </xsl:if>
			    <xsl:if test="'&beta2.upcoming;' != 'IGNORE'">
					<li>Test:&nbsp;<a
				href="&u.betarel2.schedule;">&betarel2.current;</a></li>
			    </xsl:if>
					<li><a
					  href="&base;/security/security.html#sup">FreeBSD
					    Supportzyklus</a></li>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="frontfeatureright">
			<h2 class="blockhide">Sprachauswahl</h2>
			<div id="languagenav">
				<ul id="languagenavlist">
				  <li>
					<a href="&enbase;/de/" title="Deutsch">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="Englisch">en</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="Japanisch">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/zh_CN/" title="Chinesisch (Vereinfacht)">zh_CN</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_TW/" title="Chinesisch (traditionell)">zh_TW</a>
				  </li>				  
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="frontshortcuts">
			  <div id="frontshortcutscontent" class="txtshortcuts">
				  <h2>SHORTCUTS</h2>
				  <ul id="frontshortcutslist">
					<li>
					  <a href="&base;/community/mailinglists.html" title="Mailinglisten">Mailinglisten</a>
					</li>
					<li>
					  <a href="&base;/support/bugreports.html" title="Ein Problem melden">
					    Ein Problem melden</a>
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
			<!-- 25th anniversary logo -->
			<div class="frontfeaturecontent">
			  <!-- XXX: target page not yet ready
			  <a href="XXX TBD"
			    title="&os; 25th Anniversary">
			  -->
			  <img
			    src="&enbase;/layout/images/25thanniversary.png"
			    style="margin-top: 5px;"
			    width="167" height="88"
			    alt="25th Anniversary Logo" />
			  <!--
			  </a>
			  -->
			</div>
			<!-- end 25th anniversary logo -->
		</div> <!-- featureright -->

            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="frontnemscontainer">
            	<div id="frontnews">
            	   <div id="frontnewscontent" class="txtnewsevent">
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
            	<div id="frontevents">
		   <div id="fronteventscontent" class="txtnewsevent">

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
            	<div id="frontmedia">
		   <div id="frontmediacontent" class="txtnewsevent">

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
		<div id="frontsecurity">
		   <div id="frontsecuritycontent" class="txtnewsevent">

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
  </xsl:template>

  <xsl:template name="process.footer">
	&copyright;

	Die Marke FreeBSD ist eine eingetragene Marke der FreeBSD
	Foundation und wird vom FreeBSD Project mit freundlicher Genehmigung
	der <a
	href="https://www.freebsdfoundation.org/documents/Guidelines.shtml">
	FreeBSD Foundation</a> verwendet.
	<a href="&base;/mailto.html" title="&header2.word.contact;">&header2.word.contact;</a>
  </xsl:template>
</xsl:stylesheet>
