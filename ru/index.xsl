<?xml version="1.0" encoding="koi8-r" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "Проект FreeBSD">
]>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD: www/ru/index.xsl,v 1.30 2006/01/17 09:27:09 bvs Exp $
     $FreeBSDru: frdp/www/ru/index.xsl,v 1.47 2006/01/16 21:27:51 gad Exp $

     Original revision: 1.127
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD: www/ru/index.xsl,v 1.30 2006/01/17 09:27:09 bvs Exp $'"/>

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
	<meta name="description" content="Проект FreeBSD"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Gallery,
	  Release, Application, Software, Handbook, FAQ, Tutorials, Bugs, 
	  CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix,
	  Поддержка, Галерея, Релиз, Приложение, Программы, Руководство,
	  Учебники, Ошибки, Новости, Коммерческие Поставщики,
	  домашняя страница"/>
	<link rel="shortcut icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" media="screen" href="&enbase;/layout/css/fixed.css" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="&enbase;/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="&enbase;/layout/js/styleswitcher.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="Новости проекта FreeBSD" href="&base;/news/news.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Security Advisories" href="&base;/security/advisories.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="Новости проекта FreeBSD GNOME" href="&base;/gnome/news.rdf" />
	
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
				  Основана на BSD UNIX&#174;
				</h1>				
				<p>FreeBSD - это современная операционная система для
				компьютеров, совместимых с архитектурами x86 (в том числе
				Pentium&#174; и Athlon&#8482;), amd64 (включая Opteron&#8482;,
				Athlon 64 и EM64T), Alpha/AXP, IA-64, PC-98 и
				UltraSPARC&#174;.  Она основана на BSD, версии
				&unix;, созданной в Калифорнийском
				Университете в Беркли.  Она разрабатывается и поддерживается <a
				href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/index.html">
				большой командой разработчиков</a>.  Поддержка <a
				href="platforms/index.html">других платформ</a>
				находится на разных стадиях разработки.</p>
				<div id="txtfrontfeaturelink">
				&#187;<a href="&base;/about.html" title="Далее...">Далее...</a>
				</div> <!-- txtfrontfeaturelink -->
			</div> <!-- frontfeaturecontent -->
		</div> <!-- frontfeatureleft -->

		<div id="frontfeaturemiddle">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div>&#160;</div>&#160;</div>
				<div class="frontgetcontent">
				<a href="&base;/where.html">Получить FreeBSD сейчас</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div>&#160;</div>&#160;</div>
			</div> <!-- frontgetroundbox -->
			
			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2>Последние релизы</h2>
				  <ul id="frontreleaseslist">
					<li>
					  <a href="../&u.rel.announce;">Продуктивный релиз &rel.current;</a>
					</li>
					<li>
					  <a href="&u.rel2.announce;">(Старый) Продуктивный релиз &rel2.current;</a>
					</li>
				  </ul>
			  </div> <!-- frontreleasescontent -->
			</div> <!-- frontreleases -->
		</div> <!-- frontfeaturemiddle -->

		<div id="frontfeatureright">
			<h2 class="blockhide">Языки</h2>
			<div id="languagenav">
				<ul id="languagenavlist">
				  <li>
					<a href="&enbase;/de/" title="Немецкий">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="Английский">en</a>
				  </li>
				  <li>
					<a href="&enbase;/es/" title="Испанский">es</a>
				  </li>
				  <li>
					<a href="&enbase;/fr/" title="Французский">fr</a>
				  </li>
				  <li>
					<a href="&enbase;/it/" title="Итальянский">it</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="Японский">ja</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/ru/" title="Русский">ru</a>
				  </li>
				</ul>
			</div> <!-- languagenav -->

			<div id="mirror">
			  <form action="&enbase;/cgi/mirror.cgi" method="get">
				<div>
	 			<h2 class="blockhide"><label for="mirrorsel">Зеркало</label></h2>
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
				  <h2>Быстрые ссылки</h2>
				  <ul id="frontshortcutslist">
					<li>
					  <a href="&base;/support.html#mailing-list" title="Списки рассылки">Списки рассылки</a>
					</li>
					<li>
					  <a href="&base;/platforms/" title="Платформы">Платформы</a>
					</li>
					<li>
					  <a href="&base;/send-pr.html" title="Отправка сообщения">Отправка сообщения</a>
					</li>
					<li>
					  <a href="&enbase;/doc/&url.doc.langcode;/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="http://www.freebsdfoundation.org/" title="Фонд">Фонд FreeBSD</a>
					</li>
				  </ul>
			  </div> <!-- frontshortcutscontent -->
			</div> <!-- frontshortcuts -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div>&#160;</div>&#160;</div>
			    <div class="frontnewcontent">
			    <a href="&base;/projects/newbies.html">Новичок во FreeBSD?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div>&#160;</div>&#160;</div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- featureright -->
				
            </div> <!-- frontfeaturecontainer -->

	    <br class="clearboth" />
            <div id="frontnemscontainer">
            	<div id="frontnews">
            	   <div id="frontnewscontent" class="txtnewsevent">
		     <h2>Последние новости</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
				  <a href="&base;/news/newsflash.html" title="Далее...">Далее...</a>
				  </li>
				  <li class="last-child">
					<a href="&base;/news/news.rdf" title="News RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- frontnewscontent -->
            	</div> <!-- frontnews -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontevents">
		   <div id="fronteventscontent" class="txtnewsevent">

			<h2>Предстоящие события</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
				<xsl:with-param name="curdate.xml" select="$curdate.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
				  <a href="&base;/events/" title="Далее...">Далее...</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- frontnewsevents -->
            	</div> <!-- frontevents -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontmedia">
		   <div id="frontmediacontent" class="txtnewsevent">

			   <h2>FreeBSD в прессе</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
				  <a href="&base;/news/press.html" title="Далее...">Далее...</a>
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
				  <a href="&base;/security/" title="Предыдущие бюллетени по безопасности">Дополнительно...</a>
				  </li>
				  <li>
				  <a href="&base;/send-pr.html" title="Послать сообщение об ошибке">Сообщить об ошибке</a>
				  </li>
				  <li class="last-child">
					<a href="&base;/security/advisories.rdf" title="Security Advisories RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
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
      <div id="FOOTER">
	&copyright;

	The mark FreeBSD is a registered trademark of The FreeBSD
	Foundation and is used by The FreeBSD Project with the
	permission of <a
	  href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">The
	FreeBSD Foundation</a>.

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
