<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Die FreeBSD-Gemeinde">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!-- $FreeBSD$ -->
<!-- $FreeBSDde$ -->
<!-- basiert auf: r53526 -->

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

  <xsl:template name="process.sidewrap">
    &nav.community;
  </xsl:template>

  <xsl:template name="process.contentwrap">

	      <p>Es gibt mehr als 100 <a
		href="&base;/community/mailinglists.html">
		Mailinglisten</a>, dutzende <a
		href="https://forums.FreeBSD.org/">Foren</a> sowie
		diverse <a
		href="&enbase;/doc/de_DE.ISO8859-1/books/handbook/eresources-news.html">Newsgroups</a>.
		Dazu kommen mehr als 91 <!-- <xsl:value-of
		select="count(document($usergroups.xml)//entry)"
		/><xsl:text> </xsl:text>--> <a
		href="&enbase;/usergroups.html">User Groups</a> in
		40 Ländern. <!--<xsl:value-of
		select="count(document($usergroups.xml)//country)" />-->
		Zusätzlich existiert eine aktive <a
		href="&base;/community/irc.html">IRC</a>-Gemeinde.
		Außerdem betreiben die &os;-Entwickler gemeinsam mit
		einigen der wichtigsten Unterstützer ein <a
		href="https://wiki.FreeBSD.org/">Wiki</a>, das Informationen
		zur &os;-Entwicklung und zu diversen Projekten
		enthält.</p>

	      <p>Letztes Jahr gab es insgesamt 9 <!-- <xsl:value-of
	        select="count(/events/event[number(enddate/year) =
	        (number($curdate.year) -1)])" />-->
		&os;-Veranstaltungen in 9 <!--<xsl:value-of
		select="count(/events/event[(number(enddate/year) =
		(number($curdate.year) -1)) and (generate-id() =
		generate-id(key('last-year-event-by-country',
		location/country)[1]))])" />--> verschiedenen Ländern.
		Ein <a href="&enbase;/events/events.ics">Kalender</a> sowie
		ein <a href="&enbase;/events/rss.xml">RSS Feed</a> zu
		bevorstehenden FreeBSD-spezifischen Veranstaltungen sind
		auf der Seite <a
		href="&enbase;/events/events.html">Veranstaltungen</a>
		verfügbar.  Und nicht zuletzt gibt es dutzende
		Videos im Youtube-Channel <a
		href="https://www.youtube.com/bsdconferences">BSD
		Conferences</a>.</p>

<!-- The Latest Videos section is placed inside an invisible block, which
     is only made visible if the browser supports Javascript. -->

              <div id="latest-videos" style="display:none;">
	      <h3>Aktuelle Videos</h3>

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
	      <h2>Soziale Netzwerke</h2>

	      <p>&os; ist auf diversen sozialen Netzwerken vertreten.</p>

	      <ul>
		<li>Es gibt tausende Photos von Usergroup-Treffen,
		  Konferenzen und Hackatons, die auf <a
		  href="http://www.flickr.com">flickr</a> mit dem
		  Tag '<a
		  href="https://flickr.com/search/?z=t&amp;ss=2&amp;w=all&amp;q=freebsd&amp;m=text">freebsd</a>'
		  versehen wurden.</li>

		<li>Auf <a href="https://www.youtube.com">YouTube</a>
		  gibt es hunderte Videos von Konferenzen,
		  Präsentatitionen und Vorträgen, die sich auf <a
		  href="https://www.youtube.com/results?search_query=freebsd">&os;</a>
		  beziehen.  Weiters gibt es den Channel <a
		  href="https://www.youtube.com/bsdconferences">BSD Conferences</a>,
		  über den Sie komplette Präsentationen von
		  FreeBSD-Konferenzen verfolgen/ansehen können.</li>

		<li>Auf <a href="https://www.facebook.com">Facebook</a>
		  gibt es die <a
		  href="https://www.facebook.com/home.php#/group.php?gid=2204657214">FreeBSD
		  Users Group</a>, auf <a
		  href="https://www.linkedin.com">LinkedIn</a> die <a
		  href="https://www.linkedin.com/groups?gid=47628">FreeBSD Group</a>.</li>

		<li>Auf <a href="https://twitter.com">Twitter</a>
		  können Sie beispielsweise
		  <a href="https://twitter.com/freebsd">@freebsd</a>,
		  <a href="https://twitter.com/freebsdhelp">@freebsdhelp</a>,
		  <a href="https://twitter.com/freebsdblogs">@freebsdblogs</a>
		  oder 
		  <a href="https://twitter.com/freebsdcore">@freebsdcore</a>
		  folgen.</li>
	      </ul>
  </xsl:template>
</xsl:stylesheet>
