<?xml version="1.0" encoding="koi8-r" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "Проект FreeBSD">
]>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD: www/ru/index.xsl,v 1.38 2010/07/05 09:11:54 maxim Exp $
     $FreeBSDru: frdp/www/ru/index.xsl,v 1.47 2006/01/16 21:27:51 gad Exp $

     Original revision: 1.170
-->

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
	<meta name="description" content="Проект FreeBSD"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Ports,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix,
	      Поддержка, Галерея, Релиз, Приложение, Программы, Руководство,
	      Учебники, Ошибки, Новости, Коммерческие Поставщики,
	      домашняя страница"/>
	<link rel="shortcut icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
<!--
	FOR TRANSLATORS:

	Do not translate the "Normal Text" and "Large Text" attributes in the
	following two lines.  They are not literal texts but JavaScript
	parameters.  Changing them will result in rendering errors.
-->
    <link rel="stylesheet" media="screen" href="&enbase;/layout/css/fixed.css?20060509" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="&enbase;/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="&enbase;/layout/js/styleswitcher.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="Новости проекта FreeBSD" href="&enbase;/news/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="Бюллетени безопасности FreeBSD" href="&base;/security/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="Новости проекта FreeBSD GNOME" href="&enbase;/gnome/rss.xml" />

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
				  Основана на BSD &unix;
				</h1>				
				<p>FreeBSD&reg; - это современная операционная система для
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
				&#187;<a href="&base;/about.html" title="Подробнее">Подробнее</a>

				  </div> <!-- TXTFRONTFEATURELINK -->
			  </div> <!-- FRONTFEATURECONTENT -->
		  </div> <!-- FRONTFEATURELEFT -->

		<div id="FRONTFEATUREMIDDLE">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Получить FreeBSD сейчас</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
				  <h2><a href="&base;/releases/">ПОСЛЕДНИЕ РЕЛИЗЫ</a></h2>
				  <ul id="FRONTRELEASESLIST">
					<li>
					  <a href="../&u.rel.announce;">Продуктивный релиз &rel.current;</a>
					</li>
					<li>
					    <a href="../&u.rel2.announce;">(Старый) Продуктивный релиз &rel2.current;</a>
					</li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">Upcoming Release
				            &betarel.current; - &betarel.vers;</a>
					</li>
			    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">Upcoming Release
				            &betarel2.current; - &betarel2.vers;</a>
					</li>
			    </xsl:if>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="FRONTFEATURERIGHT">
			<h2 class="blockhide">Языки</h2>
			<div id="LANGUAGENAV">
				<ul id="LANGUAGENAVLIST">
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
					<a href="&enbase;/hu/" title="Венгерский">hu</a>
				  </li>
				  <li>
					<a href="&enbase;/it/" title="Итальянский">it</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="Японский">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/nl/" title="Голландский">nl</a>
				  </li>
				  <li>
					<a href="&base;/" title="Русский">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_CN/" title="Китайский (упрощенный)">zh_CN</a>
				  </li>
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="MIRROR">
			  <form action="&cgibase;/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="MIRRORSEL">Зеркало</label></h2>
				  <select id="MIRRORSEL" name="goto">
					  <xsl:call-template name="html-index-mirrors-options-list">
					    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
					  </xsl:call-template>
				  </select>
				</div> <!-- unnamed -->
			  </form>
			</div> <!-- MIRROR -->

			<div id="FRONTSHORTCUTS">
			  <div id="FRONTSHORTCUTSCONTENT" class="txtshortcuts">
				  <h2>БЫСТРЫЕ ССЫЛКИ</h2>
				  <ul id="FRONTSHORTCUTSLIST">
					<li>
					  <a href="&base;/community/mailinglists.html" title="Списки рассылки">Списки рассылки</a>
					</li>
					<li>
					  <a href="&base;/support/bugreports.html" title="Сообщить об ошибке">Сообщить об ошибке</a>
					</li>
					<li>
					  <a href="&enbase;/doc/&url.doc.langcode;/books/faq/index.html" title="Часто задаваемые вопросы">Часто задаваемые вопросы</a>
					</li>
					<li>
					  <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/index.html" title="Руководство по FreeBSD">Руководство</a>
					</li>
					<li>
					  <a href="&base;/ports/index.html" title="Коллекция портов">Порты</a>
					</li>

				  </ul>
			  </div> <!-- FRONTSHORTCUTSCONTENT -->
			</div> <!-- FRONTSHORTCUTS -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div><b style="display: none">.</b></div></div>
			    <div class="frontnewcontent">
			      <a href="&base;/projects/newbies.html">Впервые на FreeBSD?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- FEATURERIGHT -->

            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="FRONTNEMSCONTAINER">
            	<div id="FRONTNEWS">
            	   <div id="FRONTNEWSCONTENT" class="txtnewsevent">
			<h2>ПОСЛЕДНИЕ НОВОСТИ</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/news/newsflash.html" title="Все новости">Все новости</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/news/rss.xml" title="News RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTEVENTS">
		   <div id="FRONTEVENTSCONTENT" class="txtnewsevent">

			<h2>ПРЕДСТОЯЩИЕ СОБЫТИЯ</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&base;/events/" title="Все события">Все события</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTMEDIA">
		   <div id="FRONTMEDIACONTENT" class="txtnewsevent">

			   <h2>В СМИ</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&base;/news/press.html" title="Всё в СМИ">Всё в СМИ</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
            	</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="FRONTSECURITY">
		   <div id="FRONTSECURITYCONTENT" class="txtnewsevent">

			<h2>БЮЛЛЕТЕНИ БЕЗОПАСНОСТИ</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/security/advisories.html" title="Все бюллетени по безопасности">Все</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/security/rss.xml" title="Security Advisories RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Security Advisories RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>УВЕДОМЛЕНИЯ ОБ ИСПРАВЛЕНИЯХ</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			</xsl:call-template>

			  <div>
			    	<ul class="newseventslist">
				  <li class="first-child">
				    <a href="&base;/security/notices.html" title="Все уведомления об исправлениях">Все</a>
				  </li>
				  <li class="last-child">
				    <a href="&enbase;/security/errata.xml" title="Errata Notices RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Errata Notices RSS Feed" /></a>
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

	Знак FreeBSD является зарегистрированным товарным знаком фонда
	FreeBSD и используется проектом FreeBSD с разрешения
	<a href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">
	  фонда FreeBSD</a>.

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
