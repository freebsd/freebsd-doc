<?xml version="1.0" encoding="iso-8859-2" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "A &os; Projekt">
]>

<!-- $FreeBSD$ -->

<!-- FreeBSD Hungarian Documentation Project
     Translated by: Gabor Kovesdan <gabor@FreeBSD.org>
     %SOURCE%	en/index.xsl
     %SRCID%	1.169
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

  <xsl:variable name="svnKeyword">$FreeBSD$</xsl:variable>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.content">
        <div id="frontcontainer">
          <div id="frontmain">
            <div id="frontfeaturecontainer">

		<div id="frontfeatureleft">
			<div id="frontfeaturecontent">
				<h1>A BSD &unix; alapjain</h1>

				<p>A &os;&reg; napjaink szerver, asztali
				  és beágyazott <a
				  href="&base;/platforms/">számítógépeinek</a>
				  operációs rendszere.  A
				  &os; kódbázisa több
				  mint harminc év folyamatos
				  fejlesztésének,
				  munkájának és
				  optimalizálásának
				  eredménye.  Jelenleg <a
				    href="&enbase;/doc/en/articles/contributors/article.html#STAFF-COMMITTERS">egyéni
				    fejlesztők egy nagyobb csoportja</a>
				  tartja karban.  A &os; legfontosabb
				  jellemzői többek közt a
				  fejlett
				  hálózatkezelés, a
				  kifinomult biztonsági
				  lehetőségek és a
				  világszínvonalú
				  teljesítmény, amelyet a
				  világban <a
				    href="&enbase;/doc/hu/books/handbook/nutshell.html/#INTRODUCTION-NUTSHELL-USERS">számos forgalmasabb kiszolgáló</a>,
				  hatékony beágyazott
				  rendszer és
				  tárolóeszköz
				  használ.</p>

				<div id="txtfrontfeaturelink"> &raquo;
				  <a href="&base;/about.html" title="Tovább">Tovább</a>
				</div> <!-- TXTFRONTFEATURELINK -->
			</div> <!-- FRONTFEATURECONTENT -->
		</div> <!-- FRONTFEATURELEFT -->

		<div id="frontfeaturemiddle">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Letöltés</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2><a href="&enbase;/releases/">FRISS KIADÁSOK</a></h2>
				  <ul id="frontreleaseslist">
					<li>
					  <a
					    href="&u.rel.announce;">Stabil kiadás: &rel.current;</a>
					</li>
					<li>
					  <a
					    href="&u.rel2.announce;">Stabil (kifutó) kiadás: &rel2.current;</a>
					</li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
					<li>
					  <a
					    href="&base;/where.html#helptest">Következő kiadás: &betarel.current; - &betarel.vers;</a>
					</li>
			    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
					<li>
					  <a
					    href="&base;/where.html#helptest">Következő kiadás: &betarel2.current; - &betarel2.vers;</a>
					</li>
			    </xsl:if>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="frontfeatureright">
			<h2 class="blockhide">Nyelvek</h2>
			<div id="languagenav">
				<ul id="languagenavlist">
				  <li>
					<a href="&enbase;/de/" title="Német">de</a>
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
					<a href="&enbase;/ja/" title="Japán">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/nl/" title="Holland">nl</a>
				  </li>
				  <li>
					<a href="&enbase;/ru/" title="Orosz">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_CN/" title="Kínai (Egyszerűsített)">zh_CN</a>
				  </li>
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="mirror">
			  <form action="&cgibase;/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="MIRRORSEL">Tükrözések</label></h2>
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
				  <h2>GYORSMENÜ</h2>
				  <ul id="frontshortcutslist">
					<li>
					  <a
					    href="&base;/community/mailinglists.html" title="Levelezési listák">Levelezési listák</a>
					</li>
					<li>
					  <a
					    href="&base;/support/bugreports.html" title="Hibajelentések">Hibajelentések</a>
					</li>
					<li>
					  <a
					    href="&enbase;/doc/hu/books/faq/index.html" title="GYIK">GYIK</a>
					</li>
					<li>
					  <a
					    href="&enbase;/doc/hu/books/handbook/index.html" title="Kézikönyv">Kézikönyv</a>
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
				href="&enbase;/projects/newbies.html">Új felhasználó?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- FEATURERIGHT -->

            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="frontnemscontainer">
            	<div id="frontnews">
            	   <div id="frontnewscontent" class="txtnewsevent">
			<h2>FRISS HÍREK</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a
					  href="&base;/news/newsflash.html" title="További hírek">További hírek</a>
				  </li>
				  <li class="last-child">
					<a
					  href="&base;/news/rss.xml" title="Hírek RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Hírek RSS feedben" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontevents">
		   <div id="fronteventscontent" class="txtnewsevent">

			<h2>RENDEZVÉNYEK</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a
					  href="&base;/events/" title="További rendezvények">További rendezvények</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontmedia">
		   <div id="frontmediacontent" class="txtnewsevent">

			<h2>A MÉDIÁBAN</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a
					  href="&base;/news/press.html" title="Tovább események a médiában">Tovább</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
            	</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="frontsecurity">
		   <div id="frontsecuritycontent" class="txtnewsevent">

			<h2>BIZTONSÁGI
			  FIGYELMEZTETÉSEK</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a
					  href="&base;/security/advisories.html" title="További biztonsági figyelmeztetések">Tovább</a>
				  </li>
				  <li class="last-child">
					<a
					  href="&base;/security/rss.xml" title="Biztonsági figyelmeztetések RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Biztonsági figyelmeztetések RSS feedben" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>HIBAJEGYZÉK</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			</xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="first-child">
				<a
				  href="&base;/security/" title="Még több sajtóhiba mutatása">Tovább</a>
			      </li>
			      <li class="last-child">
				<a
				  href="&base;/security/errata.xml" title="Sajtóhibák RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Sajtóhibák RSS feedben"/></a>
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
