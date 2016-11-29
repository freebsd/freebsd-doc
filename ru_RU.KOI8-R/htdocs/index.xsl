<?xml version="1.0" encoding="koi8-r" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Проект FreeBSD">
]>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/www/ru/index.xsl,v 1.47 2006/01/16 21:27:51 gad Exp $

     Original revision: 45134
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
  <xsl:param name="html.header.script.google" select="'IGNORE'"/>

  <xsl:variable name="svnKeyword">$FreeBSD$</xsl:variable>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.content">
        <div id="frontcontainer">
          <div id="frontmain">
            <div id="frontfeaturecontainer">

		<div id="frontfeatureleft">
			<div id="frontfeaturecontent">
				<h1>
				  Основана на BSD &unix;
				</h1>
				<p>FreeBSD&reg; - это современная
				  операционная система для серверов,
				  десктопов и встроенных компьютерных <a
				  href="&base;/platforms/">платформ</a>.
				  Её код прошёл через более чем тридцать
				  лет непрерывного процесса развития,
				  совершенствования и оптимизации.  &os;
				  разрабатывается и поддерживается <a
				  href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">
				  большой командой разработчиков</a>.  &os;
				  обеспечивает современные сетевые возможности,
				  впечатляющую безопасность и
				  производительность на мировом уровне и
				  используется на одних из <a
				  href="&enbase;/doc/en_US.ISO8859-1/books/handbook/nutshell.html#introduction-nutshell-users">
				  самых загруженных веб-сайтов</a> мира и на
				  наиболее распространенных встроенных сетевых
				  устройствах и устройствах хранения.</p>

				  <div
				  id="txtfrontfeaturelink"> &#187;<a
				  href="&base;/about.html"
				  title="Подробнее">Подробнее</a>
				  </div> <!-- TXTFRONTFEATURELINK -->

                                <div id="txtfrontjournalblock">
                                <br/>&#187;
                                    <span
                                     id="txtfrontjournallink">
                                      Получить <a
                                       href="http://www.freebsdjournal.com/"
                                       title="&os;&nbsp;Journal">Ведомости &os;&nbsp;</a>
                                    </span> <!-- TXTFRONTJOURNALLINK -->
                                  </div> <!-- TXTFRONTJOURNALBLOCK -->

			  </div> <!-- FRONTFEATURECONTENT -->
		  </div> <!-- FRONTFEATURELEFT -->

		<div id="frontfeaturemiddle">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Загрузить &os;</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2><a href="&base;/releases/">ПОСЛЕДНИЕ РЕЛИЗЫ</a></h2>
				  <ul id="frontreleaseslist">
					<li>Продуктивный:&nbsp;<a
				href="&u.rel.announce;">&rel.current;</a>,<br />
					<a
				href="&u.rel2.announce;">&rel2.current;</a>,
					<a
				href="&u.rel3.announce;">&rel3.current;</a></li>
			    <xsl:if test="'&beta.upcoming;' != 'IGNORE'">
					<li>Предстоящий: <a
				href="&u.betarel.schedule;">&betarel.current;</a></li>
			    </xsl:if>
			    <xsl:if test="'&beta2.upcoming;' != 'IGNORE'">
					<li>Предстоящий: <a
				href="&u.betarel2.schedule;">&betarel2.current;</a></li>
			    </xsl:if>
					<li><a href="&base;/security/security.html#sup">Support Lifecycle</a></li>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

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

			<div id="mirror">
			  <form action="&cgibase;/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="mirrorsel">Зеркало</label></h2>
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
				  <h2>БЫСТРЫЕ ССЫЛКИ</h2>
				  <ul id="frontshortcutslist">
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
            <div id="frontnemscontainer">
            	<div id="frontnews">
            	   <div id="frontnewscontent" class="txtnewsevent">
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
            	<div id="frontevents">
		   <div id="fronteventscontent" class="txtnewsevent">

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
            	<div id="frontmedia">
		   <div id="frontmediacontent" class="txtnewsevent">

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
		<div id="frontsecurity">
		   <div id="frontsecuritycontent" class="txtnewsevent">

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
  </xsl:template>

  <xsl:template name="process.footer">
    &copyright;

    Название FreeBSD - это зарегистрированная торговая марка The FreeBSD
    Foundation и используется The FreeBSD Project с разрешения <a
      href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">The
    FreeBSD Foundation</a>.
    <a href="&base;/mailto.html" title="&header2.word.contact;">&header2.word.contact;</a>
  </xsl:template>
</xsl:stylesheet>
