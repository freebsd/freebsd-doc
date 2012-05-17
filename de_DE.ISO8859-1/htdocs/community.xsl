<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "Die FreeBSD-Gemeinde">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!-- $FreeBSD$ -->
<!-- $FreeBSDde: de-www/community.xsl,v 1.7 2011/08/01 09:27:32 jkois Exp $ -->
<!-- basiert auf: 1.9 -->

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

	      <p>&os; wird von einer aktiven Gemeinschaft
		unterst&uuml;tzt.</p>

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
		36 L&#228;ndern. <!--<xsl:value-of
		select="count(document($usergroups.xml)//country)" />-->
		Zus&#228;tzlich existiert eine aktive <a
		href="&base;/community/irc.html">IRC</a>-Gemeinde.
		Viele Entwickler betreiben auch <a
		href="http://planet.freebsdish.org">Blogs</a>, in denen
		sie &#252;ber ihre Arbeit an FreeBSD berichten.
		Au&#223;erdem betreiben die &os;-Entwickler gemeinsam mit
		einigen der wichtigsten Unterst&#252;tzer ein <a
		href="http://wiki.FreeBSD.org/">Wiki</a>, das Informationen
		zur &os;-Entwicklung und zu diversen Projekten
		enth&#228;lt.  Weiters ist &os; auch in verschiedenen <a
		href="&enbase;/community/social.html">Sozialen
		Netzwerken</a> vertreten.</p>

	      <p>Letztes Jahr gab es insgesamt 19 <!-- <xsl:value-of
	        select="count(event[number(enddate/year) =
	        (number($curdate.year) -1)])" />-->
		&os;-Veranstaltungen in 12 <!--<xsl:value-of
		select="count(event[(number(enddate/year) =
		(number($curdate.year) -1)) and (generate-id() =
		generate-id(key('last-year-event-by-country',
		location/country)[1]))])" />--> verschiedenen L&#228;ndern.
		Ein <a href="&enbase;/events/events.ics">Kalender</a> sowie
		ein <a href="&enbase;/events/rss.xml">RSS Feed</a> zu
		bevorstehenden FreeBSD-spezifischen Veranstaltungen sind
		auf der Seite <a
		href="&enbase;/events/events.html">Veranstaltungen</a>
		verf&#252;gbar.  Und nicht zuletzt gibt es dutzende
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
