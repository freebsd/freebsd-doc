<?xml version="1.0" encoding="EUC-JP" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>

<!-- $FreeBSD: www/ja/index.xsl,v 1.62 2011/08/15 09:46:56 ryusuke Exp $ -->
<!-- Original revision: 1.174 -->

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

  <xsl:output type="html" encoding="EUC-JP"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title>&title;</title>
	<meta name="description" content="The FreeBSD Project"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Ports,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
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
	<script type="text/javascript" src="&enbase;/layout/js/google.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Project News" href="&enbase;/news/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Security Advisories" href="&enbase;/security/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD GNOME Project News" href="&enbase;/gnome/rss.xml" />

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
			  ベースは BSD UNIX<!-- &unix; -->(R)
			</h1>

			<p>FreeBSD<!-- &reg; -->(R) は、最新のサーバ、デスクトップおよび組み込み
			  <a href="&base;/platforms/">プラットフォーム</a>
			  用の高性能なオペレーティングシステムです。
			  FreeBSD のコードベースは、
			  30 年以上にも渡って開発、改良、最適化が続けられています。
			  <a href="&enbase;/doc/ja_JP.eucJP/articles/contributors/staff-committers.html"
			    >多くの人々が参加する開発者チーム</a>
			  が開発・保守をおこなっています。
			  FreeBSD は高度なネットワーク、堅固なセキュリティ機能、
			  世界最大クラスのパフォーマンスを提供し、
			  世界最大規模の <a	
			  href = "&enbase;/doc/ja_JP.eucJP/books/handbook/nutshell.html#INTRODUCTION-NUTSHELL-USERS">ウェブサイト</a> や、
			  広く普及している組み込みネットワーク機器、
			  ストレージデバイスで利用されています。
			</p>

			<div id="TXTFRONTFEATURELINK">
			  &#187;<a href="&base;/about.html" title="詳しくはこちら">詳しくはこちら</a>
			</div> <!-- TXTFRONTFEATURELINK -->
		    </div> <!-- FRONTFEATURECONTENT -->
		  </div> <!-- FRONTFEATURELEFT -->

		  <div id="FRONTFEATUREMIDDLE">
		      <div class="frontgetroundbox">
			<div class="frontgettop"><div>&#160;</div>&#160;</div>

			<div class="frontgetcontent">
			  <a href="&base;/where.html">FreeBSD を入手する</a>
			</div> <!-- frontgetcontent -->

			<div class="frontgetbot"><div>&#160;</div>&#160;</div>
		      </div> <!-- frontgetroundbox -->

			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
			  <h2><a href="&base;/releases/">最新リリース</a></h2>
			  <ul id="FRONTRELEASESLIST">
			    <li>
			      <a href="&u.rel.announce;">プロダクション: &rel.current;</a>
			    </li>

			    <li>
			      <a href="&u.rel2.announce;">レガシー: &rel2.current;</a>
			    </li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
			    <li>
			      <a href="&base;/where.html#helptest">次回予定:
				&betarel.current;-&betarel.vers;</a>
			    </li>
			    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
			    <li>
			      <a href="&base;/where.html#helptest">次回予定:
				&betarel2.current;-&betarel2.vers;</a>
			    </li>
			    </xsl:if>
			  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		  </div> <!-- FRONTFEATUREMIDDLE -->

		<div id="FRONTFEATURERIGHT">
		      <h2 class="blockhide">他言語へのリンク</h2>

		      <div id="LANGUAGENAV">
			<ul id="LANGUAGENAVLIST">
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

		      <div id="MIRROR">
			<form action="&cgibase;/mirror.cgi" method="get">
			  <div>
			    <h2 class="blockhide"><label for="MIRRORSEL">ミラーサイト</label></h2>
			    <select id="MIRRORSEL" name="goto">
			      <xsl:call-template name="html-index-mirrors-options-list">
				<xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
			      </xsl:call-template>
			    </select>
			  </div> <!-- unnamed -->
			  <input type="submit" value="移動" />
			</form>
		      </div> <!-- MIRROR -->

		      <div id="FRONTSHORTCUTS">
			<div id="FRONTSHORTCUTSCONTENT" class="txtshortcuts">
			  <h2>ショートカット</h2>
			  <ul id="FRONTSHORTCUTSLIST">
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
			  <a href="&base;/projects/newbies.html">FreeBSD が初めてという方は、こちらへどうぞ</a>
			</div> <!-- frontnewcontent -->
			<div class="frontnewbot"><div>&#160;</div>&#160;</div>
		      </div> <!-- frontnewroundbox -->
		    </div> <!-- FEATURERIGHT -->

		  </div> <!-- FRONTFEATURECONTAINER -->

		  <br class="clearboth" />

		  <div id="FRONTNEMSCONTAINER">
		    <div id="FRONTNEWS">
		      <div id="FRONTNEWSCONTENT" class="txtnewsevent">
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

		    <div id="FRONTEVENTS">
		      <div id="FRONTEVENTSCONTENT" class="txtnewsevent">
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

		    <div id="FRONTMEDIA">
		      <div id="FRONTMEDIACONTENT" class="txtnewsevent">
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

		    <div id="FRONTSECURITY">
		      <div id="FRONTSECURITYCONTENT" class="txtnewsevent">
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
	    </div> <!-- CONTENT -->

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
