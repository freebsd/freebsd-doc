<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD 社群">
]>

<!-- $FreeBSD$ Original Revision: 2bc0aef911 (r52000) -->

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
	      <p>有超過一百個<a
		href="&enbase;/community/mailinglists.html">郵件論壇</a>、數十個網頁版<a
		  href="https://forums.FreeBSD.org/">論壇</a>和數個 <a
		href="&enbase;/doc/en_US.ISO8859-1/books/handbook/eresources-news.html">newsgroups</a> 。
		有超過 <xsl:value-of
		select="count(document($usergroups.xml)//entry)"
		/><xsl:text> </xsl:text>個<a
		href="&enbase;/usergroups.html">愛用者組織</a>分佈於全世界
		<xsl:value-of
		select="count(document($usergroups.xml)//country)" />
		個國家。也有一個活躍的 <a href="&base;/community/irc.html">IRC</a>
		社群。許多開發者也有建立關於他們 &os; 開發工作的 <a
		href="https://planet.freebsd.org">部落格</a>
	      	開發者和主要貢獻者亦共同維護一個關於 &os; 開發和相關計畫資訊的 <a
		  href="https://wiki.FreeBSD.org/">維基網站</a>。</p>

	      <p>去年有 <xsl:value-of
	        select="count(/events/event[number(enddate/year) =
		(number($curdate.year) -1)])" /> &os; 活動在全世界
		<xsl:value-of
		select="count(/events/event[(number(enddate/year) =
		(number($curdate.year) -1)) and (generate-id() =
		generate-id(key('last-year-event-by-country',
		location/country)[1]))])" /> 個不同國家舉辦
		。近期 &os; 相關活動的 <a
		href="&enbase;/events/events.ics">行事曆</a> 和
		<a href="&enbase;/events/rss.xml">RSS feed</a>
		可以查看 <a href="&enbase;/events/events.html">近期活動
		</a>頁面。有許多過往活動的影片
		在 Youtube 的 <a
		href="https://www.youtube.com/bsdconferences">BSD
		Conferences</a> 頻道。</p>

<!-- The Latest Videos section is placed inside an invisible block, which
     is only made visible if the browser supports Javascript. -->

              <div id="latest-videos" style="display:none;">
	      <h3>最新影片</h3>

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
	      <h2>社群網站</h2>
	      <p>&os; 亦出現於許多不同的社群網站。</p>

	      <ul>

		<li><a href="https://www.flickr.com">flickr</a> 有數千張愛用者組織、會議和黑客松的照片標記
		'<a
		href="https://flickr.com/search/?z=t&amp;ss=2&amp;w=all&amp;q=freebsd&amp;m=text">freebsd</a>'
		</li>

		<li><a href="https://www.youtube.com">YouTube</a> 有數百個
		<a
		href="https://www.youtube.com/results?search_query=freebsd&amp;search_type=&amp;aq=f">FreeBSD</a>
		相關的會議、螢幕錄影或是範影片。特別是有一個新的 <a href="https://www.youtube.com/bsdconferences">BSD Conferences</a> 頻道有超過一個小時 FreeBSD 會議的演講影片。</li>

		<li>有一個 <a
		    href="https://www.facebook.com/groups/FreeSBD/">FreeBSD
		Users Group</a> 在 <a
		href="https://www.facebook.com">Facebook</a> 和一個 <a href="https://www.linkedin.com/groups?gid=47628">FreeBSD Group</a> 在 <a href="https://www.linkedin.com">LinkedIn</a>。</li>

		<li>你可以在 <a href="https://twitter.com">Twitter</a> 追蹤
		<a href="https://twitter.com/freebsd">@freebsd</a>,
		<a href="https://twitter.com/freebsdhelp">@freebsdhelp</a>,
		<a href="https://twitter.com/freebsdblogs">@freebsdblogs</a>, 或是
		<a href="https://twitter.com/freebsdcore">@freebsdcore</a>
		。</li>
	      </ul>
  </xsl:template>
</xsl:stylesheet>
