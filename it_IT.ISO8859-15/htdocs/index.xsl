<?xml version="1.0" encoding="ISO-8859-15" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>

<!--
     The FreeBSD Italian Documentation Project

     $FreeBSD$
     Original revision: 1.138
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl" />
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/xhtml.xsl"/>

  <xsl:variable name="svnKeyword">$FreeBSD$</xsl:variable>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.content">
        <div id="frontcontainer">
          <div id="frontmain">
            <div id="frontfeaturecontainer">

		<div id="frontfeatureleft">
			<div id="frontfeaturecontent">
				<h1>
				  Basato su BSD UNIX&reg;
				</h1>
				<p>FreeBSD&reg; è un sistema operativo avanzato per architetture
				compatibili x86 (inclusi Pentium&reg; e Athlon&trade;), amd64 (inclusi
				Opteron&trade;, Athlon 64, e EM64T),
				UltraSPARC&reg;, IA-64, PC-98 e ARM.
				È derivato da BSD, la versione di
				&unix; sviluppata
				all'Università della California, Berkeley.
				È sviluppato e mantenuto da <a
				href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">un
				grande gruppo di individui</a>.
				<a href="&base;/platforms/index.html">Piattaforme</a>
				aggiuntive sono in varie fasi di sviluppo.</p>
				<div id="txtfrontfeaturelink">
				»<a href="&base;/about.html" title="Approfondisci">Approfondisci</a>
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
					<li>
					  <a href="&u.rel.announce;">Release di Produzione &rel.current;</a>
					</li>
					<li>
					  <a href="&u.rel2.announce;">Release di Produzione (Legacy) &rel2.current;</a>
					</li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">Prossima Release
					    &betarel.current; - &betarel.vers;</a>
					</li>
			    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">Prossima Release
					    &betarel2.current; - &betarel2.vers;</a>
					</li>
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
					<a href="&enbase;/it/" title="Italiano">it</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="Giapponese">ja</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/ru/" title="Russo">ru</a>
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
					  <a href="http://www.freebsdfoundation.org/" title="Fondazione">Fondazione</a>
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

		   </div> <!-- FRONTNEWSEVENTS -->
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
					<a href="&enbase;/security/advisories.rdf" title="Security Advisories RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
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

			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTSECURITYCONTENT -->
            	</div> <!-- FRONTSECURITY -->

		<br class="clearboth" />

            </div> <!-- FRONTNEMSCONTAINER -->
          </div> <!-- FRONTMAIN -->
        </div> <!-- FRONTCONTAINER -->
  </xsl:template>
</xsl:stylesheet>
