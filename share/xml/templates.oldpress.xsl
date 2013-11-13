<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD in the Press">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <!-- Do not add last modified date for old news/press -->
  <xsl:variable name="date"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:variable name="year">
    <xsl:value-of select="descendant::year/name"/>
  </xsl:variable>

  <xsl:template name="process.sidewrap">
    &nav.about;
  </xsl:template>

  <xsl:template name="process.content">
	<xsl:apply-templates select="//month"/>

	<p>Other press publications:
	  <a href="../2009/press.html">2009</a>,
	  <a href="../2008/press.html">2008</a>,
	  <a href="../2007/press.html">2007</a>,
	  <a href="../2006/press.html">2006</a>,
	  <a href="../2005/press.html">2005</a>,
	  <a href="../2004/press.html">2004</a>,
	  <a href="../2003/press.html">2003</a>,
	  <a href="../2002/press.html">2002</a>,
	  <a href="../2001/press.html">2001</a>,
	  <a href="../2000/press.html">2000</a>,
	  <a href="../1999/press.html">1999</a>,
	  <a href="../1998/press.html">1998-1996</a></p>

	<a href="&base;/news/news.html">News Home</a>
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
	<xsl:apply-templates select="p/child::node()" mode="copy.html"/>
      </p>
    </li>
  </xsl:template>
</xsl:stylesheet>
