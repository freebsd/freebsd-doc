<?xml version="1.0" encoding="euc-jp" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD のコミュニティ">
]>

<!-- $FreeBSD$ -->
<!-- Original revision: r53778 -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns="http://www.w3.org/1999/xhtml"
  extension-element-prefixes="date">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:key name="last-year-event-by-country" match="event[number(enddate/year) = (number(date:year()) - 1)]"
    use="location/country" />

  <xsl:key name="event-by-year" match="event" use="enddate/year" />

  <xsl:template name="process.sidewrap">
    &nav.community;
  </xsl:template>

  <xsl:template name="process.contentwrap">
		<p>&os; には、開発を支える活発なコミュニティがあります。</p>

		<p><a href="&base;/community/mailinglists.html"
		      >メーリングリスト</a> の数は 100 を超えており、
		  たくさんのウェブベースの
		  <a href="https://forums.FreeBSD.org/">フォーラム</a> や、
		  いくつもの <a
		    href="&enbase;/doc/ja_JP.eucJP/books/handbook/eresources-news.html">ニュースグループ</a>
		  があります。世界
		  <xsl:value-of
		     select="count(document($usergroups.xml)//country)" />
		  ヵ国に
		  <xsl:value-of
		     select="count(document($usergroups.xml)//entry)"
		     /><xsl:text> </xsl:text> を越える
		  <a href="&base;/usergroups.html">ユーザグループ</a>
		  があり、
		  <a href="&base;/community/irc.html">IRC</a>
		  のコミュニティも活発です。
		  また、開発者や活発な貢献者は、
		  &os; の開発状況や関連プロジェクトの情報を <a
		  href="https://wiki.FreeBSD.org/">wiki</a>
		  にまとめています。</p>

		<p>昨年は、世界
		  <xsl:value-of
		     select="count(/events/event[(number(enddate/year) =
			     (number($curdate.year) -1)) and (generate-id() =
			     generate-id(key('last-year-event-by-country',
			     location/country)[1]))])" />
		  ヵ国で、&os; に関連した
		  <xsl:value-of
		     select="count(/events/event[number(enddate/year) =
			     (number($curdate.year) -1)])" />
		  ものイベントが開催されました。
		  <a href="&base;/events/events.html">イベントページ</a> では、
		  今後開催される &os; 関連イベントの
		  <a href="&base;/events/events.ics">カレンダ</a> や
		  <a href="&base;/events/rss.xml">RSS feed</a>
		  を提供しています。
		  過去に開催されたイベントに関する数多くのビデオが、
		  YouTube の <a
		href="https://www.youtube.com/bsdconferences">BSD
		    Conferences</a> チャネルで公開されています。</p>

<!-- The Latest Videos section is placed inside an invisible block, which
     is only made visible if the browser supports Javascript. -->

		<div id="latest-videos" style="display:none;">
		  <h3>最新ビデオ</h3>

<!-- See http://www.google.com/uds/solutions/wizards/videobar.html -->
		  <div id="videoBar-bar">
		    <span style="color:#676767;font-size:11px;margin:10px;padding:4px;">Loading...</span>
		  </div>

		  <script src="//www.google.com/uds/api?file=uds.js&amp;v=1.0&amp;source=uds-vbw"
			  type="text/javascript"></script>
		  <style type="text/css">
		    @import url("//www.google.com/uds/css/gsearch.css");
		  </style>
  <!-- Video Bar Code and Stylesheet -->
		  <script type="text/javascript">
		    window._uds_vbw_donotrepair = true;
		  </script>
		  <script src="//www.google.com/uds/solutions/videobar/gsvideobar.js?mode=new"
			  type="text/javascript"></script>
		  <style type="text/css">
		    @import url("//www.google.com/uds/solutions/videobar/gsvideobar.css");
		  </style>

		  <style type="text/css">
		    .playerInnerBox_gsvb .player_gsvb {
		      width : 320px;
		      height : 260px;
		    }
		  </style>

		  <script type="text/javascript">
		    document.getElementById('latest-videos').style.display = 'block';

		    function LoadVideoBar() {

		      var videoBar;
		      var options = {
			largeResultSet : !true,
			horizontal : true,
			autoExecuteList : {
			  cycleTime : GSvideoBar.CYCLE_TIME_MEDIUM,
			  cycleMode : GSvideoBar.CYCLE_MODE_LINEAR,
			  executeList : ["ytchannel:bsdconferences"]
			}
		      }

		      videoBar = new GSvideoBar(document.getElementById("videoBar-bar"),
                      GSvideoBar.PLAYER_ROOT_FLOATING,
                      options);
		    }
    // arrange for this function to be called during body.onload
    // event processing
		    GSearch.setOnLoadCallback(LoadVideoBar);
		  </script>
		</div> <!-- Latest Videos -->
	      <h2>ソーシャルネットワーク</h2>
	      <p>&os; はさまざまなソーシャルネットワークで表現されています。</p>
	      <ul>
		<li><a href="http://www.flickr.com">flickr</a> では、
		ユーザグループミーティング、
		カンファレンスおよびハッカソンの数千もの写真に
		'<a
		href="https://flickr.com/search/?z=t&amp;ss=2&amp;w=all&amp;q=freebsd&amp;m=text">freebsd</a>'
		タグが付けられています。</li>

		<li><a href="https://www.youtube.com">YouTube</a> には、
		何千もの <a
		href="https://www.youtube.com/results?search_query=freebsd">&os;</a>
		に関連したカンファレンス、
		スクリーンキャストおよびデモンストレーションのビデオがあります。
		特に、新しい
		<a href="https://www.youtube.com/bsdconferences">BSD
		Conferences</a> チャネルでは、
		FreeBSD テクニカルカンファレンスの
		1 時間規模のプレゼンテーションを省略なく見ることができます。</li>

		<li><a href="https://www.facebook.com"
                    target="_blank"
                    rel="noopener">Facebook</a> には <a
                    href="https://www.facebook.com/groups/FreeSBD/"
		    target="_blank"
		    rel="noopener">FreeBSD Users Group</a> そして、
                  <a
                    href="https://www.linkedin.com"
                    target="_blank"
                    rel="noopener">LinkedIn</a> には
                  <a
                    href="https://www.linkedin.com/groups/47628/"
                    target="_blank"
                    rel="noopener">FreeBSD Group</a> があります。</li>

		<li><a href="https://twitter.com">Twitter</a> で
		<a href="https://twitter.com/freebsd">@freebsd</a>,
		<a href="https://twitter.com/freebsdhelp">@freebsdhelp</a> または
		<a href="https://twitter.com/freebsdcore">@freebsdcore</a>
		をフォローしてください。</li>
	      </ul>
  </xsl:template>
</xsl:stylesheet>
