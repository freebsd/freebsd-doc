<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Community">
]>

<!-- $FreeBSD$ -->

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
	      <p>There are more than one hundred <a
		href="&base;/community/mailinglists.html">mailing
		lists</a>, dozens of web-based <a
		  href="http://forums.FreeBSD.org/">forums</a>, and
		several <a
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
	        select="count(/events/event[number(enddate/year) =
	        (number($curdate.year) -1)])" /> &os; events in
		<xsl:value-of
		select="count(/events/event[(number(enddate/year) =
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
	      <h2>Social Networking</h2>
	      <p>&os; is represented on a number of different social
	        networks.</p>

	      <ul>

	        <li>Thousands of users have tagged nearly 30,000
	        unique web pages with the '<a
	        href="http://del.icio.us/tag/freebsd">freebsd</a>' tag
	        on <a href="http://del.icio.us">del.icio.us</a>.</li>

		<li>There are thousands of photos from user group
		meetings, conferences, and hackathons tagged as '<a
		href="http://flickr.com/search/?z=t&amp;ss=2&amp;w=all&amp;q=freebsd&amp;m=text">freebsd</a>'
		on <a href="http://www.flickr.com">flickr</a>.</li>

		<li>There are hundreds of videos from conferences,
		screencasts, and demonstrations relating to <a
		href="http://www.youtube.com/results?search_query=freebsd&amp;search_type=&amp;aq=f">FreeBSD</a>
		on <a href="http://www.youtube.com">YouTube</a>.  In particular, there is a new <a href="http://www.youtube.com/bsdconferences">BSD Conferences</a> channel with full length 1 hour taped presentations from FreeBSD technical conferences.</li>

		<li>There is a <a
		href="http://www.facebook.com/home.php#/group.php?gid=2204657214">FreeBSD
		Users Group</a> on <a
		href="http://www.facebook.com">Facebook</a> and a <a href="http://www.linkedin.com/groups?gid=47628">FreeBSD Group</a> on <a href="http://www.linkedin.com">LinkedIn</a>.</li>

		<li>You can follow
		<a href="http://twitter.com/freebsdblogs">@freebsdblogs</a>,
		<a href="http://twitter.com/freebsd">@freebsd</a>, or
		<a href="http://twitter.com/bsdevents">@bsdevents</a>
		on <a href="http://twitter.com">Twitter</a>.</li>
	      </ul>
  </xsl:template>
</xsl:stylesheet>
