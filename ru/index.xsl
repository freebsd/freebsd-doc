<?xml version="1.0" encoding="KOI8-R" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD: www/ru/index.xsl,v 1.26 2005/06/19 12:08:30 andy Exp $
     $FreeBSDru: frdp/www/ru/index.xsl,v 1.45 2005/06/18 09:37:23 andy Exp $

     Original revision: 1.127
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="enbase" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/ru/index.xsl,v 1.26 2005/06/19 12:08:30 andy Exp $'"/>
  <xsl:variable name="title" select="'Проект FreeBSD'"/>

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

  <xsl:output type="html" encoding="koi8-r"
    doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

<xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="$title"/></title>
	<meta name="description" content="Проект FreeBSD"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Gallery,
	  Release, Application, Software, Handbook, FAQ, Tutorials, Bugs, 
	  CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix,
	  Поддержка, Галерея, Релиз, Приложение, Программы, Руководство,
	  Учебники, Ошибки, Новости, Коммерческие Поставщики,
	  домашняя страница"/>
	<link rel="shortcut icon" href="{$enbase}/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="{$enbase}/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" media="screen" href="{$enbase}/layout/css/fixed.css" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="{$enbase}/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="{$enbase}/layout/js/styleswitcher.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="Новости проекта FreeBSD" href="{$base}/news/news.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Security Advisories" href="{$base}/security/advisories.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="Новости проекта FreeBSD GNOME" href="{$base}/gnome/news.rdf" />
	
	<!-- Formatted to be easy to spam harvest, please do not reformat. -->
	<xsl:comment>
        Spamtrap, do not email:
        &lt;a href="mailto:bruscar@freebsd.org"&gt;bruscar@freebsd.org&lt;/a&gt;
	</xsl:comment>
      </head>

      <body>

   <div id="containerwrap">
    <div id="container">
      <xsl:copy-of select="$header2"/>
      <div id="content">

        <div id="frontcontainer">
          <div id="frontmain">
            <div id="frontfeaturecontainer">

		<div id="frontfeatureleft">
			<div id="frontfeaturecontent">
				<h1>
				  Based on BSD UNIX&#174;
				</h1>				
				<p>FreeBSD - это современная операционная система для
				компьютеров, совместимых с архитектурами x86 (в том числе
				Pentium&#174; и Athlon&#8482;), amd64 (включая Opteron&#8482;,
				Athlon 64 и EM64T), Alpha/AXP, IA-64, PC-98 и
				UltraSPARC&#174;.  Она основана на BSD, версии
				<xsl:value-of select="$unix"/>, созданной в Калифорнийском
				Университете в Беркли.  Она разрабатывается и поддерживается <a
				href="{$base}/doc/en_US.ISO8859-1/articles/contributors/index.html">
				большой командой разработчиков</a>.  Поддержка <a
				href="platforms/index.html">других платформ</a>
				находится на разных стадиях разработки.</p>
				<div id="txtfrontfeaturelink">
				&#187;<a href="{$base}/about.html" title="Learn More">Learn More</a>
				</div> <!-- txtfrontfeaturelink -->
			</div> <!-- frontfeaturecontent -->
		</div> <!-- frontfeatureleft -->

		<div id="frontfeaturemiddle">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div>&#160;</div>&#160;</div>
				<div class="frontgetcontent">
				  <a href="{$base}/where.html">Get FreeBSD Now</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div>&#160;</div>&#160;</div>
			</div> <!-- frontgetroundbox -->
			
			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2>LATEST RELEASES</h2>
				  <ul id="frontreleaseslist">
					<li>
					  <a href="{$u.rel.announce}">Продуктивный релиз <xsl:value-of select="$rel.current"/></a>
					</li>
					<li>
					  <a href="{$u.rel2.announce}">(Старый) Продуктивный релиз <xsl:value-of select="$rel2.current"/></a>
					</li>
				  </ul>
			  </div> <!-- frontreleasescontent -->
			</div> <!-- frontreleases -->
		</div> <!-- frontfeaturemiddle -->

		<div id="frontfeatureright">
			<h2 class="blockhide">Language Links</h2>
			<div id="languagenav">
				<ul id="languagenavlist">
				  <li>
					<a href="{$enbase}/de/" title="Немецкий">de</a>
				  </li>
				  <li>
					<a href="{$enbase}/" title="Английский">en</a>
				  </li>
				  <li>
					<a href="{$enbase}/es/" title="Испанский">es</a>
				  </li>
				  <li>
					<a href="{$enbase}/fr/" title="Французский">fr</a>
				  </li>
				  <li>
					<a href="{$enbase}/it/" title="Итальянский">it</a>
				  </li>
				  <li>
					<a href="{$enbase}/ja/" title="Японский">ja</a>
				  </li>
				  <li class="last-child">
					<a href="{$enbase}/ru/" title="Русский">ru</a>
				  </li>
				</ul>
			</div> <!-- languagenav -->

			<div id="mirror">
			  <form action="{$enbase}/cgi/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="mirrorsel">Mirror</label></h2>
				  <select id="mirrorsel" name="goto">
					  <xsl:call-template name="html-index-mirrors-options-list">
					    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
					  </xsl:call-template>
				  </select>
				</div> <!-- unnamed -->
			  </form>
			</div> <!-- mirror -->

			<div id="frontshortcuts">
			  <div id="frontshortcutscontent" class="txtshortcuts">
				  <h2>SHORTCUTS</h2>
				  <ul id="frontshortcutslist">
					<li>
					  <a href="{$base}/support.html#mailing-list" title="Списки рассылки">Списки рассылки</a>
					</li>
					<li>
					  <a href="{$base}/platforms/" title="Платформы">Платформы</a>
					</li>
					<li>
					  <a href="{$base}/send-pr.html" title="Отправка сообщения">Отправка сообщения</a>
					</li>
					<li>
					  <a href="{$enbase}/doc/{$url.doc.langcode}/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="http://www.freebsdfoundation.org/" title="Foundation">Foundation</a>
					</li>
				  </ul>
			  </div> <!-- frontshortcutscontent -->
			</div> <!-- frontshortcuts -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div>&#160;</div>&#160;</div>
			    <div class="frontnewcontent">
			      <a href="{$base}/projects/newbies.html">New to FreeBSD?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div>&#160;</div>&#160;</div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- featureright -->
				
            </div> <!-- frontfeaturecontainer -->

	    <br class="clearboth" />
            <div id="frontnemscontainer">
            	<div id="frontnews">
            	   <div id="frontnewscontent" class="txtnewsevent">
			<h2>LATEST NEWS</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="{$base}/news/newsflash.html" title="More News">More News</a>
				  </li>
				  <li class="last-child">
					<a href="{$base}/news/news.rdf" title="News RSS Feed"><img class="rssimage" src="{$enbase}/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- frontnewscontent -->
            	</div> <!-- frontnews -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontevents">
		   <div id="fronteventscontent" class="txtnewsevent">

			<h2>UPCOMING EVENTS</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
				<xsl:with-param name="curdate.xml" select="$curdate.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="{$base}/events/" title="More Events">More Events</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- frontnewsevents -->
            	</div> <!-- frontevents -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontmedia">
		   <div id="frontmediacontent" class="txtnewsevent">

			<h2>IN THE MEDIA</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="{$base}/news/press.html" title="More Media">More Media</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- frontmediacontent -->
            	</div> <!-- frontmedia -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="frontsecurity">
		   <div id="frontsecuritycontent" class="txtnewsevent">

			<h2>Бюллетени безопасности</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="{$base}/security/" title="More Security Advisories">More</a>
				  </li>
				  <li>
					<a href="{$base}/send-pr.html" title="Submit a Problem Report">Submit Bug</a>
				  </li>
				  <li class="last-child">
					<a href="{$base}/security/advisories.rdf" title="Security Advisories RSS Feed"><img class="rssimage" src="{$enbase}/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>Сообщения о проблемах</h2>
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

      </div> <!-- content -->
      <div id="footer">
        <xsl:copy-of select="$copyright"/><br />
        <xsl:copy-of select="$date"/>
      </div> <!-- footer -->
    </div> <!-- container -->
   </div> <!-- containerwrap -->

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
