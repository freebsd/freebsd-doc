<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "Die FreeBSD-Gemeinde">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!-- $FreeBSD$ -->
<!-- $FreeBSDde: de-www/community.xsl,v 1.1 2008/04/27 18:03:21 jkois Exp $ -->
<!-- basiert auf: 1.3 -->

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

	      <p>FreeBSD wird von einer aktiven Gemeinschaft
		unterst&uuml;tzt.</p>

	      <p>Es gibt mehr als 100 <a
		href="&base;/community/mailinglists.html">
		Mailinglisten</a> sowie diverse <a
		href="&base;/community/newsgroups.html">Newsgroups</a>.
		Dazu kommen mehr als 91 <!-- <xsl:value-of
		select="count(document($usergroups.xml)//entry)"
		/><xsl:text> </xsl:text>--> <a
		href="&enbase;/usergroups.html">User Groups</a> in
		37 L&#228;ndern. <!--<xsl:value-of
		select="count(document($usergroups.xml)//country)" />-->
		Zus&#228;tzlich existiert eine aktive <a
		href="&base;/community/irc.html">IRC</a>-Gemeinde.
		Viele Entwickler betreiben auch <a
		href="http://planet.freebsdish.org">Blogs</a>, in denen
		sie &#252;ber ihre Arbeit an FreeBSD berichten.</p>

	      <p>Letztes Jahr gab es insgesamt 22 <!-- <xsl:value-of
	        select="count(event[number(enddate/year) =
	        (number($curdate.year) -1)])" />-->
		FreeBSD-Veranstaltungen in 11 <!--<xsl:value-of
		select="count(event[(number(enddate/year) =
		(number($curdate.year) -1)) and (generate-id() =
		generate-id(key('last-year-event-by-country',
		location/country)[1]))])" />--> verschiedenen L&#228;ndern.
		Ein <a href="&enbase;/events/events.ics">Kalender</a> sowie
		ein <a href="&enbase;/events/rss.xml">RSS Feed</a> zu
		bevorstehenden FreeBSD-spezifischen Veranstaltungen sind
		auf der Seite <a
		href="&enbase;/events/events.html">Veranstaltungen</a>
		verf&#252;gbar.</p>

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
