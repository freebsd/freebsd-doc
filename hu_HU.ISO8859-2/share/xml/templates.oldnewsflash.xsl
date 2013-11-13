<?xml version="1.0" encoding="iso-8859-2" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "&os; hírek">
]>

<!-- $FreeBSD$ -->

<!-- The FreeBSD Hungarian Documentation Project
     Translated by: PALI, Gabor <pgj@FreeBSD.org>
     %SOURCE%	share/xml/templates.oldnewsflash.xsl
     %SRCID%	1.10
-->

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

  <xsl:template match="p">
    <xsl:apply-templates select="." mode="copy.html"/>
  </xsl:template>

  <xsl:template name="process.sidewrap">
    &nav.about;
  </xsl:template>

  <xsl:template name="process.contentwrap">
	<img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
	     height="144" alt="&os; hírek"/>

	<xsl:apply-templates select="descendant::month"/>

	<p>A korábbi évek hírei (2009-től
	  magyarul):
	  <a href="&base;/news/2009/index.html">2009</a>,
	  <a href="&enbase;/news/2008/index.html">2008</a>,
	  <a href="&enbase;/news/2007/index.html">2007</a>,
	  <a href="&enbase;/news/2006/index.html">2006</a>,
	  <a href="&enbase;/news/2005/index.html">2005</a>,
	  <a href="&enbase;/news/2004/index.html">2004</a>,
	  <a href="&enbase;/news/2003/index.html">2003</a>,
	  <a href="&enbase;/news/2002/index.html">2002</a>,
	  <a href="&enbase;/news/2001/index.html">2001</a>,
	  <a href="&enbase;/news/2000/index.html">2000</a>,
	  <a href="&enbase;/news/1999/index.html">1999</a>,
	  <a href="&enbase;/news/1998/index.html">1998</a>,
	  <a href="&enbase;/news/1997/index.html">1997</a>,
	  <a href="&enbase;/news/1996/index.html">1996</a></p>

	<a href="&base;/news/news.html">Hírek főoldal</a>
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

	<b><xsl:value-of select="ancestor::year/name"/>
	  <xsl:text>. </xsl:text>
	  <xsl:call-template name="transtable-lookup">
	    <xsl:with-param name="word-group" select="'number-month'" />
	    <xsl:with-param name="word">
	      <xsl:value-of select="ancestor::month/name"/>
	    </xsl:with-param>
	  </xsl:call-template>
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="ancestor::day/name"/>:</b><xsl:text> </xsl:text>
	  <xsl:for-each select="p">
	  <xsl:if test="position() &gt; 1"><br /><br /></xsl:if>
	  <xsl:apply-templates select="child::node()" mode="copy.html"/>
	  </xsl:for-each>
	</p>

    </li>
  </xsl:template>

  <xsl:template match="date"/>

</xsl:stylesheet>
