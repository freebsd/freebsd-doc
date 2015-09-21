<?xml version="1.0" encoding="euc-jp" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>

<!-- $FreeBSD$ -->
<!-- Original revision: r47418 -->

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
			<h1>&os; プロジェクト</h1>

			<p>&os; は、最新のサーバ、デスクトップおよび組み込み
			  <a href="&base;/platforms/">プラットフォーム</a>
			  用の高性能なオペレーティングシステムです。
			  多くの <a href="&enbase;/doc/ja_JP.eucJP/articles/contributors/staff-committers.html">コミュニティ</a>
			  が 30 年以上にも渡って開発を続けています。
			  高度なネットワーク、セキュリティ、
			  およびストレージ機能により、
			  &os; は数多くの <a
			  href = "&enbase;/doc/ja_JP.eucJP/books/handbook/nutshell.html#introduction-nutshell-users">最大規模のウェブサイト</a>、
			  広く普及している組み込みネットワーク機器、
			  ストレージデバイスにおいて利用されています。</p>

			<div id="txtfrontfeaturelink">
			  &#187;<a href="&base;/about.html" title="詳しくはこちら">詳しくはこちら</a>
			</div> <!-- TXTFRONTFEATURELINK -->

			<div id="txtfrontjournalblock">
			  <br/>&#187;
			  <span
			    id="txtfrontjournallink">
			    <a
			      href="http://www.freebsdjournal.com/"
			        title="&os;&nbsp;Journal">&os;&nbsp;Journal</a>
			    を入手
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
			<div class="frontgettop"><div>&#160;</div>&#160;</div>

			<div class="frontgetcontent">
			  <a href="&base;/where.html">&os; を入手する</a>
			</div> <!-- frontgetcontent -->

			<div class="frontgetbot"><div>&#160;</div>&#160;</div>
		      </div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
			  <h2><a href="&base;/releases/">最新リリース</a></h2>
			  <ul id="frontreleaseslist">
			    <li>プロダクション:&nbsp;<a
				href="&u.rel.announce;">&rel.current;</a>,
					<a
				href="&u.rel2.announce;">&rel2.current;</a>,
					<a
				href="&u.rel3.announce;">&rel3.current;</a></li>
			    <xsl:if test="'&beta.upcoming;' != 'IGNORE'">
			    <li>次回予定: <a
				href="&u.betarel.schedule;">&betarel.current;</a></li>
			    </xsl:if>
			    <xsl:if test="'&beta2.upcoming;' != 'IGNORE'">
			    <li>次回予定: <a
				href="&u.betarel2.schedule;">&betarel2.current;</a></li>
			    </xsl:if>
					<li><a href="&base;/security/security.html#sup">サポートライフサイクル</a></li>
			  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		  </div> <!-- FRONTFEATUREMIDDLE -->

		<div id="frontfeatureright">
		      <h2 class="blockhide">他言語へのリンク</h2>

		      <div id="languagenav">
			<ul id="languagenavlist">
			  <li>
			    <a href="&enbase;/de/" title="ドイツ語">de</a>
			  </li>
			  <li>
			    <a href="&enbase;/" title="英語">en</a>
			  </li>
			  <li>
			    <a href="&enbase;/es/" title="スペイン語">es</a>
			  </li>
			  <li>
			    <a href="&enbase;/fr/" title="フランス語">fr</a>
			  </li>
			  <li>
			    <a href="&enbase;/hu/" title="ハンガリー語">hu</a>
			  </li>
			  <li>
			    <a href="&enbase;/it/" title="イタリア語">it</a>
			  </li>
			  <li>
			    <a href="&enbase;/ja/" title="日本語">ja</a>
			  </li>
			  <li>
			    <a href="&enbase;/nl/" title="オランダ語">nl</a>
			  </li>
			  <li>
			    <a href="&enbase;/ru/" title="ロシア語">ru</a>
			  </li>
			  <li class="last-child">
			    <a href="&enbase;/zh_CN/" title="中国語 (簡体字)">zh_CN</a>
			  </li>
			</ul>
		      </div> <!-- LANGUAGENAV -->

		      <div id="mirror">
			<form action="&cgibase;/mirror.cgi" method="get">
			  <div>
			    <h2 class="blockhide"><label for="MIRRORSEL">ミラーサイト</label></h2>
			    <select id="mirrorsel" name="goto">
			      <xsl:call-template name="html-index-mirrors-options-list">
				<xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
			      </xsl:call-template>
			    </select>
			  </div> <!-- unnamed -->
			  <input type="submit" value="移動" />
			</form>
		      </div> <!-- MIRROR -->

		      <div id="frontshortcuts">
			<div id="frontshortcutscontent" class="txtshortcuts">
			  <h2>ショートカット</h2>
			  <ul id="frontshortcutslist">
			    <li>
			      <a href="&base;/community/mailinglists.html" title="メーリングリスト">メーリングリスト</a>
			    </li>
			    <li>
			      <a href="&base;/support/bugreports.html" title="バグの報告">バグの報告</a>
			    </li>
			    <li>
			      <a href="&enbase;/doc/&url.doc.langcode;/books/faq/index.html" title="FAQ">FAQ</a>
			    </li>
			    <li>
			      <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/index.html" title="ハンドブック">ハンドブック</a>
			    </li>
			    <li>
			      <a href="&base;/ports/index.html" title="Ports">Ports</a>
			    </li>
			  </ul>
			</div> <!-- FRONTSHORTCUTSCONTENT -->
		      </div> <!-- FRONTSHORTCUTS -->

		      <div class="frontnewroundbox">
			<div class="frontnewtop"><div>&#160;</div>&#160;</div>
			<div class="frontnewcontent">
			  <a href="&base;/projects/newbies.html">FreeBSD が初めての方</a>
			</div> <!-- frontnewcontent -->
			<div class="frontnewbot"><div>&#160;</div>&#160;</div>
		      </div> <!-- frontnewroundbox -->
		    </div> <!-- FEATURERIGHT -->

		  </div> <!-- FRONTFEATURECONTAINER -->

		  <br class="clearboth" />

		  <div id="frontnemscontainer">
		    <div id="frontnews">
		      <div id="frontnewscontent" class="txtnewsevent">
			<h2>最新ニュース</h2>
			<div class="newseventswrap">
			  <xsl:call-template name="html-index-news-project-items">
			    <xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
			    <xsl:with-param name="news.project.xml" select="$news.project.xml" />
			  </xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="first-child">
				<a href="&base;/news/newsflash.html" title="すべてのニュース">すべてのニュース</a>
			      </li>
			      <li class="last-child">
				<a href="&base;/news/rss.xml" title="ニュースの RSS フィード"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		      </div> <!-- FRONTNEWSCONTENT -->
		    </div> <!-- FRONTNEWS -->

		    <div class="frontseparator"><b style="display: none">.</b></div>

		    <div id="frontevents">
		      <div id="fronteventscontent" class="txtnewsevent">
			<h2>イベント予定</h2>

			<div class="newseventswrap">
			  <xsl:call-template name="html-index-events-items">
			    <xsl:with-param name="events.xml-master" select="$events.xml-master" />
			    <xsl:with-param name="events.xml" select="$events.xml" />
			  </xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="only-child">
				<a href="&base;/events/" title="すべてのイベント">すべてのイベント</a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		      </div> <!-- FRONTEVENTSCONTENT -->
		    </div> <!-- FRONTEVENTS -->

		    <div class="frontseparator"><b style="display: none">.</b></div>

		    <div id="frontmedia">
		      <div id="frontmediacontent" class="txtnewsevent">
			<h2>ニュース記事</h2>

			<div class="newseventswrap">
			  <xsl:call-template name="html-index-news-press-items">
			    <xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
			    <xsl:with-param name="news.press.xml" select="$news.press.xml" />
			  </xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="only-child">
				<a href="&base;/news/press.html" title="すべてのニュース記事">すべてのニュース記事</a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		      </div> <!-- FRONTMEDIACONTENT -->
		    </div> <!-- FRONTMEDIA -->

		    <div class="frontseparator"><b style="display: none">.</b></div>

		    <div id="frontsecurity">
		      <div id="frontsecuritycontent" class="txtnewsevent">
			<h2>セキュリティ勧告</h2>

			<div class="newseventswrap">
			  <xsl:call-template name="html-index-advisories-items">
			    <xsl:with-param name="advisories.xml" select="$advisories.xml" />
			    <xsl:with-param name="type" select="'advisory'" />
			  </xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="first-child">
				<a href="&enbase;/security/advisories.html" title="すべてのセキュリティ勧告">すべて表示</a>
			      </li>
			      <li class="last-child">
				<a href="&enbase;/security/rss.xml" title="セキュリティ勧告の RSS フィード"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Security Advisories RSS Feed" /></a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />

			<h2>Errata 情報</h2>

			<div class="newseventswrap">
			  <xsl:call-template name="html-index-advisories-items">
			    <xsl:with-param name="advisories.xml" select="$notices.xml" />
			    <xsl:with-param name="type" select="'notice'" />
			  </xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="first-child">
				<a href="&enbase;/security/notices.html" title="すべての Errata 情報">すべて表示</a>
			      </li>
			      <li class="last-child">
				<a href="&enbase;/security/errata.xml" title="Errata 情報の RSS フィード"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Errata Notices RSS Feed" /></a>
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

	The mark FreeBSD is a registered trademark of The FreeBSD
	Foundation and is used by The FreeBSD Project with the
	permission of <a
	  href="https://www.freebsdfoundation.org/documents/Guidelines.shtml">The
	FreeBSD Foundation</a>.
	<a href="&base;/mailto.html" title="&header2.word.contact;">&header2.word.contact;</a>
  </xsl:template>
</xsl:stylesheet>
