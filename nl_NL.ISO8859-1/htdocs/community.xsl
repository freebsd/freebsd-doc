<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "&os; Gemeenschap">
]>
<!-- $FreeBSD$
     Vertaald door: Rene Ladan
     %SOURCE%	en_US.ISO8859-1/htdocs/community.xsl
     %SRCID%	40558
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
	      <p>&os; wordt goed ondersteund door haar actieve gemeenschap.</p>

	      <p>Er zijn meer dan honderd <a
		href="&enbase;/community/mailinglists.html">mailinglijsten</a>,
		tientallen webgebaseerde <a
		  href="http://forums.FreeBSD.org/">fora</a>, en
		verschillende <a
		href="&enbase;/community/newsgroups.html">niewsgroepen</a>
		beschikbaar.  Er zijn meer dan <xsl:value-of
		select="count(document($usergroups.xml)//entry)"
		/><xsl:text> </xsl:text><a
		href="&base;/usergroups.html">gebruikersgroepen</a> in
		<xsl:value-of
		select="count(document($usergroups.xml)//country)" />
		unieke landen wereldwijd.  Er is ook een
		actieve <a href="&enbase;/community/irc.html">IRC</a>
		gemeenschap.  Veel ontwikkelaars houden ook <a
		href="http://planet.freebsdish.org">blogs</a> bij over
		hun &os;-werk.  Ontwikkelaars en belangrijke vrijwilligers
		houden ook een <a
		  href="http://wiki.FreeBSD.org/">wiki</a> bij, welke
		informatie over &os;-ontwikkeling en gerelateerde projecten
		bevat.  U vindt &os; ook vertegenwoordigd op verschillende <a
		href="&enbase;/community/social.html">sociale
		netwerksites</a>.</p>

	      <p>Vorig jaar waren er <xsl:value-of
		select="count(/events/event[number(enddate/year) =
		(number($curdate.year) -1)])" /> &os;-evenementen in
		<xsl:value-of
		select="count(/events/event[(number(enddate/year) =
		(number($curdate.year) -1)) and (generate-id() =
		generate-id(key('last-year-event-by-country',
		location/country)[1]))])" /> verschillende landen. Een <a
		href="&enbase;/events/events.ics">kalender</a> en
		<a href="&enbase;/events/rss.xml">RSS feed</a> van aanstaande
		&os;-gerelateerde evenementen worden bijgehouden op onze
		<a href="&enbase;/events/events.html">evenementenpagina</a>.
		Er zijn ook tientallen video's van voorgaande evenementen
		op het kanaal <a
		href="http://www.youtube.com/bsdconferences">BSD
		Conferences</a> op YouTube.</p>

<!-- The Latest Videos section is placed inside an invisible block, which
     is only made visible if the browser supports Javascript. -->

	      <div id="latest-videos" style="display:none;">
	      <h3>Nieuwste Video's</h3>

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
