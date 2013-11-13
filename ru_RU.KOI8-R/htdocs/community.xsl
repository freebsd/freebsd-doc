<?xml version="1.0" encoding="koi8-r" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Сообщество FreeBSD">
]>

<!--
 The FreeBSD Russian Documentation Project

   $FreeBSD$

   Original revision: 1.9
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns="http://www.w3.org/1999/xhtml"
  extension-element-prefixes="date">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:key name="last-year-event-by-country" match="event[number(enddate/year) = (number(date:year()) - 1)]"
    use="location/country" />

  <xsl:key name="event-by-year" match="event" use="enddate/year" />

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.sidewrap">
    &nav.community;
  </xsl:template>

  <xsl:template name="process.contentwrap">
	      <p>&os; достаточно хорошо поддерживается своим активным
		сообществом.</p>

	      <p>Существует больше сотни  <a
		href="&base;/community/mailinglists.html">списков
		рассылки</a>, десятки web <a
		  href="http://forums.FreeBSD.org/">форумов</a> и
		несколько <a
		href="&base;/community/newsgroups.html">телеконференций</a>.
		Более <xsl:value-of
		select="count(document($usergroups.xml)//entry)"
		/><xsl:text> </xsl:text><a
		href="&base;/usergroups.html">групп пользователей</a> в
		<xsl:value-of
		select="count(document($usergroups.xml)//country)" />
		странах по всему миру.  Также есть активное
		<a href="&base;/community/irc.html">IRC</a> сообщество.
		Многие разработчики также ведут <a
		href="http://planet.freebsdish.org">блоги</a> о
		своей работе над &os;.  Также разработчики и ключевые
		контрибьюторы используют <a
		  href="http://wiki.FreeBSD.org/">wiki</a>, в которой
		содержится информация о разработке &os; и имеющих к ней
		отношение проектов.  Вы можете найти &os;, представленную
		в целом ряде различных <a
		href="&base;/community/social.html">социальных
		сетей</a>.</p>

		<p>В прошлом году было проведено <xsl:value-of
	        select="count(/events/event[number(enddate/year) =
		(number($curdate.year) -1)])" /> событий,
		посвященных &os;, в <xsl:value-of
		select="count(/events/event[(number(enddate/year) =
		(number($curdate.year) -1)) and (generate-id() =
		generate-id(key('last-year-event-by-country',
		location/country)[1]))])" /> различных странах
		по всему миру.  <a
		href="&base;/events/events.ics">Календарь</a> и
		<a href="&base;/events/rss.xml">лента RSS</a>
		предстоящих событий, имеющих отношение к &os;, доступны
		на нашей <a href="&base;/events/events.html">странице
		событий</a>.  В YouTube выложены десятки видео с
		прошлых событий на канале <a
		href="http://www.youtube.com/bsdconferences">BSD
		Conferences</a>.</p>

<!-- The Latest Videos section is placed inside an invisible block, which
     is only made visible if the browser supports Javascript. -->

              <div id="latest-videos" style="display:none;">
	      <h3>Последние видео</h3>

<!-- See http://www.google.com/uds/solutions/wizards/videobar.html -->
  <div id="videoBar-bar">
    <span style="color:#676767;font-size:11px;margin:10px;padding:4px;">Загружается...</span>
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
  </xsl:template>
</xsl:stylesheet>
