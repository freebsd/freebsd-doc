<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Die FreeBSD-Gemeinde">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!-- $FreeBSD$ -->
<!-- $FreeBSDde$ -->
<!-- basiert auf: r40558 -->

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
	      <p>&os; wird von einer aktiven Gemeinschaft
		unterstützt.</p>

	      <p>Es gibt mehr als 100 <a
		href="&base;/community/mailinglists.html">
		Mailinglisten</a>, dutzende <a
		href="http://forums.FreeBSD.org/">Foren</a> sowie
		diverse <a
		href="&base;/community/newsgroups.html">Newsgroups</a>.
		Dazu kommen mehr als 86 <!-- <xsl:value-of
		select="count(document($usergroups.xml)//entry)"
		/><xsl:text> </xsl:text>--> <a
		href="&enbase;/usergroups.html">User Groups</a> in
		38 Ländern. <!--<xsl:value-of
		select="count(document($usergroups.xml)//country)" />-->
		Zusätzlich existiert eine aktive <a
		href="&base;/community/irc.html">IRC</a>-Gemeinde.
		Viele Entwickler betreiben auch <a
		href="http://planet.freebsdish.org">Blogs</a>, in denen
		sie über ihre Arbeit an FreeBSD berichten.
		Außerdem betreiben die &os;-Entwickler gemeinsam mit
		einigen der wichtigsten Unterstützer ein <a
		href="http://wiki.FreeBSD.org/">Wiki</a>, das Informationen
		zur &os;-Entwicklung und zu diversen Projekten
		enthält.  Weiters ist &os; auch in verschiedenen <a
		href="&enbase;/community/social.html">Sozialen
		Netzwerken</a> vertreten.</p>

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
		href="http://www.youtube.com/bsdconferences">BSD
		Conferences</a>.</p>

<!-- The Latest Videos section is placed inside an invisible block, which
     is only made visible if the browser supports Javascript. -->

              <div id="latest-videos" style="display:none;">
	      <h3>Aktuelle Videos</h3>

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
  </xsl:template>
</xsl:stylesheet>
