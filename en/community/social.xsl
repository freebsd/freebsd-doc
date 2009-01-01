<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Social Networks">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!-- $FreeBSD: www/en/community/social.xsl,v 1.3 2008/12/30 08:58:50 murray Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:output method="xml" encoding="&xml.encoding;"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

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

	      </ul>

	      <h3>Blog Activity</h3>

	      <p>Posts that contain <a
href="http://technorati.com/search/freebsd?sub=chartlet&amp;language=n&amp;authority=n">FreeBSD</a> per day for the last 90 days.<br /><a
href="http://technorati.com/search/freebsd?sub=chartlet&amp;language=n&amp;authority=n"><img
src="http://technorati.com/chartimg/freebsd?totalHits=24190&amp;size=s&amp;days=90"
style="border:0" alt="Technorati Chart" /></a>
              </p>

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
