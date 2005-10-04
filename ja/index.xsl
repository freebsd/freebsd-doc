<?xml version="1.0" encoding="EUC-JP" ?>

<!-- $FreeBSD: www/ja/index.xsl,v 1.42 2005/10/04 16:21:45 hrs Exp $ -->
<!-- Original revision: 1.100 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="enbase" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/ja/index.xsl,v 1.42 2005/10/04 16:21:45 hrs Exp $'"/>
  <xsl:variable name="title" select="'The FreeBSD Project'"/>

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

  <xsl:output type="html" encoding="EUC-JP"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="$title"/></title>
	<meta name="description" content="The FreeBSD Project"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Gallery,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="{$enbase}/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="{$enbase}/favicon.ico" type="image/x-icon"/>
	<link rel="stylesheet" media="screen" href="{$enbase}/layout/css/fixed.css" type="text/css" title="Normal Text" />
	<link rel="alternate stylesheet" media="screen" href="{$enbase}/layout/css/fixed_large.css" type="text/css" title="Large Text" />
	<script type="text/javascript" src="{$enbase}/layout/js/styleswitcher.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Project News" href="{$enbase}/news/news.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Security Advisories" href="{$enbase}/security/advisories.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD GNOME Project News" href="{$enbase}/gnome/news.rdf" />

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
			<h1>ベースは BSD UNIX&#174;</h1>

			<p>FreeBSD は x86 互換機 (Pentium&#174; や Athlon &#8482; など),
			  amd64 互換機 (Opteron &#8482;, Athlon 64, EM64T など),
			  Alpha/AXP, IA-64, PC-98, UltraSPARC&#174;
			  の各アーキテクチャに対応した高性能なオペレーティングシステムです。
			  FreeBSD は BSD と呼ばれる、カリフォルニア大学バークレー校で開発された
			  UNIX&#174; に由来しており、
			  <a href="{$base}/doc/ja_JP.eucJP/articles/contributors/index.html"
			    >多くの人々が参加する開発者チーム</a>によって開発・保守がおこなわれています。
			  また、未対応の<a href="{$base}/platforms/">プラットフォーム</a
			    >の開発作業も進行中です。</p>

			<div id="txtfrontfeaturelink">
			  &#187;<a href="{$base}/about.html" title="Learn More">詳しくはこちら</a>
			</div> <!-- txtfrontfeaturelink -->
		      </div> <!-- frontfeaturecontent -->
		    </div> <!-- frontfeatureleft -->

		    <div id="frontfeaturemiddle">
		      <div class="frontgetroundbox">
			<div class="frontgettop">
			  <div>
			    &#160;
			  </div>
			  &#160;</div>

			<div class="frontgetcontent">
			  <a href="{$base}/where.html">FreeBSD を入手する</a>
			</div> <!-- frontgetcontent -->

			<div class="frontgetbot">
			  <div>
			    &#160;
			  </div>
			  &#160;</div>
		      </div> <!-- frontgetroundbox -->

		      <div id="frontreleases">
			<div id="frontreleasescontent" class="txtshortcuts">
			  <h2>最新リリース</h2>

			  <ul id="frontreleaseslist">
			    <li>
			      <a href="{$u.rel.announce}">プロダクションリリース <xsl:value-of select="$rel.current"/></a>
			    </li>

			    <li>
			      <a href="{$u.rel2.announce}">プロダクションリリース (旧版) <xsl:value-of select="$rel2.current"/></a>
			    </li>
			  </ul>
			</div> <!-- frontreleasescontent -->
		      </div> <!-- frontreleases -->
		    </div> <!-- frontfeaturemiddle -->

		    <div id="frontfeatureright">
		      <h2 class="blockhide">他言語へのリンク</h2>

		      <div id="languagenav">
			<ul id="languagenavlist">
			  <li>
			    <a href="{$enbase}/de/" title="German">de</a>
			  </li>
			  <li>
			    <a href="{$enbase}/" title="English">en</a>
			  </li>
			  <li>
			    <a href="{$enbase}/es/" title="Spanish">es</a>
			  </li>
			  <li>
			    <a href="{$enbase}/fr/" title="French">fr</a>
			  </li>
			  <li>
			    <a href="{$enbase}/it/" title="Italian">it</a>
			  </li>
			  <li>
			    <a href="{$enbase}/ja/" title="Japanese">ja</a>
			  </li>
			  <li class="last-child">
			    <a href="{$enbase}/ru/" title="Russian">ru</a>
			  </li>
			</ul>
		      </div> <!-- languagenav -->

		      <div id="mirror">
			<form action="{$enbase}/cgi/mirror.cgi" method="get">
			  <div>
			    <h2 class="blockhide"><label for="mirrorsel">ミラーサイト</label></h2>
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
			  <h2>ショートカット</h2>
			  <ul id="frontshortcutslist">
			    <li>
			      <a href="{$base}/support.html#mailing-list" title="Mailing Lists">メーリングリスト</a>
			    </li>
			    <li>
			      <a href="{$base}/platforms/" title="Platforms">プラットフォーム</a>
			    </li>
			    <li>
			      <a href="{$base}/send-pr.html" title="Report a Bug">バグの報告</a>
			    </li>
			    <li>
			      <a href="{$enbase}/doc/{$url.doc.langcode}/books/faq/index.html" title="FAQ">FAQ</a>
			    </li>
			    <li>
			      <a href="http://www.freebsdfoundation.org/" title="Foundation">FreeBSD 財団</a>
			    </li>
			  </ul>
			</div> <!-- frontshortcutscontent -->
		      </div> <!-- frontshortcuts -->

		      <div class="frontnewroundbox">
			<div class="frontnewtop"><div>&#160;</div>&#160;</div>
			<div class="frontnewcontent">
			  <a href="{$enbase}/projects/newbies.html">FreeBSD が初めてという方は、こちらへどうぞ</a>
			</div> <!-- frontnewcontent -->
			<div class="frontnewbot"><div>&#160;</div>&#160;</div>
		      </div> <!-- frontnewroundbox -->
		    </div> <!-- featureright -->

		  </div> <!-- frontfeaturecontainer -->

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
				<a href="{$base}/news/newsflash.html" title="More News">すべてのニュース</a>
			      </li>
			      <li class="last-child">
				<a href="{$enbase}/news/news.rdf" title="News RSS Feed"><img class="rssimage" src="{$enbase}/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		      </div> <!-- frontnewscontent -->
		    </div> <!-- frontnews -->

		    <div class="frontseparator"><b style="display: none">.</b></div>

		    <div id="frontevents">
		      <div id="fronteventscontent" class="txtnewsevent">
			<h2>イベント予定</h2>

			<div class="newseventswrap">
			  <xsl:call-template name="html-index-events-items">
			    <xsl:with-param name="events.xml-master" select="$events.xml-master" />
			    <xsl:with-param name="events.xml" select="$events.xml" />
			    <xsl:with-param name="curdate.xml" select="$curdate.xml" />
			  </xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="only-child">
				<a href="{$enbase}/events/" title="More Events">すべてのイベント</a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		      </div> <!-- frontnewsevents -->
		    </div> <!-- frontevents -->

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
				<a href="{$base}/news/press.html" title="More Media">すべてのニュース記事</a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		      </div> <!-- frontmediacontent -->
		    </div> <!-- frontmedia -->

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
				<a href="{$base}/security/" title="More Security Advisories">すべて表示</a>
			      </li>
			      <li>
				<a href="{$base}/send-pr.html" title="Submit a Problem Report">バグ報告の提出</a>
			      </li>
			      <li class="last-child">
				<a href="{$enbase}/security/advisories.rdf" title="Security Advisories RSS Feed"><img class="rssimage" src="{$enbase}/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
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
