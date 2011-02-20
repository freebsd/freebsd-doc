<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Vertaald door: Siebrand Mazeland / Rene Ladan
     %SOURCE%	en/index.xsl
     %SRCID%	1.170
-->
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "Het &os; Project">
]>

<!-- $FreeBSD: www/nl/index.xsl,v 1.3 2009/06/08 18:58:09 rene Exp $ -->

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

  <xsl:output type="html" encoding="&xml.encoding;"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title>&title;</title>
	<meta name="description" content="Het &os; Project"/>
	<meta name="keywords" content="&os;, BSD, UNIX, Ondersteuning, Ports,
	      Release, Applicatie, Software, Handboek, FAQ, Tutorials, Bugs,
	      CVS, CVSup, Nieuws, Commerciele Leveranciers, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
<!--
	VOOR VERTALERS:

	Vertaal de attributen "Normal Text" en "Large Text" in de volgende twee regels niet.
	Ze zijn geen letterlijke tekst maar JavaScript-parameters.  Als ze veranderd worden
	resulteert dit in opmaakfouten.
-->
	<link rel="stylesheet" media="screen" href="&enbase;/layout/css/fixed.css?20060509" type="text/css" title="Normal Text" />
	<link rel="alternate stylesheet" media="screen" href="&enbase;/layout/css/fixed_large.css" type="text/css" title="Large Text" />
	<script type="text/javascript" src="&enbase;/layout/js/styleswitcher.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="&os; Projectnieuws" href="&enbase;/news/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="&os; Beveiliging" href="&enbase;/security/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="&os; GNOME Projectnieuws" href="&enbase;/gnome/rss.xml" />

	<!-- Formatted to be easy to spam harvest, please do not reformat. -->
	<xsl:comment>
	Spamval, niet emailen:
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
				  Gebaseerd op BSD &unix;
				</h1>
				<p>&os;&reg; is een geavanceerd
				  besturingssystem voor moderne <a
				    href="&enbase;/platforms/">platforms</a>
				  voor servers, desktop, en embedded computers.
				  De broncode van &os; heeft meer dan dertig
				  jaar van continue ontwikkeling, verbetering en
				  optimalisatie doorgemaakt.  Het wordt
				  ontwikkeld en onderhouden door een <a
				    href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">groot
				    team van individuen</a>.  &os; biedt
				  geavanceerd netwerken, indrukwekkende
				  beveiligingsmogelijkheden en topprestaties en
				  wordt door sommige van 's werelds <a
				    href="&enbase;/doc/nl_NL.ISO8859-1/books/handbook/nutshell.html#INTRODUCTION-NUTSHELL-USERS">drukste
				    websites</a> en de meest voorkomende
				  embedded netwerk- en opslagapparaten
				  gebruikt.</p>
				<div id="TXTFRONTFEATURELINK">
				&#187;<a href="&base;/about.html" title="Meer weten">Meer weten</a>
				</div> <!-- TXTFRONTFEATURELINK -->
			</div> <!-- FRONTFEATURECONTENT -->
		</div> <!-- FRONTFEATURELEFT -->

		<div id="FRONTFEATUREMIDDLE">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Verkrijg &os;</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
				  <h2><a href="&enbase;/releases/">NIEUWSTE UITGAVEN</a></h2>
				  <ul id="FRONTRELEASESLIST">
					<li>
					  <a href="&u.rel.announce;">Productie-uitgave &rel.current;</a>
					</li>
					<li>
					  <a href="&u.rel2.announce;">Productie-uitgave (ouder) &rel2.current;</a>
					</li>
				    <xsl:if test="'&beta.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">Volgende uitgave
					    &betarel.current; - &betarel.vers;</a>
					</li>
				    </xsl:if>
				    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">Volgende uitgave
					    &betarel2.current; - &betarel2.vers;</a>
					</li>
				    </xsl:if>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="FRONTFEATURERIGHT">
			<h2 class="blockhide">Talen</h2>
			<div id="LANGUAGENAV">
				<ul id="LANGUAGENAVLIST">
				  <li>
					<a href="&enbase;/de/" title="Duits">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="Engels">en</a>
				  </li>
				  <li>
					<a href="&enbase;/es/" title="Spaans">es</a>
				  </li>
				  <li>
					<a href="&enbase;/fr/" title="Frans">fr</a>
				  </li>
				  <li>
					<a href="&enbase;/hu/" title="Hongaars">hu</a>
				  </li>
				  <li>
					<a href="&enbase;/it/" title="Italiaans">it</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="Japans">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/nl/" title="Nederlands">nl</a>
				  </li>
				  <li>
					<a href="&enbase;/ru/" title="Russisch">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_CN/" title="Chinees (Vereenvoudigd)">zh_CN</a>
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
				<input type="submit" value="Kies" />
			  </form>
			</div> <!-- MIRROR -->

			<div id="FRONTSHORTCUTS">
			  <div id="FRONTSHORTCUTSCONTENT" class="txtshortcuts">
				  <h2>SNELKEUZE</h2>
				  <ul id="FRONTSHORTCUTSLIST">
					<li>
					  <a href="&enbase;/community/mailinglists.html" title="Mailinglijsten">Mailinglijsten</a>
					</li>
					<li>
					  <a href="&base;/send-pr.html" title="Rapporteer een bug">Rapporteer een bug</a>
					</li>
					<li>
					  <a href="&enbase;/doc/en_US.ISO8859-1/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="&enbase;/doc/nl_NL.ISO8859-1/books/handbook/index.html" title="Handboek">Handboek</a>
					</li>
					<li>
					  <a href="&enbase;/ports/index.html" title="Ports">Ports</a>
					</li>

				  </ul>
			  </div> <!-- FRONTSHORTCUTSCONTENT -->
			</div> <!-- FRONTSHORTCUTS -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div><b style="display: none">.</b></div></div>
			    <div class="frontnewcontent">
			      <a href="&enbase;/projects/newbies.html">Nieuw bij &os;?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- FEATURERIGHT -->

	    </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
	    <div id="FRONTNEMSCONTAINER">
	      <div id="FRONTNEWS">
		<div id="FRONTNEWSCONTENT" class="txtnewsevent">
			<h2>LAATSTE NIEUWS</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&enbase;/news/newsflash.html" title="Meer nieuws">Meer nieuws</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/news/news.xml" title="Nieuws RSS feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Nieuws RSS feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		  </div> <!-- FRONTNEWSCONTENT -->
		</div> <!-- FRONTNEWS -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="FRONTEVENTS">
		   <div id="FRONTEVENTSCONTENT" class="txtnewsevent">

			<h2>EVENEMENTEN</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&enbase;/events/" title="Meer evenementen">Meer evenementen</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
		</div> <!-- FRONTEVENTS -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="FRONTMEDIA">
		   <div id="FRONTMEDIACONTENT" class="txtnewsevent">

			<h2>IN DE MEDIA</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&enbase;/news/press.html" title="Meer pers">Meer pers</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
		</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="FRONTSECURITY">
		   <div id="FRONTSECURITYCONTENT" class="txtnewsevent">

			<h2>BEVEILIGING</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&enbase;/security/advisories.html" title="Meer beveiligingsadviezen">Meer</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/security/rss.xml" title="Beveiligingsadviezen RSS feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Beveiligingsadviezen RSS feed" /></a>
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
				<a href="&enbase;/security/notices.html" title="Meer erratamededelingen">Meer</a>
			      </li>
			      <li class="last-child">
				<a href="&enbase;/security/errata.xml" title="Erratamededelingen RSS feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Erratamededelingen RSS feed"/></a>
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
      <div id="FOOTER">
	&copyright;

	Het merk &os; is een geregistreerd handelsmerk van The &os;
	Foundation en is door Het &os; Project gebruikt met toestemming van
	<a href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">The &os; Foundation</a>.
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
