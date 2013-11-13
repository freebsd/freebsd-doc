<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
      <channel>
        <xsl:call-template name="rss-java-news-title" />
        <xsl:call-template name="rss-java-news-items" />
      </channel>
    </rss>
  </xsl:template>

  <!-- template: "rss-java-news-title"
       pulls in the 10 most recent java news items -->

  <xsl:template name="rss-java-news-title"
                xmlns:atom="http://www.w3.org/2005/Atom">

    <xsl:variable name="title">FreeBSD Java Project News</xsl:variable>
    <xsl:variable name="link">http://www.FreeBSD.org/java/</xsl:variable>

    <title><xsl:value-of select="$title" /></title>
    <link><xsl:value-of select="$link" /></link>
    <description>Java newsflash items from the FreeBSD Project</description>
    <language>en-us</language>
    <webMaster>freebsd-java@FreeBSD.org (FreeBSD Java Team)</webMaster>
    <managingEditor>freebsd-java@FreeBSD.org (FreeBSD Java Team)</managingEditor>
    <docs>http://blogs.law.harvard.edu/tech/rss</docs>
    <ttl>120</ttl>
    <image>
      <url>http://www.FreeBSD.org/logo/logo-full.png</url>
      <title><xsl:value-of select="$title" /></title>
      <link><xsl:value-of select="$link" /></link>
    </image>
    <atom:link rel="self" type="application/rss+xml">
      <xsl:attribute name="href">
        <xsl:value-of select="$link" /><xsl:text>rss.xml</xsl:text>
      </xsl:attribute>
    </atom:link>
  </xsl:template>

  <!-- template: "rss-java-news-items"
       pulls in the 10 most recent security advisories -->

  <xsl:template name="rss-java-news-items"
                xmlns:atom="http://www.w3.org/2005/Atom">

    <xsl:for-each select="descendant::event[position() &lt;= 10]">
      <xsl:variable name="guid"><xsl:call-template name="generate-event-anchor"/></xsl:variable>

      <xsl:variable name="month"><xsl:call-template name="generate-month-num"><xsl:with-param name="month" select="../../name"/></xsl:call-template></xsl:variable>
      <item>
        <title>
          <xsl:choose>
            <xsl:when test="count(child::title)">
              <xsl:value-of select="title"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:copy-of select="p"/>
            </xsl:otherwise>
          </xsl:choose>
        </title>

        <xsl:if test="count(child::title)">
          <description>
            <xsl:apply-templates select="p"/>
          </description>
        </xsl:if>

        <link>http://www.FreeBSD.org/java/newsflash.html#<xsl:value-of select="$guid" /></link>
        <guid>http://www.FreeBSD.org/java/newsflash.html#<xsl:value-of select="$guid" /></guid>

        <pubDate>
          <xsl:call-template name="misc-format-date-string">
            <xsl:with-param name="year" select="../../../name" />
            <xsl:with-param name="month" select="$month" />
            <xsl:with-param name="day" select="../name" />
            <xsl:with-param name="date-format" select="$param-l10n-date-format-rfc822" />
          </xsl:call-template>
        </pubDate>

      </item>

    </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>
