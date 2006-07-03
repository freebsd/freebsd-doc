<!-- $FreeBSD: www/fr/index.xsl,v 1.30 2006/05/03 18:26:53 blackend Exp $ -->

<!--
   The FreeBSD French Documentation Project
   Original revision: 1.144

   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
   Mise a jour:	Marc Fonvieille <blackend@FreeBSD.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/fr/index.xsl,v 1.30 2006/05/03 18:26:53 blackend Exp $'"/>
  <xsl:variable name="title" select="'Le Projet FreeBSD'"/>

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
  <xsl:param name="curdate.xml" select="'none'"/>

  <xsl:output type="html" encoding="iso-8859-1"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

<xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="$title"/></title>
	<meta name="description" content="The FreeBSD Project"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Ports,
	      Version, Application, Logiciel, Manuel de
	      R&#233;f&#233;rence, FAQ, Guides, Bugs, CVS, CVSup,
	      Nouvelles, Revendeurs, homepage, CTM, Unix"/>
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
	
	<!-- Formatted to be easy to spam harvest, please do not reformat. -->
	<xsl:comment>
        Spamtrap, do not email:
        &lt;a href="mailto:bruscar@freebsd.org"&gt;bruscar@freebsd.org&lt;/a&gt;
	</xsl:comment>
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
				  Bas&#233; sur UNIX&#174; BSD
				</h1>				
				<p>FreeBSD est un syst&#232;me d'exploitation avanc&#233; pour
				les architectures compatibles x86 (y compris Pentium&#174; et Athlon&#8482;), compatibles 
				amd64 (y compris Opteron&#8482;, Athlon 64 et EM64T), 
				Alpha/AXP, IA-64, PC-98 et UltraSPARC&#174;.
				Il est d&#233;riv&#233; de UNIX BSD, la version d'<xsl:value-of select="$unix"/> 
				d&#233;velopp&#233;e &#224;
				l'Universit&#233; de Californie, Berkeley.
				Il est d&#233;velopp&#233; et maintenu par
				<a href="{$enbase}/doc/{$url.doc.langcode}/articles/contributors/staff-committers.html">une
				importante &#233;quipe de personnes</a>. D'autres
				<a href="{$base}/platforms/index.html">plates-formes</a> sont &#224;
				divers stades de d&#233;veloppement.</p>
				<div id="txtfrontfeaturelink">
				&#187;<a href="{$base}/about.html" title="En savoir plus">En savoir plus</a>
				</div> <!-- txtfrontfeaturelink -->
			</div> <!-- frontfeaturecontent -->
		</div> <!-- frontfeatureleft -->

		<div id="FRONTFEATUREMIDDLE">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div>&#160;</div>&#160;</div>
				<div class="frontgetcontent">
				  <a href="{$base}/where.html">Obtenir FreeBSD maintenant</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div>&#160;</div>&#160;</div>
			</div> <!-- frontgetroundbox -->
			
			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
				  <h2><a href="{$base}/releases/">DERNIERES VERSIONS</a></h2>
				  <ul id="FRONTRELEASESLIST">
					<li>
					  <a href="{$u.rel.announce}">Version de production <xsl:value-of select="$rel.current"/></a>
					</li>
					<li>
					  <a href="{$u.rel2.announce}">Version (ancienne) de production <xsl:value-of select="$rel2.current"/></a>
					</li>
				    <xsl:if test="$beta.testing">
					<li>
					  <a href="{$base}/where.html#helptest">Version &#224; venir
					    <xsl:value-of select="concat($betarel.current, '-', $betarel.vers)"/></a>
					</li>
				    </xsl:if>
				    <xsl:if test="$beta2.testing">
					<li>
					  <a href="{$base}/where.html#helptest">Version &#224; venir
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
					<a href="{$enbase}/de/" title="Allemand">de</a>
				  </li>
				  <li>
					<a href="{$enbase}/" title="Anglais">en</a>
				  </li>
				  <li>
					<a href="{$enbase}/es/" title="Espagnol">es</a>
				  </li>
				  <li>
					<a href="{$enbase}/fr/" title="Fran&#231;ais">fr</a>
				  </li>
				  <li>
					<a href="{$enbase}/it/" title="Italien">it</a>
				  </li>
				  <li>
					<a href="{$enbase}/ja/" title="Japonais">ja</a>
				  </li>
				  <li class="last-child">
					<a href="{$enbase}/ru/" title="Russe">ru</a>
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
				<input type="submit" value="Go" />
			  </form>
			</div> <!-- MIRROR -->

			<div id="FRONTSHORTCUTS">
			  <div id="FRONTSHORTCUTSCONTENT" class="txtshortcuts">
				  <h2>LIENS</h2>
				  <ul id="FRONTSHORTCUTSLIST">
					<li>
					  <a href="{$base}/support.html#mailing-list" title="Listes de diffusion">Listes de diffusion</a>
					</li>
					<li>
					  <a href="{$base}/send-pr.html" title="Envoyer un rapport de bogue">Envoyer un rapport de bogue</a>
					</li>
					<li>
					  <a href="{$enbase}/doc/{$url.doc.langcode}/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="{$enbase}/doc/{$url.doc.langcode}/books/handbook/index.html" title="Manuel de r&#233;f&#233;rence">Manuel de r&#233;f&#233;rence</a>
					</li>
					<li>
					  <a href="http://www.freebsdfoundation.org/" title="Fondation">Fondation</a>
					</li>
					<li>
					  <a
					  href="{$enbase}/ports/index.html"
					  title="Logiciels
					  port&#233;s">Logiciels
					  port&#233;s</a>
					</li>

				  </ul>
			  </div> <!-- FRONTSHORTCUTSCONTENT -->
			</div> <!-- FRONTSHORTCUTS -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div>&#160;</div>&#160;</div>
			    <div class="frontnewcontent">
			      <a href="{$base}/projects/newbies.html">D&#233;butant sous FreeBSD?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div>&#160;</div>&#160;</div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- FEATURERIGHT -->
				
            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="FRONTNEMSCONTAINER">
            	<div id="FRONTNEWS">
            	   <div id="FRONTNEWSCONTENT" class="txtnewsevent">
			<h2>NOUVELLES DU PROJET</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="{$base}/news/newsflash.html" title="Plus de nouvelles">Plus...</a>
				  </li>
				  <li class="last-child">
					<a href="{$base}/news/news.rdf" title="Flux RSS de nouvelles"><img class="rssimage" src="{$enbase}/layout/images/ico_rss.png" width="27" height="12" alt="Flux RSS de nouvelles" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTEVENTS">
		   <div id="FRONTEVENTSCONTENT" class="txtnewsevent">

			<h2>EVENEMENTS A VENIR</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
				<xsl:with-param name="curdate.xml" select="$curdate.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="{$base}/events/" title="Plus d'&#233;v&#233;nements">Plus...</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTMEDIA">
		   <div id="FRONTMEDIACONTENT" class="txtnewsevent">

			<h2>DANS LA PRESSE</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="{$base}/news/press.html" title="Plus...">Plus...</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
            	</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="FRONTSECURITY">
		   <div id="FRONTSECURITYCONTENT" class="txtnewsevent">

			<h2>AVIS DE SECURITE</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="{$base}/security/" title="Plus d'avis de s&#233;curit&#233;">Plus...</a>
				  </li>
				  <li class="last-child">
					<a href="{$enbase}/security/advisories.rdf" title="Flux RSS des avis de s&#233;curit&#233;"><img class="rssimage" src="{$enbase}/layout/images/ico_rss.png" width="27" height="12" alt="Flux RSS des avis de s&#233;curit&#233;" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>ERRATA</h2>
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
        <xsl:copy-of select="$copyright"/><br />
        <xsl:copy-of select="$date"/>
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
