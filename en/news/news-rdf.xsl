<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/en/news/news-rdf.xsl,v 1.4 2001/11/07 15:53:47 nik Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="includes.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="base" select="'..'"/>

  <!-- Generate the main body of the RDF file -->
  <xsl:template match="news">
    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	     xmlns="http://my.netscape.com/rdf/simple/0.9/">

      <channel>
	<title>FreeBSD Project News</title>
	<link>http://www.FreeBSD.org/news/</link>
	<description>News from the FreeBSD Project</description>
      </channel>

      <!-- Only include the last 10 events -->
      <xsl:apply-templates select="descendant::event[position() &lt;= 10]"/>

      </rdf:RDF>
  </xsl:template>

  <!-- Generate the <item> elements and their content -->
  <xsl:template match="event">
    <item>
      <xsl:choose>
	<xsl:when test="count(child::title)">
	  <title><xsl:value-of select="normalize-space(title)"/></title>
	</xsl:when>
	<xsl:otherwise>
	  <title><xsl:value-of select="normalize-space(p)"/></title>
	</xsl:otherwise>
      </xsl:choose>
      <link>http://www.FreeBSD.org/news/newsflash.html#<xsl:call-template name="generate-event-anchor"/></link>
    </item>
  </xsl:template>
  
  <xsl:template match="name | date"/>
</xsl:stylesheet>
