<?xml version="1.0" encoding="iso-8859-2" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "A &os; közösség">
]>

<!-- $FreeBSD$ -->

<!-- The FreeBSD Hungarian Documentation Project
     Translated by: Gabor Kovesdan <gabor@FreeBSD.org>
     %SOURCE%   en/community.xsl
     %SRCID%    1.9
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
	      <p>A &os; mögött egy aktív
		fejlesztői közösség
		áll.</p>

	      <p>Több mint száz <a
		  href="&base;/community/mailinglists.html">levelezési
		lista</a>, tucatnyi <a
		  href="http://forums.FreeBSD.org/">fórum</a>,
		  és számos <a
		  href="&base;/community/newsgroups.html">hírcsoport</a>
		áll rendelkezésre.  Ezenkívül
		<xsl:value-of
		select="count(document($usergroups.xml)//entry)"
		/><xsl:text> </xsl:text><a
		  href="&base;/usergroups.html">felhasználói
		csoport</a> létezik a világ <xsl:value-of
		select="count(document($usergroups.xml)//country)" />
		országában, és rendelkezünk
		egy aktív <a
		  href="&base;/community/irc.html">IRC</a>
		közösséggel is.  Ezenkívül
		még sok fejlesztő ír <a
		  href="http://planet.freebsdish.org">blogot</a> a
		&os;-vel kapcsolatos munkájáról.  A
		fejlesztők és a jelentősebb
		támogatók továbbá egy <a
		  href="http://wiki.FreeBSD.org/">wikit</a> is
		fenntartanak, ahol a &os; fejlesztésével
		és a hozzákapcsolódó
		projektekről olvashatunk.  Emellett a &os;-vel
		még számos <a
		  href="&base;/community/social.html">ismertségi
		hálózaton</a> is
		találkozhatunk.</p>

	      <p>Tavaly a &os;-vel kapcsolatban <xsl:value-of
		select="count(/events/event[number(enddate/year) =
		(number($curdate.year) -1)])" /> rendezvény zajlott
		le a világ <xsl:value-of
		select="count(/events/event[(number(enddate/year) =
		(number($curdate.year) -1)) and (generate-id() =
		generate-id(key('last-year-event-by-country',
		location/country)[1]))])" /> országában.
		A közelgő rendezvényekről a <a
		  href="&base;/events/events.html"> róluk
		szóló lapon</a> található,
		folyamatosan frissülő <a
		  href="&base;/events/events.ics">kalendáriumban</a>
		és <a
		  href="&base;/events/rss.xml">RSS feedeken</a>
		keresztül értesülhetünk.  A
		korábban lezajlott rendezvényekről a
		YouTube oldalán egy <a
		  href="http://www.youtube.com/bsdconferences">BSD
		  konferenciákat</a> összefoglaló
		csatornán találhatunk videoanyagokat.</p>

		<div id="latest-videos" style="display:none;">
		  <h3>A legfrissebb videók</h3>

		  <div id="videoBar-bar">
		    <span style="color:#676767;font-size:11px;margin:10px;padding:4px;">Betöltés...</span>
		  </div>

		  <script src="http://www.google.com/uds/api?file=uds.jp&amp;v=1.0&amp;source=uds-vbw" type="text/javascript"></script>

		  <style type="text/css">
		    @import url("http://www.google.com/uds/css/gsearch.css");
		  </style>

		  <script type="text/javascript">
		    window._uds_vbw_donotrepair = true;
		  </script>

		  <script src="http://www.google.com/uds/solutions/videobar/gsvideobar.js?mode=new" text="text/javascript"></script>

		  <style type="text/css">
		    @import url("http://www.google.com/uds/solutions/videobar/gsvideobar.css");
		  </style>

		  <style type="text/css">
		    .playerInnerBox_gsvb .player_gsvb {
		      width  : 320px;
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
			  cycleTime   : GSvideoBar.CYCLE_TIME_MEDIUM,
			  cycleMode   : GSvideoBar.CYCLE_MODE_LINEAR,
			  executeList : ["ytchannel:bsdconferences"]
			}
		      }
		      videoBar = new GSvideoBar(document.getElementById("videoBar-bar"),
		                                GSvideoBar.PLAYER_ROOT_FLOATING,
		                                options);
		    }
		    GSearch.setOnLoadCallback(LoadVideoBar);
		  </script>
		</div> <!-- latest-videos -->
  </xsl:template>
</xsl:stylesheet>
