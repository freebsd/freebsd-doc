<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD News Flash">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.about "INCLUDE">
]>

<!-- $FreeBSD: www/share/sgml/templates.oldnewsflash.xsl,v 1.1 2006/08/19 21:20:54 hrs Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">

  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="year">
    <xsl:value-of select="descendant::year/name"/>
  </xsl:variable>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>
  
  <xsl:output type="html" encoding="&xml.encoding;"/>

  <xsl:template match="p">
    <xsl:copy-of select="." />
  </xsl:template>

  <xsl:template match="news">
    <html>
      
      &header1;

      <body>

	&header2;

	<!-- Notice how entity references in SGML become variable references
	     in the stylesheet, and that the syntax for referring to variables
	     inside an attribute is "{$variable}".

	     This is just dis-similar enough to Perl and the shell that you
	     end up writing ${variable} all the time, and then scratch your 
	     head wondering why the stylesheet isn't working.-->

	<!-- Also notice that because this is now XML and not SGML, empty
             elements, like IMG, must have a trailing "/" just inside the 
   	     closing angle bracket, like this " ... />" -->
	<img src="&base;/gifs/news.jpg" align="right" border="0" width="193"
	     height="144" alt="FreeBSD News"/>

	<xsl:apply-templates select="descendant::month"/>
	
	<a href="news.html">News Home</a>
            <div id="FOOTER">
               &copyright;<br />
               &date;
            </div> <!-- FOOTER -->
      </body>
    </html>
  </xsl:template>

  <!-- Everything that follows are templates for the rest of the content -->
  
  <xsl:template match="month">
    <h1>
      <xsl:call-template name="transtable-lookup">
	<xsl:with-param name="word-group" select="'number-month'" />
	<xsl:with-param name="word">
	  <xsl:value-of select="name"/>
	</xsl:with-param>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:value-of select="ancestor::year/name"/></h1>

    <ul>
      <xsl:apply-templates select="descendant::day"/>
    </ul>
  </xsl:template>

  <xsl:template match="day">
    <xsl:apply-templates select="event"/>
  </xsl:template>

  <xsl:template match="event">
    <li><p><a>
	  <xsl:attribute name="name">
	    <xsl:call-template name="generate-event-anchor"/>
	  </xsl:attribute>
	</a>

	<b><xsl:value-of select="ancestor::day/name"/>
	  <xsl:text> </xsl:text>
	  <xsl:call-template name="transtable-lookup">
	    <xsl:with-param name="word-group" select="'number-month'" />
	    <xsl:with-param name="word">
	      <xsl:value-of select="ancestor::month/name"/>
	    </xsl:with-param>
	  </xsl:call-template>
	  <xsl:text>, </xsl:text>
	  <xsl:value-of select="ancestor::year/name"/>:</b><xsl:text> </xsl:text>
	<xsl:copy-of select="p"/>
	</p>

    </li>
  </xsl:template>

  <xsl:template match="date"/>    <!-- Deliberately left blank -->

</xsl:stylesheet>
