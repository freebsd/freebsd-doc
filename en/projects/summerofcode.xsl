<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Summer Projects">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.developers "INCLUDE">
<!ENTITY % developers SYSTEM "../developers.sgml"> %developers;
]>

<!-- $FreeBSD: www/en/projects/summerofcode.xsl,v 1.7 2007/04/13 19:28:14 murray Exp $ -->

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

<p>The FreeBSD Project was a successful mentoring organization in the
  Google <a href="http://code.google.com/summerofcode.html">Summer of
  Code</a>.  This program funds students to contribute to an open
  source project over the summer break.  We have had over 50 successful
  students working on FreeBSD as part of this program in <a
  href="&base;/summerofcode-2005.html">2005</a>, <a
  href="&base;/summerofcode-2006.html">2006</a>, and <a
  href="&base;/summerofcode-2007.html">2007</a>.</p>
 
<a name="students"></a>
<h2>Past Student Projects</h2>

<p>For a complete list of student projects from previous years,
visit:</p>
<ul>
  <li><a href="&base;/projects/summerofcode-2007.html">Summer of Code 2007 FreeBSD
  Projects Summary</a></li>
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

<a name="faq"></a>
<h2>Frequently Asked Questions</h2>

<ul>
  <li><p><strong>What about Summer of 2008?</strong></p>

    <p>We again hope to be able to work with Google and participate in
a sponsored Google Summer of Code program in 2008.  Please check
back in Spring 2008 for details.</p>
  </li>
</ul>

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
