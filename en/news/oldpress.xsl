<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/en/news/oldpress.xsl,v 1.2 2004/06/12 04:14:10 jkoshy Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>

  <xsl:variable name="year">
    <xsl:value-of select="descendant::year/name"/>
  </xsl:variable>
  <xsl:variable name="base" select="'../..'"/>
  <xsl:variable name="title" select="concat('FreeBSD in the Press (', $year, ')')"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>
  
  <xsl:output type="html" encoding="iso-8859-1"/>

  <xsl:template match="press">
    <html>
      
      <xsl:copy-of select="$header1"/>

      <body>

	<xsl:copy-of select="$header2"/>

	<xsl:apply-templates select="//month"/>
	
	<p>Other press publications:
	  <a href="../press.html">2003-2004</a>,
	  <a href="../2002/press.html">2002</a>,
	  <a href="../2001/press.html">2001</a>,
	  <a href="../2000/press.html">2000</a>,
	  <a href="../1999/press.html">1999</a>,
	  <a href="../1998/press.html">1998-1996</a></p>

	<xsl:copy-of select="$presshome"/>,
	<xsl:copy-of select="$newshome"/>
	<xsl:copy-of select="$footer"/>
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
