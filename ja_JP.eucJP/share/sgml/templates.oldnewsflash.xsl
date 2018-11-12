<?xml version="1.0" encoding="euc-jp" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD News Flash">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.about "INCLUDE">
]>

<!-- $FreeBSD$ -->
<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: r39146 -->

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

	<div id="CONTAINERWRAP">
	<div id="CONTAINER">

	  &header2;

	<div id="CONTENT">
	<div id="SIDEWRAP">
	  &nav;
	</div> <!-- SIDEWRAP -->

	<div id="CONTENTWRAP">

	&header3;

	<!-- Notice how entity references in SGML become variable references
	     in the stylesheet, and that the syntax for referring to variables
	     inside an attribute is "{$variable}".

	     This is just dis-similar enough to Perl and the shell that you
	     end up writing ${variable} all the time, and then scratch your 
	     head wondering why the stylesheet isn't working.-->

	<!-- Also notice that because this is now XML and not SGML, empty
             elements, like IMG, must have a trailing "/" just inside the 
   	     closing angle bracket, like this " ... />" -->
	<img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
	     height="144" alt="FreeBSD News"/>

	<xsl:apply-templates select="descendant::month"/>
	
	<p>Other project news:
	  <a href="&enbase;/news/2009/index.html">2009</a>,
	  <a href="&enbase;/news/2008/index.html">2008</a>,
	  <a href="&enbase;/news/2007/index.html">2007</a>,
	  <a href="&enbase;/news/2006/index.html">2006</a>,
	  <a href="&enbase;/news/2005/index.html">2005</a>,
	  <a href="&enbase;/news/2004/index.html">2004</a>,
	  <a href="&enbase;/news/2003/index.html">2003</a>,
	  <a href="&enbase;/news/2002/index.html">2002</a>,
	  <a href="../2001/index.html">2001</a>,
	  <a href="&enbase;/2000/index.html">2000</a>,
	  <a href="&enbase;/1999/index.html">1999</a>,
	  <a href="&enbase;/1998/index.html">1998</a>,
	  <a href="../1997/index.html">1997</a>,
	  <a href="../1996/index.html">1996</a>,
	  <a href="&enbase;/1993/index.html">1993</a></p>

	<a href="&base;/news/news.html">News Home</a>
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

  <!-- Everything that follows are templates for the rest of the content -->
  
  <xsl:template match="month">
    <h1>
      <xsl:value-of select="ancestor::year/name"/>
      <xsl:text> ǯ </xsl:text>
      <xsl:call-template name="transtable-lookup">
	<xsl:with-param name="word-group" select="'number-month'" />
	<xsl:with-param name="word">
	  <xsl:value-of select="name"/>
	</xsl:with-param>
      </xsl:call-template>
    </h1>

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

	<b>
	  <xsl:value-of select="ancestor::year/name"/>
	  <xsl:text> ǯ </xsl:text>
	  <xsl:call-template name="transtable-lookup">
	    <xsl:with-param name="word-group" select="'number-month'" />
	    <xsl:with-param name="word">
	      <xsl:value-of select="ancestor::month/name"/>
	    </xsl:with-param>
	  </xsl:call-template>
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="ancestor::day/name"/>
	  <xsl:text> ��</xsl:text>:</b><xsl:text> </xsl:text>
	  <xsl:for-each select="p">
	  <xsl:if test="position() &gt; 1"><br /><br /></xsl:if>
	  <xsl:copy-of select="child::node()" />
	  </xsl:for-each>
	</p>

    </li>
  </xsl:template>

  <xsl:template match="date"/>    <!-- Deliberately left blank -->

</xsl:stylesheet>
