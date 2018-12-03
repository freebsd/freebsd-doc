<?xml version="1.0" encoding="iso-8859-1"?>
<!-- Vertaald door: Siebrand Mazeland / Rene Ladan
     %SOURCE%	en_US.ISO8859-1/htdocs/index.xsl
     %SRCID%	41116
-->
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Het &os; Project">
]>

<!-- $FreeBSD$ -->

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

  <xsl:template name="process.content">
	<div id="frontcontainer">
	  <div id="frontmain">
	    <div id="frontfeaturecontainer">

		<div id="frontfeatureleft">
			<div id="frontfeaturecontent">
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
				    href="&enbase;/doc/nl_NL.ISO8859-1/books/handbook/nutshell.html#introduction-nutshell-users">drukste
				    websites</a> en de meest voorkomende
				  embedded netwerk- en opslagapparaten
				  gebruikt.</p>
				<div id="txtfrontfeaturelink">
				&raquo;<a href="&base;/about.html" title="Meer weten">Meer weten</a>
				</div> <!-- TXTFRONTFEATURELINK -->
			</div> <!-- FRONTFEATURECONTENT -->
		</div> <!-- FRONTFEATURELEFT -->

		<div id="frontfeaturemiddle">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Verkrijg &os;</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2><a href="&enbase;/releases/">NIEUWSTE UITGAVEN</a></h2>
				  <ul id="frontreleaseslist">
				    <li>Productie:&nbsp;<a
				href="&u.rel.announce;">&rel.current;</a></li>
				    <?ignore
				    <li>Verouderd: <a
				href="&u.rel2.announce;">&rel2.current;</a></li>
				    ?>
				    <xsl:if test="'&beta.upcoming;' != 'IGNORE'">
					<li>Aanstaand:
					  <a href="&u.betarel.schedule;">&betarel.current;</a>
					</li>
				    </xsl:if>
				    <xsl:if test="'&beta2.upcoming;' != 'IGNORE'">
					<li>Aanstaand:
					  <a href="&u.betarel2.schedule;">&betarel2.current;</a>
					</li>
				    </xsl:if>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="frontfeatureright">
			<h2 class="blockhide">Talen</h2>
			<div id="languagenav">
				<ul id="languagenavlist">
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
				<input type="submit" value="Kies" />
			  </form>
			</div> <!-- MIRROR -->

			<div id="frontshortcuts">
			  <div id="frontshortcutscontent" class="txtshortcuts">
				  <h2>SNELKEUZE</h2>
				  <ul id="frontshortcutslist">
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
	    <div id="frontnemscontainer">
	      <div id="frontnews">
		<div id="frontnewscontent" class="txtnewsevent">
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
		<div id="frontevents">
		   <div id="fronteventscontent" class="txtnewsevent">

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
		<div id="frontmedia">
		   <div id="frontmediacontent" class="txtnewsevent">

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
		<div id="frontsecurity">
		   <div id="frontsecuritycontent" class="txtnewsevent">

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
  </xsl:template>

  <xsl:template name="process.footer">
	&copyright;

	Het merk &os; is een geregistreerd handelsmerk van de &os; Foundation
	en wordt gebruikt door The &os; Project met toestemming van <a
	  href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">The
	  &os; Foundation</a>.
	<a href="&base;/mailto.html" title="&header2.word.contact;">&header2.word.contact;</a>
  </xsl:template>
</xsl:stylesheet>
