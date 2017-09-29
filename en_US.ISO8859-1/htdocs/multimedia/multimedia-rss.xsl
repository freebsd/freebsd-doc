<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Multimedia Resources List">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:date="http://exslt.org/dates-and-times"
	extension-element-prefixes="date">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>

  <xsl:output method="xml" indent="yes" encoding="&xml.encoding;"/>

  <xsl:template match="/">
    <rss version="2.0">

      <channel>
	<title>&title;</title>
	<link>https://www.freebsd.org/multimedia/multimedia.html</link>
	<description>FreeBSD Multimedia Resources</description>
	<lastBuildDate><xsl:value-of select="date:date-time()"/></lastBuildDate>

	<xsl:apply-templates select=".//item"/>

      </channel>
    </rss>
  </xsl:template>

  <xsl:template match="item">
    <item>
      <title><xsl:value-of select="title"/></title>

      <guid><xsl:value-of select="overview"/></guid>

      <pubdate>
	<xsl:call-template name="misc-format-date-string">
	  <xsl:with-param name="year" select="substring(@added, 1, 4)"/>
	  <xsl:with-param name="month" select="substring(@added, 5, 2)"/>
	  <xsl:with-param name="day" select="substring(@added, 7, 2)"/>
	</xsl:call-template>
      </pubdate>

      <xsl:for-each select="files/file">
	<enclosure url="{url}" length="1" type="application/octet-stream"/>
      </xsl:for-each>

      <description>
	<xsl:value-of select="desc"/>
      </description>
    </item>
  </xsl:template>
</xsl:stylesheet>
