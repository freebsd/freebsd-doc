<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>

<!-- $FreeBSD$ -->
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
				<h1>&os; 計劃</h1>

				<p>&os; 是一個使用於現代伺服器，桌面與嵌入式 <a href="&base;/platforms/">平台</a> 的先進作業系統。
				  由一群龐大的 
				  <a
				  href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">社群</a>
				持續超過三十年的開發。
				由於它先進的網路、安全性與儲存方面的特色使得
				  &os; 成為許多
				  <a href="&enbase;/doc/zh_TW.UTF-8/books/handbook/nutshell.html#introduction-nutshell-users">大型網站</a>
			以及最普遍的嵌入式網路與儲存裝置的平台選擇。 </p>

                                  <div
				  id="txtfrontfeaturelink"> &#187;<a
				  href="&base;/about.html"
				  title="Learn More">參閱詳情</a>
				  </div> <!-- TXTFRONTFEATURELINK -->

				  <div id="txtfrontjournalblock">
				    <br/>&#187;
				    <span
				     id="txtfrontjournallink">立即取得 <a
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
				  <a href="&base;/where.html">下載 &os;</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
				  <h2><a href="&enbase;/releases/">最新版本</a></h2>
				  <ul id="frontreleaseslist">
					<li>Production:&nbsp;<a
				href="&u.rel122.announce;">&rel122.current;</a>,
					<a
				href="&u.rel121.announce;">&rel121.current;</a>,
				<a
				href="&u.rel114.announce;">&rel114.current;</a></li>
				
			    <xsl:if test="'&beta.upcoming;' != 'IGNORE'">
					<li>即將發佈: <a
				href="&u.betarel.schedule;">&betarel.current;</a></li>
			    </xsl:if>
			    <xsl:if test="'&beta2.upcoming;' != 'IGNORE'">
					<li>即將發佈: <a
				href="&u.betarel2.schedule;">&betarel2.current;</a></li>
			    </xsl:if>
					<li><a href="&enbase;/security/security.html#sup">支援生命週期</a></li>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="frontfeatureright">
			<h2 class="blockhide">語言連結</h2>
			<div id="languagenav">
				<ul id="languagenavlist">
				  <li>
					<a href="&enbase;/de/" title="德語">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="英語">en</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="日語">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/zh_CN/" title="中文 (簡體)">zh_CN</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_TW/" title="中文 (繁體)">zh_TW</a>
				  </li>
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="frontshortcuts">
			  <div id="frontshortcutscontent" class="txtshortcuts">
				  <h2>常用連結</h2>
				  <ul id="frontshortcutslist">
					<li>
					  <a href="&enbase;/community/mailinglists.html" title="郵件論壇">郵件論壇</a>
					</li>
					<li>
					  <a href="&enbase;/support/bugreports.html" title="問題回報">問題回報</a>
					</li>
					<li>
					  <a href="&enbase;/doc/zh_TW.UTF-8/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="&enbase;/doc/zh_TW.UTF-8/books/handbook/index.html" title="使用手冊">使用手冊</a>
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
			<h2>最新新聞</h2>
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
					<a href="&enbase;/news/rss.xml" title="新聞 RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="新聞 RSS Feed" /></a>
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
					<a href="&enbase;/news/press.html" title="更多媒體報導">更多媒體報導</a>
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
					<a href="&enbase;/security/advisories.html" title="更多安全公告">更多</a>
				  </li>
				  <li class="last-child">
					<a href="&base;/security/rss.xml" title="安全公告 RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="安全公告 RSS Feed" /></a>
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

			  <div>
			    	<ul class="newseventslist">
				  <li class="first-child">
				    <a href="&enbase;/security/notices.html" title="更多勘誤公告">更多</a>
				  </li>
				  <li class="last-child">
				    <a href="&enbase;/security/errata.xml" title="勘誤公告 RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="勘誤公告 RSS Feed" /></a>
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

	FreeBSD 標誌是 FreeBSD 基金會的註冊商標
	由 <a
	  href="https://www.freebsdfoundation.org/documents/Guidelines.shtml">FreeBSD 基金會</a> 授權 FreeBSD 計劃使用。
	<a href="&enbase;/mailto.html" title="&header2.word.contact;">&header2.word.contact;</a>
  </xsl:template>
</xsl:stylesheet>
