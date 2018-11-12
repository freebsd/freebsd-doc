<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "El Proyecto FreeBSD">
]>

<!-- The FreeBSD Spanish Documentation Project
     Original Revision: r1.163			-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD$'"/>

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
	<meta name="description" content="El Proyecto FreeBSD"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Ports,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" media="screen" href="&enbase;/layout/css/fixed.css" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="&enbase;/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="&enbase;/layout/js/styleswitcher.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="Noticias del proyecto FreeBSD" href="&enbase;/news/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="Avisos de seguridad de FreeBSD" href="&enbase;/security/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="Noticias del proyecto GNOME para FreeBSD" href="&enbase;/gnome/rss.xml" />
	
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
				  Basado en BSD UNIX&reg;
				</h1>				
				<p>FreeBSD es un avanzado sistema operativo para arquitecturas
				x86 compatibles (como Pentium&reg; y Athlon&trade;),
				amd64 compatibles (como Opteron&trade;, Athlon&trade;64 EM64T),
				UltraSPARC&reg;, IA-64, PC-98 y ARM.
				FreeBSD es un derivado de BSD, la versi&oacute;n de
				UNIX&reg; desarrollada en la Universidad
				de California, Berkeley.  FreeBSD es desarrollado y mantenido 
				por un
				<a href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/index.html">
				numeroso equipo de personas</a>.  El soporte para otras
				<a href="&base;/platforms/index.html">arquitecturas</a>
				est&aacute; en diferentes fases de desarrollo.</p>
				<div id="txtfrontfeaturelink">
				&raquo;<a href="&base;/about.html" title="M&aacute;s Informaci&oacute;n">M&aacute;s Informaci&oacute;n</a>
				</div> <!-- txtfrontfeaturelink -->
			</div> <!-- frontfeaturecontent -->
		</div> <!-- frontfeatureleft -->

		<div id="FRONTFEATUREMIDDLE">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Conseguir FreeBSD</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->
			
			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
				  <h2><a href="&enbase;/releases/">&Uacute;LTIMAS VERSIONES</a></h2>
				  <ul id="FRONTRELEASELIST">
					<li>
					  <a href="&u.rel.announce;">Release estable: &rel.current;</a>
					</li>
					<li>
					  <a href="&u.rel2.announce;">Release estable (heredera): &rel2.current;</a>
					</li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
				    <li>
				      <a href="&enbase;/where.html#helptest">Pr&oacute;xima Release
					&betarel.current; - &betarel.vers;</a>
				    </li>
				</xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
				    <li>
				      <a href="&enbase;/where.html#helptest">Pr&oacute;xima Release
					&betarel2.current; - &betarel2.vers;</a>
				    </li>
				</xsl:if>
				  </ul>
			  </div> <!-- frontreleasescontent -->
			</div> <!-- frontreleases -->
		</div> <!-- frontfeaturemiddle -->

		<div id="FRONTFEATURERIGHT">
			<h2 class="blockhide">Enlaces de idiomas</h2>
			<div id="LANGUAGENAV">
				<ul id="LANGUAGENAVLIST">
				  <li>
					<a href="&enbase;/de/" title="Alem&aacute;n">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="Ingl&eacute;s">en</a>
				  </li>
				  <li>
					<a href="&enbase;/es/" title="Espa&ntilde;ol">es</a>
				  </li>
				  <li>
					<a href="&enbase;/fr/" title="Franc&eacute;s">fr</a>
				  </li>
				  <li>
					<a href="&enbase;/hu/" title="H&uacute;ngaro">hu</a>
				  </li>
				  <li>
					<a href="&enbase;/it/" title="Italiano">it</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="Japon&eacute;s">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/ru/" title="Ruso">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/ru/" title="Chino (Simplificado)">zh_CN</a>
				  </li>
				</ul>				
			</div> <!-- languagenav -->

			<div id="MIRROR">
			  <form action="&enbase;/cgi/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="mirrorsel">R&eacute;plicas</label></h2>
				  <select id="MIRRORSEL" name="goto">
					  <xsl:call-template name="html-index-mirrors-options-list">
					    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
					  </xsl:call-template>
				  </select>
				</div> <!-- unnamed -->
				<input type="submit" value="Ir" />
			  </form>
			</div> <!-- mirror -->

			<div id="FRONTSHORTCUTS">
			  <div id="FRONTSHORTCUTSCONTENT" class="txtshortcuts">
				  <h2>ENLACES R&Aacute;PIDOS</h2>
				  <ul id="FRONTSHORTCUTLIST">
					<li>
					  <a href="&base;/support.html#mailing-list" title="Listas de distribuci&oacute;n">Listas de distribuci&oacute;n</a>
					</li>
					<li>
					  <a href="&base;/support/bugreports.html" title="Reporte un Fallo">Reporte un Fallo</a>
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
			      <a href="&base;/projects/newbies.html">&iquest;Nuevo en FreeBSD?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- featureright -->
				
            </div> <!-- frontfeaturecontainer -->

	    <br class="clearboth" />
            <div id="FRONTNEWSCONTAINER">
            	<div id="FRONTNEWS">
            	   <div id="FRONTNEWSCONTENT" class="txtnewsevent">
			<h2>&Uacute;LTIMAS NOTICIAS</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/news/newsflash.html" title="M&aacute;s Noticias">M&aacute;s Noticias</a>
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

			<h2>PR&Oacute;XIMOS EVENTOS</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&enbase;/events/" title="M&aacute;s Eventos">M&aacute;s Eventos</a>
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
					<a href="&base;/news/press.html" title="M&aacute;s medios">M&aacute;s medios</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- frontmediacontent -->
            	</div> <!-- frontmedia -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="FRONTSECURITY">
		   <div id="FRONTSECURITYCONTENT" class="txtnewsevent">

			<h2>AVISOS DE SEGURIDAD</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/security/" title="M&aacute;s Avisos de Seguridad">M&aacute;s</a>
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

      </div> <!-- CONTENT -->
      <div id="FOOTER">
	&copyright;

	La marca FreeBSD es una marca registrada de la Fundaci&oacute;n
	FreeBSD y el proyecto FreeBSD la usa con permiso de la <a
	  href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">Fundaci&oacute;n
	FreeBSD</a> 

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
