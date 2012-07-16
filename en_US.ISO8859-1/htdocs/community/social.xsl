<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Social Networks">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/xhtml.xsl"/>

  <xsl:template name="process.content">
              <div id="SIDEWRAP">
                &nav;
              </div> <!-- SIDEWRAP -->

	      <div id="CONTENTWRAP">
		&header3;

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

		<li>You can follow <a
		href="http://twitter.com/freebsdannounce">@freebsdannounce</a>,
		<a
		href="http://twitter.com/freebsdblogs">@freebsdblogs</a>,
		<a href="http://twitter.com/freebsd">@freebsd</a>, or
		<a href="http://twitter.com/bsdevents">@bsdevents</a>
		on <a href="http://twitter.com">Twitter</a>.</li>

	      </ul>

	      </div> <!-- CONTENTWRAP -->
	      <br class="clearboth" />
  </xsl:template>
</xsl:stylesheet>
