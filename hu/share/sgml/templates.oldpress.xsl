<?xml version="1.0" encoding="ISO-8859-2" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "&os; a sajt&oacute;ban">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.about "INCLUDE">
]>

<!-- $FreeBSD$ -->

<!-- The FreeBSD Hungarian Documentation Project
     Translated by: PALI, Gabor <pgj@FreeBSD.org>
     %SOURCE%	share/sgml/templates.oldpress.xsl
     %SRCID%	1.7
-->

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

  <xsl:template match="press">
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

	<xsl:apply-templates select="//month"/>
	
	<p>A kor&aacute;bbi &eacute;vek sajt&oacute;kiadv&aacute;nyai
	  (2008-t&oacute;l magyarul):
	  <a href="&base;/news/2008/press.html">2008</a>,
	  <a href="&enbase;/news/2007/press.html">2007</a>,
	  <a href="&enbase;/news/2006/press.html">2006</a>,
	  <a href="&enbase;/news/2005/press.html">2005</a>,
	  <a href="&enbase;/news/2004/press.html">2004</a>,
	  <a href="&enbase;/news/2003/press.html">2003</a>,
	  <a href="&enbase;/news/2002/press.html">2002</a>,
	  <a href="&enbase;/news/2001/press.html">2001</a>,
	  <a href="&enbase;/news/2000/press.html">2000</a>,
	  <a href="&enbase;/news/1999/press.html">1999</a>,
	  <a href="&enbase;/news/1998/press.html">1998-1996</a></p>

	<a href="&base;/news/news.html">H&iacute;rek f&#245;oldal</a>
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

  <xsl:template match="month">
    <h1>
      <xsl:value-of select="ancestor::year/name"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="transtable-lookup">
	<xsl:with-param name="word-group" select="'number-month'" />
	<xsl:with-param name="word">
	  <xsl:value-of select="name"/>
	</xsl:with-param>
      </xsl:call-template></h1>

    <ul>
      <xsl:apply-templates select="descendant::story"/>
    </ul>
  </xsl:template>

  <xsl:template match="story">
    <xsl:variable name="url"><xsl:value-of select="url"/></xsl:variable>
    <xsl:variable name="site-url"><xsl:value-of
    select="site-url"/></xsl:variable>

    <li>
      <a>
	<xsl:attribute name="name">
	  <xsl:call-template name="generate-story-anchor"/>
	</xsl:attribute>
      </a>

      <p><a href="{$url}"><b><xsl:value-of
      select="name"/></b></a><br/>
	  
	<a href="{$site-url}"><xsl:value-of
	select="site-name"/></a>, <xsl:value-of select="author"/><br/>
	<xsl:copy-of select="p/child::node()"/>
      </p>
    </li>
  </xsl:template>
</xsl:stylesheet>
