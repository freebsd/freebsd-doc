<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Community">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!-- $FreeBSD: www/en/community.xsl,v 1.6 2008/12/28 10:20:54 murray Exp $ -->

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

	      <p>&os; is well supported by its active
		community.</p>

	      <p>There are more than one hundred <a
		href="&base;/community/mailinglists.html">mailing
		lists</a> and several <a
		href="&base;/community/newsgroups.html">newsgroups</a>
		available.  There are over <xsl:value-of
		select="count(document($usergroups.xml)//entry)"
		/><xsl:text> </xsl:text><a
		href="&base;/usergroups.html">user groups</a> in
		<xsl:value-of
		select="count(document($usergroups.xml)//country)" />
		unique countries around the world.  There is also an
		active <a href="&base;/community/irc.html">IRC</a>
		community.  Many developers also maintain <a
		href="http://planet.freebsdish.org">blogs</a> about
	      	their &os; work.  Developers and key contributors
		also maintain a <a
		  href="http://wiki.FreeBSD.org/">wiki</a>, which
		contains information about &os; development
		and related projects.  You can also find &os; represented
		on a variety of different <a
		href="&base;/community/social.html">social
		networking</a> sites.</p>

	      <p>Last year there were <xsl:value-of
	        select="count(event[number(enddate/year) =
	        (number($curdate.year) -1)])" /> &os; events in
		<xsl:value-of
		select="count(event[(number(enddate/year) =
		(number($curdate.year) -1)) and (generate-id() =
		generate-id(key('last-year-event-by-country',
		location/country)[1]))])" /> different countries
		around the world.  A <a
		href="&base;/events/events.ics">calendar</a> and
		<a href="&base;/events/rss.xml">RSS feed</a> of
		upcoming &os;-related events are maintained on our
		<a href="&base;/events/events.html">events
		page</a>.  There are dozens of videos from past events
		on the <a
		href="http://www.youtube.com/bsdconferences">BSD
		Conferences</a> channel on YouTube.</p>

<!-- The Latest Videos section is placed inside an invisible block, which
     is only made visible if the browser supports Javascript. -->

              <div id="latest-videos" style="display:none;">
	      <h3>Latest Videos</h3>

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
