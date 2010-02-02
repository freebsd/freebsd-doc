<?xml version="1.0" encoding="EUC-JP" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
	  "http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD のコミュニティ">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!-- $FreeBSD: www/ja/community.xsl,v 1.1 2010/01/29 16:48:47 ryusuke Exp $ -->
<!-- Original revision: 1.9 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:output method="xml" encoding="&xml.encoding;"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

  <xsl:key name="last-year-event-by-country" match="event[number(enddate/year) = (number($curdate.year) - 1)]"
    use="location/country" />

  <xsl:key name="event-by-year" match="event" use="enddate/year" />

  <xsl:template match="events">
    <html>
      &header1;
      <body>

	<div id="CONTAINERWRAP">
	  <div id="CONTAINER">
	    &header2;

	    <div id="CONTENT">
	      <div id="SIDEWRAP">
		&nav;
	      </div> <!-- SIDEWRAP -->

	      <div id="CONTENTWRAP">
		&header3;

		<p>&os; には、開発を支える活発なコミュニティがあります。</p>

		<p><a href="&base;/support.html#mailing-list"
		      >メーリングリスト</a> の数は 100 を超えており、
		  たくさんのウェブベースの
		  <a href="http://forums.FreeBSD.org/">フォーラム</a> や、
		  いくつもの <a href="&enbase;/community/newsgroups.html"
		     >ニュースグループ</a> があります。
		  世界
		  <xsl:value-of
		     select="count(document($usergroups.xml)//country)" />
		  ヵ国に
		  <xsl:value-of
		     select="count(document($usergroups.xml)//entry)"
		     /><xsl:text> </xsl:text> を越える
		  <a href="&base;/usergroups.html">ユーザグループ</a>
		  があり、
		  <a href="&enbase;/community/irc.html">IRC</a>
		  のコミュニティも活発です。
		  多くの開発者は、関連する &os; の情報を
		  <a href="http://planet.freebsdish.org">ブログ</a>
		  で紹介しています。
		  また、開発者や活発な貢献者は、
		  &os; の開発状況や関連プロジェクトの情報を
		  <a href="http://wiki.FreeBSD.org/">wiki</a>
		  にまとめています。
		  &os; についての情報は、さまざまな
		  <a href="&enbase;/community/social.html">ソーシャルネットワーク
		  </a> サイトにおいても提供されています。</p>

		<p>昨年は、世界
		  <xsl:value-of
		     select="count(event[(number(enddate/year) =
			     (number($curdate.year) -1)) and (generate-id() =
			     generate-id(key('last-year-event-by-country',
			     location/country)[1]))])" />
		  ヵ国で、&os; に関連した
		  <xsl:value-of
		     select="count(event[number(enddate/year) =
			     (number($curdate.year) -1)])" />
		  ものイベントが開催されました。
		  <a href="&base;/events/events.html">イベントページ</a> では、
		  今後開催される &os; 関連イベントの
		  <a href="&base;/events/events.ics">カレンダ</a> や
		  <a href="&base;/events/rss.xml">RSS feed</a>
		  を提供しています。
		  過去に開催されたイベントに関する数多くのビデオが、
		  YouTube の
		  <a href="http://www.youtube.com/bsdconferences">BSD
		    Conferences</a> チャネルで公開されています。</p>
		
<!-- The Latest Videos section is placed inside an invisible block, which
     is only made visible if the browser supports Javascript. -->

		<div id="latest-videos" style="display:none;">
		  <h3>最新ビデオ</h3>

<!-- See http://www.google.com/uds/solutions/wizards/videobar.html -->
		  <div id="videoBar-bar">
		    <span style="color:#676767;font-size:11px;margin:10px;padding:4px;">Loading...</span>
		  </div>

		  <script src="http://www.google.com/uds/api?file=uds.js&amp;v=1.0&amp;source=uds-vbw"
			  type="text/javascript"></script>
		  <style type="text/css">
		    @import url("http://www.google.com/uds/css/gsearch.css");
		  </style>
  <!-- Video Bar Code and Stylesheet -->
		  <script type="text/javascript">
		    window._uds_vbw_donotrepair = true;
		  </script>
		  <script src="http://www.google.com/uds/solutions/videobar/gsvideobar.js?mode=new"
			  type="text/javascript"></script>
		  <style type="text/css">
		    @import url("http://www.google.com/uds/solutions/videobar/gsvideobar.css");
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
	      </div> <!-- CONTENTWRAP -->
	      <br class="clearboth" />
	    </div> <!-- CONTENT -->

	    <div id="FOOTER">
	      &copyright;<br />
	      &date;
	    </div> <!-- FOOTER -->
	  </div> <!-- CONTAINER -->
	</div> <!-- CONTAINERWRAP -->

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
