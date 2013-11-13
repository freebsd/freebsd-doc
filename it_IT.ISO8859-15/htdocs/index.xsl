<?xml version="1.0" encoding="iso-8859-15" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>

<!--
     The FreeBSD Italian Documentation Project

     $FreeBSD$
     Original revision: 39534
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl" />
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:variable name="svnKeyword">$FreeBSD$</xsl:variable>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.content">
        <div id="frontcontainer">
          <div id="frontmain">
            <div id="frontfeaturecontainer">

		<div id="frontfeatureleft">
			<div id="frontfeaturecontent">
				<h1>
				  Basato su BSD &unix;
				</h1>

				<p>FreeBSD&reg; è un avanzato sistema
				  operativo per moderne <a
				  href="&base;/platforms/">piattaforme</a>
				  server, desktop, ed embedded.
				  Il codice di FreeBSD ha subito più di
				  trent'anni di continui sviluppi,
				  miglioramenti, e ottimizzazioni.
				  È sviluppato e mantenuto da <a
				  href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">un
				  grande gruppo di individui</a>.
				  FreeBSD fornisce funzionalità di rete
				  avanzate, caratteristiche di sicurezza
				  impressionanti, e prestazioni di prima
				  categoria ed è utilizzato da alcuni
				  dei <a
				  href="&enbase;/doc/en_US.ISO8859-1/books/handbook/nutshell.html#INTRODUCTION-NUTSHELL-USERS">siti
				  web più trafficati</a> e dai più
				  pervasivi dispositivi embedded di rete e
				  di storage.</p>

				<div id="txtfrontfeaturelink">
				  &#187;<a href="&base;/about.html" title="Approfondisci">Approfondisci</a>
				</div> <!-- TXTFRONTFEATURELINK -->
			</div> <!-- FRONTFEATURECONTENT -->
		</div> <!-- FRONTFEATURELEFT -->

		<div id="frontfeaturemiddle">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div>&nbsp;</div>&nbsp;</div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Ottieni FreeBSD Ora</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div>&nbsp;</div>&nbsp;</div>
			</div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2><a href="&base;/releases/">ULTIME RELEASE</a></h2>
				  <ul id="frontreleaseslist">
					<li>Produzione:&nbsp;<a
				href="&u.rel.announce;">&rel.current;</a>,&nbsp;<a href="&u.rel2.announce;">&rel2.current;</a></li>
					<li>Legacy: <a
				href="&u.rel3.announce;">&rel3.current;</a></li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
					<li>Prossima: <a
				href="&base;/where.html#helptest">&betarel.current;-&betarel.vers;</a></li>
			    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
					<li>Prossima: <a
				href="&base;/where.html#helptest">&betarel2.current;-&betarel2.vers;</a></li>
			    </xsl:if>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="frontfeatureright">
			<h2 class="blockhide">Language Links</h2>
			<div id="languagenav">
				<ul id="languagenavlist">
				  <li>
					<a href="&enbase;/de/" title="Tedesco">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="Inglese">en</a>
				  </li>
				  <li>
					<a href="&enbase;/es/" title="Spagnolo">es</a>
				  </li>
				  <li>
					<a href="&enbase;/fr/" title="Francese">fr</a>
				  </li>
				  <li>
					<a href="&enbase;/hu/" title="Ungherese">hu</a>
				  </li>
				  <li>
					<a href="&enbase;/it/" title="Italiano">it</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="Giapponese">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/nl/" title="Olandese">nl</a>
				  </li>
				  <li>
					<a href="&enbase;/ru/" title="Russo">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_CN/" title="Cinese (Semplificato)">zh_CN</a>
				  </li>
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="mirror">
			  <form action="&cgibase;/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="MIRRORSEL">Mirror</label></h2>
				  <select id="mirrorsel" name="goto">
					  <xsl:call-template name="html-index-mirrors-options-list">
					    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
					  </xsl:call-template>
				  </select>
				</div> <!-- unnamed -->
				<input type="submit" value="Vai" />
			  </form>
			</div> <!-- MIRROR -->

			<div id="frontshortcuts">
			  <div id="frontshortcutscontent" class="txtshortcuts">
				  <h2>SCORCIATOIE</h2>
				  <ul id="frontshortcutslist">
					<li>
					  <a href="&enbase;/community/mailinglists.html" title="Mailing Lists">Mailing Lists</a>
					</li>
					<li>
					  <a href="&enbase;/send-pr.html" title="Report di Bug">Report di Bug</a>
					</li>
					<li>
					  <a href="&enbase;/doc/en_US.ISO8859-1/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="&enbase;/doc/it_IT.ISO8859-15/books/handbook/index.html" title="Manuale">Manuale</a>
					</li>
					<li>
					  <a href="&base;/ports/index.html" title="Port">Port</a>
					</li>
				  </ul>
			  </div> <!-- FRONTSHORTCUTSCONTENT -->
			</div> <!-- FRONTSHORTCUTS -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div>&nbsp;</div>&nbsp;</div>
			    <div class="frontnewcontent">
			      <a href="&enbase;/projects/newbies.html">Neofita di FreeBSD?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div>&nbsp;</div>&nbsp;</div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- FEATURERIGHT -->

            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="frontnemscontainer">
            	<div id="frontnews">
            	   <div id="frontnewscontent" class="txtnewsevent">
			<h2>ULTIME NOTIZIE</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
			    <xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
			    <xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&enbase;/news/newsflash.html" title="Altre Notizie">Altre Notizie</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/news/rss.xml" title="Feed RSS per le Notizie"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Feed RSS per le Notizie" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontevents">
		   <div id="fronteventscontent" class="txtnewsevent">

			<h2>PROSSIMI EVENTI</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
			    <xsl:with-param name="events.xml-master" select="$events.xml-master" />
			    <xsl:with-param name="events.xml" select="$events.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&enbase;/events/" title="Altri Eventi">Altri Eventi</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontmedia">
		   <div id="frontmediacontent" class="txtnewsevent">

			<h2>SUI MEDIA</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
			    <xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
			    <xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&enbase;/news/press.html" title="Altri Media">Altri Media</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
            	</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="frontsecurity">
		   <div id="frontsecuritycontent" class="txtnewsevent">

			<h2>AVVISI DI SICUREZZA</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&enbase;/security/" title="Altri Avvisi di Sicurezza">Altri</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/security/rss.xml" title="Feed RSS per gli Avvisi di Sicurezza"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Feed RSS per le Notizie" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>ERRATA CORRIGE</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			</xsl:call-template>

			  <div>
			    	<ul class="newseventslist">
				  <li class="first-child">
				    <a href="&enbase;/security/notices.html" title="Altri Errata Corrige">Altri</a>
				  </li>
				  <li class="last-child">
				    <a href="&enbase;/security/errata.xml" title="Feed RSS per gli Errata Corrige"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Feed RSS per gli Errata Corrige" /></a>
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
 
	FreeBSD è un marchio registrato di The FreeBSD Foundation ed è
	usato da The FreeBSD Project con il permesso di <a
	  href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">The
	FreeBSD Foundation</a>.
  </xsl:template>
</xsl:stylesheet>
