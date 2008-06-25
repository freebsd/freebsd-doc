<?xml version="1.0" encoding="ISO-8859-2" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD K&ouml;z&ouml;ss&eacute;g">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!-- $FreeBSD: www/hu/community.xsl,v 1.1 2008/05/02 08:56:08 pgj Exp $ -->

<!-- The FreeBSD Hungarian Documentation Project
     Translated by: Gabor Kovesdan <gabor@FreeBSD.org>
     %SOURCE%   en/community.xsl
     %SRCID%    1.3
-->

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

	      <p>A FreeBSD j&oacute;l t&aacute;mogatott az akt&iacute;v
		felhaszn&aacute;l&oacute;i k&ouml;z&ouml;ss&eacute;ge
		&aacute;ltal.</p>

	      <p>T&ouml;bb mint sz&aacute;z <a
		href="&base;/community/mailinglists.html">levelez&eacute;si
		lista</a> &eacute;s sz&aacute;mos <a
		href="&base;/community/newsgroups.html">h&iacute;rcsoport</a>
		&aacute;ll rendelkez&eacute;sre.  Ezenk&iacute;v&uuml;l
		k&ouml;z&uuml;l <xsl:value-of
		select="count(document($usergroups.xml)//entry)"
		/><xsl:text> </xsl:text><a
		href="&base;/usergroups.html">felhaszn&aacute;l&oacute;i
		csoport</a> l&eacute;tezik a vil&aacute;g <xsl:value-of
		select="count(document($usergroups.xml)//country)" />
		orsz&aacute;g&aacute;ban, &eacute;s rendelkez&uuml;nk
		egy akt&iacute;v <a
		href="&base;/community/irc.html">IRC</a>
		k&ouml;z&ouml;ss&eacute;ggel is.  Ezenk&iacute;v&uuml;l
		m&eacute;g sok fejleszt&#245; &iacute;r <a
		href="http://planet.freebsdish.org">blogot</a> a
		FreeBSD-vel kapcsolatos
		munk&aacute;j&aacute;r&oacute;l.</p>

	      <p>Tavaly a FreeBSD-vel kapcsolatban <xsl:value-of
		select="count(event[number(enddate/year) =
		(number($curdate.year) -1)])" /> esem&eacute;ny zajlott
		le a vil&aacute;g <xsl:value-of
		select="count(event[(number(enddate/year) =
		(number($curdate.year) -1)) and (generate-id() =
		generate-id(key('last-year-event-by-country',
		location/country)[1]))])" /> orsz&aacute;g&aacute;ban.
		A k&ouml;zelg&#245; esem&eacute;nyekr&#245;l a <a
		href="&base;/events/events.html"> r&oacute;luk
		sz&oacute;l&oacute; lapon</a> tal&aacute;lhat&oacute;,
		folyamatosan friss&uuml;l&#245; <a
		href="&base;/events/events.ics">kalend&aacute;riumban</a>
		&eacute;s <a href="&base;/events/rss.xml">RSS
		feedeken</a> kereszt&uuml;l
		&eacute;rtes&uuml;lhet&uuml;nk.</p>

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
