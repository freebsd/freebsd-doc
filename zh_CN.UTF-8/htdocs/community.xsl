<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD 社区">
]>

<!-- $FreeBSD$ -->
<!-- The FreeBSD Simplified Chinese Documentation Project -->
<!-- Original Revision: 2bc0aef911 (r52000) -->

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
	      <p>有超过一百个 <a href="&enbase;/community/mailinglists.html">邮件列表</a>，
		许多网页 <a href="https://forums.FreeBSD.org/">论坛</a>，
		以及几个 <a
    href="&enbase;/doc/en_US.ISO8859-1/books/handbook/eresources-news.html">新闻组</a>
		可供您查看。 在世界上 <xsl:value-of
		select="count(document($usergroups.xml)//country)" />
		个不同的国家有超过 <xsl:value-of
		select="count(document($usergroups.xml)//entry)"/><xsl:text>
		</xsl:text> 个 <a href="&enbase;/usergroups.html">用户群组</a>，
		和一个活跃的 <a href="&enbase;/community/irc.html">IRC</a> 社区。
		很多开发者维护了各种 <a href="https://planet.freebsd.org">博客</a>
		来展示他们为 &os; 所做的工作。 开发者和关键的贡献者也维护了一个 <a
		href="https://wiki.FreeBSD.org/">wiki</a>， 其中包括了 &os;
		开发进度和相关项目的信息。</p>

	      <p>过去的一年， 在世界上 <xsl:value-of
		select="count(/events/event[(number(enddate/year) =
		(number($curdate.year) -1)) and (generate-id() =
		generate-id(key('last-year-event-by-country',
		location/country)[1]))])" /> 个不同的国家举办了 <xsl:value-of
	        select="count(/events/event[number(enddate/year) =
	        (number($curdate.year) -1)])" /> 场 &os; 活动。
		若要了解未来与 &os; 有关的活动， 请查阅
		<a href="&enbase;/events/events.html">活动页面</a> 上维护的
		<a href="&enbase;/events/events.ics">日历</a> 和
		<a href="&enbase;/events/rss.xml">RSS 源</a>。 在 YouTube 上的
		<a href="https://www.youtube.com/bsdconferences">BSD 会议</a>
		频道里有许多过去活动的视频。</p>

<!-- The Latest Videos section is placed inside an invisible block, which
     is only made visible if the browser supports Javascript. -->

              <div id="latest-videos" style="display:none;">
	      <h3>最新视频</h3>

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
	      <h2>社交网络</h2>
	      <p>&os; 出现在许多不同的社交网络上。</p>

	      <ul>

		<li>在 <a href="https://www.flickr.com">flickr</a> 上，
		有上千张来自用户群组， 会议和黑客马拉松的照片被加上了 '<a
		href="https://flickr.com/search/?z=t&amp;ss=2&amp;w=all&amp;q=freebsd&amp;m=text">freebsd</a>'
		标签。</li>

		<li>在 <a href="https://www.youtube.com">YouTube</a> 上有上百段会议视频，
		屏幕录像， 以及关于 <a
		href="https://www.youtube.com/results?search_query=freebsd">FreeBSD</a>
		的演示。 特别要提到的是， 有一个新的
		<a href="https://www.youtube.com/bsdconferences">BSD 会议</a>
		频道， 其中包含了来自 FreeBSD 技术会议的各种一小时 FreeBSD 录制演讲。</li>

		<li>在 <a href="https://www.facebook.com">Facebook</a> 上有一个
		<a href="https://www.facebook.com/groups/FreeSBD/">FreeBSD
		用户群组</a>， 在<a href="https://www.linkedin.com">LinkedIn</a> 上有一个
		<a href="https://www.linkedin.com/groups?gid=47628">FreeBSD 群组</a>。</li>

		<li>您可以在 <a href="https://twitter.com">Twitter</a> 上关注
		<a href="https://twitter.com/freebsd">@freebsd</a>，
		<a href="https://twitter.com/freebsdhelp">@freebsdhelp</a>，
		<a href="https://twitter.com/freebsdblogs">@freebsdblogs</a>， 以及
		<a href="https://twitter.com/freebsdcore">@freebsdcore</a>。</li>
	      </ul>
  </xsl:template>
</xsl:stylesheet>
