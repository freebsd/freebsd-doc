<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "El Proyecto FreeBSD">
]>

<!-- The FreeBSD Spanish Documentation Project
     Original Revision: r1.163			-->

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

  <xsl:variable name="svnKeyword" select="'$FreeBSD$'"/>

  <xsl:variable name="title">&title;</xsl:variable>

<xsl:template name="process.content">
        <div id="frontcontainer">
          <div id="frontmain">
            <div id="frontfeaturecontainer">

		<div id="frontfeatureleft">
			<div id="frontfeaturecontent">
				<h1>
				  Basado en BSD UNIX&reg;
				</h1>
				<p>FreeBSD es un avanzado sistema operativo para arquitecturas
				x86 compatibles (como Pentium&reg; y Athlon&trade;),
				amd64 compatibles (como Opteron&trade;, Athlon&trade;64 EM64T),
				UltraSPARC&reg;, IA-64, PC-98 y ARM.
				FreeBSD es un derivado de BSD, la versión de
				UNIX&reg; desarrollada en la Universidad
				de California, Berkeley.  FreeBSD es desarrollado y mantenido
				por un
				<a href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/index.html">
				numeroso equipo de personas</a>.  El soporte para otras
				<a href="&base;/platforms/index.html">arquitecturas</a>
				está en diferentes fases de desarrollo.</p>
				<div id="txtfrontfeaturelink">
				»<a href="&base;/about.html" title="Más Información">Más Información</a>
				</div> <!-- txtfrontfeaturelink -->
			</div> <!-- frontfeaturecontent -->
		</div> <!-- frontfeatureleft -->

		<div id="frontfeaturemiddle">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Conseguir FreeBSD</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2><a href="&enbase;/releases/">ÚLTIMAS VERSIONES</a></h2>
				  <ul id="FRONTRELEASELIST">
					<li>
					  <a href="&u.rel.announce;">Release estable: &rel.current;</a>
					</li>
					<li>
					  <a href="&u.rel2.announce;">Release estable (heredera): &rel2.current;</a>
					</li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
				    <li>
				      <a href="&enbase;/where.html#helptest">Próxima Release
					&betarel.current; - &betarel.vers;</a>
				    </li>
				</xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
				    <li>
				      <a href="&enbase;/where.html#helptest">Próxima Release
					&betarel2.current; - &betarel2.vers;</a>
				    </li>
				</xsl:if>
				  </ul>
			  </div> <!-- frontreleasescontent -->
			</div> <!-- frontreleases -->
		</div> <!-- frontfeaturemiddle -->

		<div id="frontfeatureright">
			<h2 class="blockhide">Enlaces de idiomas</h2>
			<div id="languagenav">
				<ul id="languagenavlist">
				  <li>
					<a href="&enbase;/de/" title="Alemán">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="Inglés">en</a>
				  </li>
				  <li>
					<a href="&enbase;/es/" title="Español">es</a>
				  </li>
				  <li>
					<a href="&enbase;/fr/" title="Francés">fr</a>
				  </li>
				  <li>
					<a href="&enbase;/hu/" title="Húngaro">hu</a>
				  </li>
				  <li>
					<a href="&enbase;/it/" title="Italiano">it</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="Japonés">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/ru/" title="Ruso">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/ru/" title="Chino (Simplificado)">zh_CN</a>
				  </li>
				</ul>
			</div> <!-- languagenav -->

			<div id="mirror">
			  <form action="&enbase;/cgi/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="mirrorsel">Réplicas</label></h2>
				  <select id="mirrorsel" name="goto">
					  <xsl:call-template name="html-index-mirrors-options-list">
					    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
					  </xsl:call-template>
				  </select>
				</div> <!-- unnamed -->
				<input type="submit" value="Ir" />
			  </form>
			</div> <!-- mirror -->

			<div id="frontshortcuts">
			  <div id="frontshortcutscontent" class="txtshortcuts">
				  <h2>ENLACES RÁPIDOS</h2>
				  <ul id="FRONTSHORTCUTLIST">
					<li>
					  <a href="&base;/support.html#mailing-list" title="Listas de distribución">Listas de distribución</a>
					</li>
					<li>
					  <a href="&base;/send-pr.html" title="Reporte un Fallo">Reporte un Fallo</a>
					</li>
					<li>
					  <a href="&enbase;/doc/&url.doc.langcode;/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/index.html" title="Handbook">Handbook</a>
					</li>
					<li>
					  <a href="&base;/ports/index.html" title="Ports">Ports</a>
					</li>
				  </ul>
			  </div> <!-- frontshortcutscontent -->
			</div> <!-- frontshortcuts -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div><b style="display: none">.</b></div></div>
			    <div class="frontnewcontent">
			      <a href="&base;/projects/newbies.html">?Nuevo en FreeBSD?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- featureright -->

            </div> <!-- frontfeaturecontainer -->

	    <br class="clearboth" />
            <div id="FRONTNEWSCONTAINER">
            	<div id="frontnews">
            	   <div id="frontnewscontent" class="txtnewsevent">
			<h2>ÚLTIMAS NOTICIAS</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/news/newsflash.html" title="Más Noticias">Más Noticias</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/news/rss.xml" title="News RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- frontnewscontent -->
            	</div> <!-- frontnews -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontevents">
		   <div id="fronteventscontent" class="txtnewsevent">

			<h2>PRÓXIMOS EVENTOS</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&enbase;/events/" title="Más Eventos">Más Eventos</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- frontnewsevents -->
            	</div> <!-- frontevents -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontmedia">
		   <div id="frontmediacontent" class="txtnewsevent">

			<h2>EN LOS MEDIOS</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&base;/news/press.html" title="Más medios">Más medios</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- frontmediacontent -->
            	</div> <!-- frontmedia -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="frontsecurity">
		   <div id="frontsecuritycontent" class="txtnewsevent">

			<h2>AVISOS DE SEGURIDAD</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/security/" title="Más Avisos de Seguridad">Más</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/security/advisories.rdf" title="Fuente RSS de avisos de seguridad"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Fuente RSS de noticias" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>AVISOS SOBRE ERRORES</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			</xsl:call-template>

			</div> <!-- newseventswrap -->

		   </div> <!-- frontsecuritycontent -->
            	</div> <!-- frontsecurity -->

		<br class="clearboth" />

            </div> <!-- frontnemscontainer -->
          </div> <!-- frontmain -->
        </div> <!-- frontcontainer -->
  </xsl:template>
</xsl:stylesheet>
