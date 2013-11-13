<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Le Projet FreeBSD">
]>

<!-- $FreeBSD$ -->
<!--
   The FreeBSD French Documentation Project
   Original revision: 1.170

   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
   Mise a jour:	Marc Fonvieille <blackend@FreeBSD.org>
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
  <xsl:param name="curdate.xml" select="'none'"/>

  <xsl:variable name="svnKeyword" select="'$FreeBSD$'"/>

  <xsl:variable name="title">&title;</xsl:variable>

<xsl:template name="process.content">
        <div id="frontcontainer">
          <div id="frontmain">
            <div id="frontfeaturecontainer">

		<div id="frontfeatureleft">
			<div id="frontfeaturecontent">
				<h1>
				  Basé sur &unix; BSD
				</h1>
				<p>FreeBSD&reg; est un système d'exploitation avancé pour
				les <a
				href="&base;/platforms/">plates-formes</a>
				modernes de type serveur, station de
				travail et systèmes embarqués.  Le code
				de base de FreeBSD a été développé,
				amélioré et optimisé continuellement
				pendant plus de trente ans.
				Il est développé et maintenu par
				<a href="&enbase;/doc/&url.doc.langcode;/articles/contributors/staff-committers.html">une
				importante équipe de personnes</a>.
				FreeBSD propose des fonctionnalités
				réseau avancées, une sécurité poussée et
				des performances de haut niveau.
				FreeBSD est utilisé par certains des <a
				href="&enbase;/doc/&url.doc.langcode;/books/handbook/nutshell.html#INTRODUCTION-NUTSHELL-USERS">sites
				web les plus visités</a> ainsi que par
				la plupart
				des systèmes embarqués orientés réseau
				et des systèmes de stockage les plus
				répandus.</p>

				<div id="txtfrontfeaturelink">
				»<a href="&base;/about.html" title="En savoir plus">En savoir plus</a>
				</div> <!-- txtfrontfeaturelink -->
			</div> <!-- frontfeaturecontent -->
		</div> <!-- frontfeatureleft -->

		<div id="frontfeaturemiddle">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div>&nbsp;</div>&nbsp;</div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Obtenir FreeBSD maintenant</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div>&nbsp;</div>&nbsp;</div>
			</div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2><a href="&base;/releases/">DERNIERES VERSIONS</a></h2>
				  <ul id="frontreleaseslist">
					<li>
					  <a href="&u.rel.announce;">Version de production &rel.current;</a>
					</li>
					<li>
					  <a href="&u.rel2.announce;">Version (ancienne) de production &rel2.current;</a>
					</li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">Version à venir
					    &betarel.current; - &betarel.vers;</a>
					</li>
				    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">Version à venir
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
					<a href="&enbase;/de/" title="Allemand">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="Anglais">en</a>
				  </li>
				  <li>
					<a href="&enbase;/es/" title="Espagnol">es</a>
				  </li>
				  <li>
					<a href="&enbase;/fr/" title="Français">fr</a>
				  </li>
				  <li>
					<a href="&enbase;/hu/" title="Hongrois">hu</a>
				  </li>
				  <li>
					<a href="&enbase;/it/" title="Italien">it</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="Japonais">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/nl/" title="Néerlandais">nl</a>
				  </li>
				  <li>
					<a href="&enbase;/ru/" title="Russe">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_CN/" title="Chinois simplifié">zh_CN</a>
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
				<input type="submit" value="Go" />
			  </form>
			</div> <!-- MIRROR -->

			<div id="frontshortcuts">
			  <div id="frontshortcutscontent" class="txtshortcuts">
				  <h2>LIENS</h2>
				  <ul id="frontshortcutslist">
					<li>
					  <a href="&base;/support.html#mailing-list" title="Listes de diffusion">Listes de diffusion</a>
					</li>
					<li>
					  <a href="&base;/support/bugreports.html" title="Envoyer un rapport de bogue">Envoyer un rapport de bogue</a>
					</li>
					<li>
					  <a href="&enbase;/doc/&url.doc.langcode;/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/index.html" title="Manuel de référence">Manuel de référence</a>
					</li>
					<li>
					  <a
					  href="&enbase;/ports/index.html"
					  title="Logiciels
					  portés">Logiciels
					  portés</a>
					</li>

				  </ul>
			  </div> <!-- FRONTSHORTCUTSCONTENT -->
			</div> <!-- FRONTSHORTCUTS -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div>&nbsp;</div>&nbsp;</div>
			    <div class="frontnewcontent">
			      <a href="&base;/projects/newbies.html">Débutant sous FreeBSD?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div>&nbsp;</div>&nbsp;</div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- FEATURERIGHT -->

            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="frontnemscontainer">
            	<div id="frontnews">
            	   <div id="frontnewscontent" class="txtnewsevent">
			<h2>NOUVELLES DU PROJET</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/news/newsflash.html" title="Plus de nouvelles">Plus...</a>
				  </li>
				  <li class="last-child">
					<a href="&base;/news/rss.xml" title="Flux RSS de nouvelles"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Flux RSS de nouvelles" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontevents">
		   <div id="fronteventscontent" class="txtnewsevent">

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
					<a href="&base;/events/" title="Plus d'événements">Plus...</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontmedia">
		   <div id="frontmediacontent" class="txtnewsevent">

			<h2>DANS LA PRESSE</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&base;/news/press.html" title="Plus...">Plus...</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
            	</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="frontsecurity">
		   <div id="frontsecuritycontent" class="txtnewsevent">

			<h2>AVIS DE SECURITE</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/security/advisories.html" title="Plus d'avis de sécurité">Plus...</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/security/rss.xml" title="Flux RSS des avis de sécurité"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Flux RSS des avis de sécurité" /></a>
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

			<div>
			      <ul class="newseventslist">
				<li class="first-child">
				  <a href="&base;/security/notices.html" title="Plus d'Errata">Plus</a>
				</li>
				<li class="last-child">
				  <a href="&base;/security/errata.xml" title="Flux RSS des Errata"><img class="rssimage" src="&base;/layout/images/ico_rss.png" width="27" height="12" alt="Flux RSS des Errata" /></a>
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
</xsl:stylesheet>
