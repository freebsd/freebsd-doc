<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Summer Projects">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.developers "INCLUDE">
<!ENTITY % developers SYSTEM "../developers.sgml"> %developers;
]>

<!-- $FreeBSD: www/en/projects/summerofcode.xsl,v 1.6 2007/04/13 02:02:54 murray Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:param name="ideas.xml" select="'ideas/ideas.xml'" />

  <xsl:output type="html" encoding="&xml.encoding;"/>

  <xsl:template match="ideas">
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

<p>The FreeBSD Project is pleased to participate as a mentoring organization in the
  Google <a href="http://code.google.com/summerofcode.html">Summer of
  Code</a> 2007.  This program funds students to contribute to an open
  source project over the summer break.  We had dozens of successful
  students working on FreeBSD as part of this program in <a
  href="&base;/projects/summerofcode-2005.html">2005</a> and <a
  href="&base;/projects/summerofcode-2006.html">2006</a>.  We are
  currently working with 25 talented students for <a
  href="&base;/projects/summerofcode-2007.html">Summer 2007</a>.</p>

<a name="students"></a>
<h2>Past Student Projects</h2>

<p>For a complete list of student projects from previous years,
visit:</p>
<ul>
  <li><a href="&base;/projects/summerofcode-2007.html">Summer of Code 2007 FreeBSD
  Projects Summary</a> &nbsp; <em>(In Progress)</em></li>
  <li><a href="&base;/projects/summerofcode-2006.html">Summer of Code 2006 FreeBSD
  Projects Summary</a></li>
  <li><a href="&base;/projects/summerofcode-2005.html">Summer of Code 2005 FreeBSD
  Projects Summary</a></li>
</ul>

<p>See also our wiki pages for student projects [<a
href="http://wiki.freebsd.org/moin.cgi/SummerOfCode2007">2007</a>,
<a
href="http://wiki.freebsd.org/moin.cgi/SummerOfCode2006">2006</a>, and 
<a
href="http://wiki.freebsd.org/moin.cgi/SummerOfCode2005">2005</a>].</p>

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
