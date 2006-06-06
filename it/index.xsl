<!--
     The FreeBSD Italian Documentation Project

     $FreeBSD: www/it/index.xsl,v 1.29 2006/06/06 11:08:49 ale Exp $
     Original revision: 1.138
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="includes.xsl"/>
  <xsl:import href="../en/news/includes.xsl"/>

  <xsl:variable name="date" select="''"/>  
  <xsl:variable name="title" select="'The FreeBSD Project'"/>

  <xsl:output type="html" encoding="iso-8859-1"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="$title"/></title>
	<meta name="description" content="The FreeBSD Project"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Ports,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="{$enbase}/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="{$enbase}/favicon.ico" type="image/x-icon"/>
	<link rel="stylesheet" media="screen" href="{$enbase}/layout/css/fixed.css" type="text/css" title="Normal Text" />
	<link rel="alternate stylesheet" media="screen" href="{$enbase}/layout/css/fixed_large.css" type="text/css" title="Large Text" />
	<script type="text/javascript" src="{$enbase}/layout/js/styleswitcher.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Project News" href="{$enbase}/news/news.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Security Advisories" href="{$enbase}/security/advisories.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD GNOME Project News" href="{$enbase}/gnome/news.rdf" />
      </head>

      <body>

   <div id="CONTAINERWRAP">
    <div id="CONTAINER">
      <xsl:copy-of select="$header2"/>
      <div id="CONTENT">

        <div id="FRONTCONTAINER">
          <div id="FRONTMAIN">
            <div id="FRONTFEATURECONTAINER">

		<div id="FRONTFEATURELEFT">
			<div id="FRONTFEATURECONTENT">
				<h1>
				  Basato su BSD UNIX&#174;
				</h1>				
				<p>FreeBSD&#174; &#232; un sistema operativo avanzato per architetture
				compatibili x86 (inclusi Pentium&#174; e Athlon&#8482;), amd64 (inclusi
				Opteron&#8482;, Athlon 64, e EM64T),
				UltraSPARC&#174;, IA-64, PC-98 e ARM.
				&#200; derivato da BSD, la versione di
				<xsl:value-of select="$unix"/> sviluppata
				all'Universit&#224; della California, Berkeley.
				&#200; sviluppato e mantenuto da <a
				href="{$enbase}/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">un
				grande gruppo di individui</a>.
				<a href="{$base}/platforms/index.html">Piattaforme</a>
				aggiuntive sono in varie fasi di sviluppo.</p>
				<div id="TXTFRONTFEATURELINK">
				&#187;<a href="{$base}/about.html" title="Approfondisci">Approfondisci</a>
				</div> <!-- TXTFRONTFEATURELINK -->
			</div> <!-- FRONTFEATURECONTENT -->
		</div> <!-- FRONTFEATURELEFT -->

		<div id="FRONTFEATUREMIDDLE">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div>&#160;</div>&#160;</div>
				<div class="frontgetcontent">
				  <a href="{$base}/where.html">Ottieni FreeBSD Ora</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div>&#160;</div>&#160;</div>
			</div> <!-- frontgetroundbox -->
			
			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
				  <h2><a href="{$base}/releases/">ULTIME RELEASE</a></h2>
				  <ul id="FRONTRELEASESLIST">
					<li>
					  <a href="{$u.rel.announce}">Release di Produzione <xsl:value-of select="$rel.current"/></a>
					</li>
					<li>
					  <a href="{$u.rel2.announce}">Release di Produzione (Legacy) <xsl:value-of select="$rel2.current"/></a>
					</li>
				    <xsl:if test="$beta.testing">
					<li>
					  <a href="{$base}/where.html#helptest">Prossima Release
					    <xsl:value-of select="concat($betarel.current, '-', $betarel.vers)"/></a>
					</li>
				    </xsl:if>
				    <xsl:if test="$beta2.testing">
					<li>
					  <a href="{$base}/where.html#helptest">Prossima Release
					    <xsl:value-of select="concat($betarel2.current, '-', $betarel2.vers)"/></a>
					</li>
				    </xsl:if>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="FRONTFEATURERIGHT">
			<h2 class="blockhide">Language Links</h2>
			<div id="LANGUAGENAV">
				<ul id="LANGUAGENAVLIST">
				  <li>
					<a href="{$enbase}/de/" title="Tedesco">de</a>
				  </li>
				  <li>
					<a href="{$enbase}/" title="Inglese">en</a>
				  </li>
				  <li>
					<a href="{$enbase}/es/" title="Spagnolo">es</a>
				  </li>
				  <li>
					<a href="{$enbase}/fr/" title="Francese">fr</a>
				  </li>
				  <li>
					<a href="{$enbase}/it/" title="Italiano">it</a>
				  </li>
				  <li>
					<a href="{$enbase}/ja/" title="Giapponese">ja</a>
				  </li>
				  <li class="last-child">
					<a href="{$enbase}/ru/" title="Russo">ru</a>
				  </li>
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="MIRROR">
			  <form action="{$cgibase}/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="MIRRORSEL">Mirror</label></h2>
				  <select id="MIRRORSEL" name="goto">
					  <xsl:call-template name="html-index-mirrors-options-list">
					    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
					  </xsl:call-template>
				  </select>
				</div> <!-- unnamed -->
				<input type="submit" value="Vai" />
			  </form>
			</div> <!-- MIRROR -->

			<div id="FRONTSHORTCUTS">
			  <div id="FRONTSHORTCUTSCONTENT" class="txtshortcuts">
				  <h2>SCORCIATOIE</h2>
				  <ul id="FRONTSHORTCUTSLIST">
					<li>
					  <a href="{$enbase}/community/mailinglists.html" title="Mailing Lists">Mailing Lists</a>
					</li>
					<li>
					  <a href="{$enbase}/send-pr.html" title="Report di Bug">Report di Bug</a>
					</li>
					<li>
					  <a href="{$enbase}/doc/en_US.ISO8859-1/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="{$enbase}/doc/it_IT.ISO8859-15/books/handbook/index.html" title="Manuale">Manuale</a>
					</li>
					<li>
					  <a href="http://www.freebsdfoundation.org/" title="Fondazione">Fondazione</a>
					</li>
					<li>
					  <a href="{$base}/ports/index.html" title="Port">Port</a>
					</li>
				  </ul>
			  </div> <!-- FRONTSHORTCUTSCONTENT -->
			</div> <!-- FRONTSHORTCUTS -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div>&#160;</div>&#160;</div>
			    <div class="frontnewcontent">
			      <a href="{$enbase}/projects/newbies.html">Neofita di FreeBSD?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div>&#160;</div>&#160;</div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- FEATURERIGHT -->
				
            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="FRONTNEMSCONTAINER">
            	<div id="FRONTNEWS">
            	   <div id="FRONTNEWSCONTENT" class="txtnewsevent">
			<h2>ULTIME NOTIZIE</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="{$enbase}/news/newsflash.html" title="Altre Notizie">Altre Notizie</a>
				  </li>
				  <li class="last-child">
					<a href="{$enbase}/news/news.rdf" title="News RSS Feed"><img class="rssimage" src="{$enbase}/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTEVENTS">
		   <div id="FRONTEVENTSCONTENT" class="txtnewsevent">

			<h2>PROSSIMI EVENTI</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml" select="$events.xml" />
				<xsl:with-param name="curdate.xml" select="$curdate.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="{$enbase}/events/" title="Altri Eventi">Altri Eventi</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTNEWSEVENTS -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTMEDIA">
		   <div id="FRONTMEDIACONTENT" class="txtnewsevent">

			<h2>SUI MEDIA</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="{$enbase}/news/press.html" title="Altri Media">Altri Media</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
            	</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="FRONTSECURITY">
		   <div id="FRONTSECURITYCONTENT" class="txtnewsevent">

			<h2>AVVISI DI SICUREZZA</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="{$enbase}/security/" title="Altri Avvisi di Sicurezza">Altri</a>
				  </li>
				  <li class="last-child">
					<a href="{$enbase}/security/advisories.rdf" title="Security Advisories RSS Feed"><img class="rssimage" src="{$enbase}/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
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

      </div> <!-- CONTENT -->
      <div id="FOOTER">
        <xsl:copy-of select="$copyright"/>

	FreeBSD &#232; un marchio registrato della FreeBSD Foundation ed &#232;
	usato dal FreeBSD Project con il permesso della <a
	  href="http://www.freebsdfoundation.org/legal/guidelines.shtml">FreeBSD
	  Foundation</a>.

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
