<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <xsl:variable name="title">FreeBSD GNOME Project News</xsl:variable>
    <xsl:variable name="link">https://www.FreeBSD.org/gnome/</xsl:variable>

    <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
      <channel>

        <title><xsl:value-of select="$title" /></title>
        <link><xsl:value-of select="$link" /></link>
        <description>FreeBSD GNOME News System</description>
        <language>en-us</language>
        <webMaster>freebsd-gnome@FreeBSD.org (FreeBSD GNOME Team)</webMaster>
        <managingEditor>freebsd-gnome@FreeBSD.org (FreeBSD GNOME Team)</managingEditor>
        <docs>http://blogs.law.harvard.edu/tech/rss</docs>
        <ttl>120</ttl>
        <image>
          <url>https://www.FreeBSD.org/logo/logo-full.png</url>
          <title><xsl:value-of select="$title" /></title>
          <link><xsl:value-of select="$link" /></link>
        </image>
        <atom:link rel="self" type="application/rss+xml">
          <xsl:attribute name="href">
            <xsl:value-of select="$link" /><xsl:text>rss.xml</xsl:text>
          </xsl:attribute>
        </atom:link>

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

            <link>https://www.FreeBSD.org/gnome/newsflash.html#<xsl:value-of select="$guid" /></link>
            <guid>https://www.FreeBSD.org/gnome/newsflash.html#<xsl:value-of select="$guid" /></guid>

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

      </channel>
    </rss>

  </xsl:template>

  <xsl:template match="a">
    <xsl:value-of select="@href" />
  </xsl:template>
</xsl:stylesheet>
