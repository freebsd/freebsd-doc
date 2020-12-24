<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>

<!-- $FreeBSD$ -->
<!-- The FreeBSD Simplified Chinese Documentation Project -->
<!-- Original Revision: bfea49dccc (r54642) -->

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

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.content">
        <div id="frontcontainer">
          <div id="frontmain">
            <div id="frontfeaturecontainer">

		<div id="frontfeatureleft">
			<div id="frontfeaturecontent">
				<h1>&os; 项目</h1>

				<p>&os; 是一个适用于现代服务器，桌面与嵌入式 <a href="&base;/platforms/">平台</a> 的操作系统。
				  由一个庞大的
				  <a
				  href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">开发人员团队</a>
				持续开发超过三十年。
				&os; 先进的网络、安全性和存储方面的特色使得它成为许多
				  <a href="&enbase;/doc/zh_CN.UTF-8/books/handbook/nutshell.html#introduction-nutshell-users">大型网站</a>
			以及最普遍的嵌入式网络与存储设备的平台选择。 </p>

                                  <div
				  id="txtfrontfeaturelink"> &#187;<a
				  href="&base;/about.html"
				  title="Learn More">了解更多</a>
				  </div> <!-- TXTFRONTFEATURELINK -->

				  <div id="txtfrontjournalblock">
				    <br/>&#187;
				    <span
				     id="txtfrontjournallink">
				      立即获取 <a
				       href="http://www.freebsdjournal.com/"
				       title="&os;&nbsp;Journal">&os;&nbsp;Journal</a>
				    </span> <!-- TXTFRONTJOURNALLINK -->
				  </div> <!-- TXTFRONTJOURNALBLOCK -->

				  <!-- IMPORTANT NOTICES -->
				  <!--
				  <div
				    style="width:640px; margin: 16px 16px 16px 32px; auto">

				    <h2>ANNOUNCEMENT: [header]</h2>

				    <p align="justify">[text]</p>
				  </div>
				  -->
				  <!-- END IMPORTANT NOTICES -->

			  </div> <!-- FRONTFEATURECONTENT -->
		  </div> <!-- FRONTFEATURELEFT -->

		<div id="frontfeaturemiddle">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">获取 &os;</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2><a href="&base;/releases/">支持的版本</a></h2>
				  <ul id="frontreleaseslist">
					<li>生产环境适用:&nbsp;<a
				href="&u.rel122.announce;">&rel122.current;</a>,
				<a
				href="&u.rel121.announce;">&rel121.current;</a>,
				<a
				href="&u.rel114.announce;">&rel114.current;</a></li>
				<xsl:if test="'&beta.upcoming;' != 'IGNORE'">
					<li>即将发布: <a
				href="&u.betarel.schedule;">&betarel.current;</a></li>
			    </xsl:if>
			    <xsl:if test="'&beta2.upcoming;' != 'IGNORE'">
					<li>即将发布: <a
				href="&u.betarel2.schedule;">&betarel2.current;</a></li>
			    </xsl:if>
					<li><a href="&base;/security/security.html#sup">支持生命周期</a></li>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="frontfeatureright">
			<h2 class="blockhide">语言</h2>
			<div id="languagenav">
				<ul id="languagenavlist">
				  <li>
					<a href="&enbase;/de/" title="德语">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="英语">en</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="日语">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/zh_CN/" title="中文 (简体)">zh_CN</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_TW/" title="中文 (繁体)">zh_TW</a>
				  </li>
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="frontshortcuts">
			  <div id="frontshortcutscontent" class="txtshortcuts">
				  <h2>常用链接</h2>
				  <ul id="frontshortcutslist">
					<li>
					  <a href="&enbase;/community/mailinglists.html" title="邮件列表">邮件列表</a>
					</li>
					<li>
					  <a href="&enbase;/support/bugreports.html" title="问题报告">问题报告</a>
					</li>
					<li>
					  <a href="&enbase;/doc/en_US.ISO8859-1/books/faq/index.html" title="常见问题解答">常见问题解答</a>
					</li>
					<li>
					  <a href="&enbase;/doc/zh_CN.UTF-8/books/handbook/index.html" title="使用手册">使用手册</a>
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
			      <a href="&enbase;/projects/newbies.html">不熟悉 FreeBSD?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontnewroundbox -->
			<!-- 25th anniversary logo -->
			<div class="frontfeaturecontent">
			  <!-- XXX: target page not yet ready
			  <a href="XXX TBD"
			    title="&os; 25th Anniversary">
			  -->
			  <img
			    src="&enbase;/layout/images/25thanniversary.png"
			    style="margin-top: 5px;"
			    width="167" height="88"
			    alt="25th Anniversary Logo" />
			  <!--
			  </a>
			  -->
			</div>
			<!-- end 25th anniversary logo -->
		</div> <!-- FEATURERIGHT -->

            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="frontnemscontainer">
            	<div id="frontnews">
            	   <div id="frontnewscontent" class="txtnewsevent">
			<h2>最新动态</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/news/newsflash.html" title="更多新闻">更多新闻</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/news/rss.xml" title="新闻 RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="新闻 RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontevents">
		   <div id="fronteventscontent" class="txtnewsevent">

			<h2>近期活动</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&enbase;/events/" title="更多活动">更多活动</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="frontmedia">
		   <div id="frontmediacontent" class="txtnewsevent">

			<h2>媒体报道</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&enbase;/news/press.html" title="更多媒体报道">更多媒体报道</a>
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
					<a href="&enbase;/security/advisories.html" title="更多安全公告">更多安全公告</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/security/rss.xml" title="安全公告 RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="安全公告 RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>勘误公告</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
				    <a href="&enbase;/security/notices.html" title="更多勘误公告">更多勘误公告</a>
				  </li>
				  <li class="last-child">
				    <a href="&enbase;/security/errata.xml" title="勘误公告 RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="勘误公告 RSS Feed" /></a>
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

	FreeBSD 标志是 FreeBSD 基金会的注册商标
	由 <a
	  href="https://www.freebsdfoundation.org/documents/Guidelines.shtml">FreeBSD 基金会</a> 授权 FreeBSD 项目使用。
	<a href="&enbase;/mailto.html" title="&header2.word.contact;">&header2.word.contact;</a>
  </xsl:template>
</xsl:stylesheet>
