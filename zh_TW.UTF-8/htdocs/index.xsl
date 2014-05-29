<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>

<!-- The FreeBSD Traditional Chinese Documentation Project -->
<!-- Original revision: 1.158 -->
<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/xml/xhtml.xsl"/>

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
				<h1>
				  Based on BSD &unix;
				</h1>
				<p>
				  FreeBSD&reg; 是一種先進的作業系統，可支援
				  x86 相容(包括 Pentium&reg; 和 Athlon&trade;)、
				  amd64 相容(包括 Opteron&trade;、 Athlon&trade;64 和 EM64T)、
				  UltraSPARC&reg;、 IA-64、 PC-98 以及 ARM 架構的電腦。
				  其源自於 BSD， 由加州大學伯克利分校開發的 &unix; 版本。 目前由
				  <a href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">有許多人參與的開發團隊</a> 所維護。
				  此外，對各種 <a href="&base;/platforms/">硬體平台</a> 的支援程度，
				  也各自有所不同。
				</p>
				<div id="txtfrontfeaturelink">
				&#187;<a href="&base;/about.html" title="參閱詳情">參閱詳情</a>
				</div> <!-- TXTFRONTFEATURELINK -->
			</div> <!-- FRONTFEATURECONTENT -->
		</div> <!-- FRONTFEATURELEFT -->

		<div id="frontfeaturemiddle">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">立即取得 FreeBSD</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2><a href="&enbase;/releases/"> 最新版本 </a></h2>
				  <ul id="frontreleaseslist">
					<li>
					  <a href="&enbase;/&u.rel.announce;">Production Release &rel.current;</a>
					</li>
					<li>
					  <a href="&enbase;/&u.rel2.announce;">(舊式)Production Release &rel2.current;</a>
					</li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">即將發佈
				            &betarel.current; - &betarel.vers;</a>
					</li>
			    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">即將發佈
				            &betarel2.current; - &betarel2.vers;</a>
					</li>
			    </xsl:if>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="frontfeatureright">
			<h2 class="blockhide">語言</h2>
			<div id="languagenav">
				<ul id="languagenavlist">
				  <li>
					<a href="&enbase;/de/" title="德語">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="英語">en</a>
				  </li>
				  <li>
					<a href="&enbase;/es/" title="西語">es</a>
				  </li>
				  <li>
					<a href="&enbase;/fr/" title="法語">fr</a>
				  </li>
				  <li>
					<a href="&enbase;/it/" title="義語">it</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="日語">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/ru/" title="俄語">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_CN/" title="中文(簡體)">zh_CN</a>
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
				  <h2>常用連結</h2>
				  <ul id="frontshortcutslist">
					<li>
					  <a href="&enbase;/community/mailinglists.html" title="郵件論壇">郵件論壇</a>
					</li>
					<li>
					  <a href="&base;/send-pr.html" title="報告 Bug">報告 Bug</a>
					</li>
					<li>
					  <a href="&enbase;/doc/zh_TW.UTF-8/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="&enbase;/doc/zh_TW.UTF-8/books/handbook/index.html" title="Handbook">Handbook</a>
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
			      <a href="&enbase;/projects/newbies.html">不熟悉 FreeBSD？</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- FEATURERIGHT -->

            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="frontnemscontainer">
            	<div id="frontnews">
            	   <div id="frontnewscontent" class="txtnewsevent">
			<h2>新聞</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/news/newsflash.html" title="更多新聞">更多新聞</a>
				  </li>
				  <li class="last-child">
					<a href="&base;/news/news.rdf" title="新聞 RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="新聞 RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontevents">
		   <div id="fronteventscontent" class="txtnewsevent">

			<h2>近期活動</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&enbase;/events/" title="更多活動">更多活動</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontmedia">
		   <div id="frontmediacontent" class="txtnewsevent">

			<h2>媒體報導</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&base;/news/press.html" title="更多媒體報導">更多媒體報導</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
            	</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="frontsecurity">
		   <div id="frontsecuritycontent" class="txtnewsevent">

			<h2>安全公告</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/security/" title="更多安全公告">更多</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/security/advisories.rdf" title="安全公告 RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="安全公告 RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>勘誤公告</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			</xsl:call-template>

			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTSECURITYCONTENT -->
            	</div> <!-- FRONTSECURITY -->

		<br class="clearboth" />

            </div> <!-- FRONTNEMSCONTAINER -->
          </div> <!-- FRONTMAIN -->
        </div> <!-- FRONTCONTAINER -->
  </xsl:template>
</xsl:stylesheet>
