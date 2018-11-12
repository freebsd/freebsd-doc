<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>

  <xsl:output method="xml" indent="yes" encoding="&xml.encoding;"/>

  <!-- Generate the main body of the RDF file -->
  <xsl:template match="news">
    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	     xmlns="http://my.netscape.com/rdf/simple/0.9/">

      <channel>
	<title>FreeBSD Project News</title>
	<link>https://www.FreeBSD.org/news/</link>
	<description>News from the FreeBSD Project</description>
      </channel>

      <!-- Only include the last 10 events -->
      <xsl:apply-templates select="descendant::event[position() &lt;= 10]"/>

      </rdf:RDF>
  </xsl:template>

  <!-- Generate the <item> elements and their content -->
  <xsl:template match="event" xmlns="http://my.netscape.com/rdf/simple/0.9/">
    <xsl:param name="year" select="../../../name" />
    <xsl:param name="month" select="../../name" />
    <xsl:param name="day" select="../name" />
    <xsl:param name="this" select="." />
    <xsl:param name="pos">
      <xsl:for-each select="../event">
	<xsl:if test=". = $this">
	  <xsl:value-of select="position()" />
	</xsl:if>
      </xsl:for-each>
    </xsl:param>

    <item>
      <xsl:choose>
	<xsl:when test="count(child::title)">
	  <title><xsl:value-of select="normalize-space(title)"/></title>
	</xsl:when>
	<xsl:otherwise>
	  <title><xsl:value-of select="normalize-space(p)"/></title>
	</xsl:otherwise>
      </xsl:choose>
      <link>
	<xsl:text>https://www.FreeBSD.org/news/newsflash.html#</xsl:text>
	<xsl:call-template name="html-news-generate-anchor">
	  <xsl:with-param name="label" select="'event'" />
	  <xsl:with-param name="year" select="$year" />
	  <xsl:with-param name="month" select="$month" />
	  <xsl:with-param name="day" select="$day" />
	  <xsl:with-param name="pos" select="$pos" />
	</xsl:call-template>
      </link>
    </item>
  </xsl:template>

  <xsl:template match="name | date"/>
</xsl:stylesheet>
