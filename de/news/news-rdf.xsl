<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD$
     $FreeBSDde: de-www/news/news-rdf.xsl,v 1.3 2003/08/17 16:55:27 mheinen Exp $
     basiert auf: 1.5 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="includes.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="base" select="'..'"/>

  <!-- Generate the main body of the RDF file -->
  <xsl:template match="news">
    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	     xmlns="http://my.netscape.com/rdf/simple/0.9/">

      <channel>
	<title>FreeBSD Project Nachrichten</title>
	<link>http://www.FreeBSD.org/news/</link>
	<description>Neuigkeiten aus dem FreeBSD Project</description>
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
      <link>http://www.FreeBSD.org/de/news/newsflash.html#<xsl:call-template name="generate-event-anchor"/></link>
    </item>
  </xsl:template>

  <xsl:template match="name | date"/>
</xsl:stylesheet>
