<?xml version="1.0" encoding="euc-jp" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD News Flash">
<!ENTITY link "https://www.FreeBSD.org/ja/news/">
<!ENTITY email "freebsd-www">
<!ENTITY realname "Webmaster Team">
]>

<!-- $FreeBSD$ -->
<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: r50962 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>

  <xsl:output method="xml" indent="yes" encoding="&xml.encoding;"/>

  <!-- Generate the main body of the RDF file -->
  <xsl:template match="news">
    <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">

      <channel>
	<title>&title;</title>
	<link>&link;</link>
	<description>FreeBSD プロジェクトの最新ニュース</description>
	<language>ja-jp</language>
	<webMaster>&email;@FreeBSD.org (&realname;)</webMaster>
	<managingEditor>&email;@FreeBSD.org (&realname;)</managingEditor>
	<docs>http://blogs.law.harvard.edu/tech/rss</docs>
	<ttl>120</ttl>
	<image>
	  <url>https://www.FreeBSD.org/logo/logo-full.png</url>
	  <title>&title;</title>
	  <link>&link;</link>
	</image>
	<atom:link href="&link;rss.xml" rel="self" type="application/rss+xml" />
      <!-- Only include the last 10 events -->
      <xsl:apply-templates select="descendant::event[position() &lt;= 10]"/>

      </channel>
      </rss>
  </xsl:template>

  <!-- Generate the <item> elements and their content -->
  <xsl:template match="event">
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

    <xsl:variable name="link">
	<xsl:text>https://www.FreeBSD.org/ja/news/newsflash.html#</xsl:text>
	<xsl:call-template name="html-news-generate-anchor">
	  <xsl:with-param name="label" select="'event'" />
	  <xsl:with-param name="year" select="$year" />
	  <xsl:with-param name="month" select="$month" />
	  <xsl:with-param name="day" select="$day" />
	  <xsl:with-param name="pos" select="$pos" />
	</xsl:call-template>
    </xsl:variable>

    <item>
      <xsl:choose>
	<xsl:when test="count(child::title)">
	  <title><xsl:value-of select="normalize-space(title)"/></title>
	  <description><xsl:value-of select="normalize-space(p)"/></description>
	</xsl:when>
	<xsl:otherwise>
	  <title><xsl:value-of select="normalize-space(p)"/></title>
	</xsl:otherwise>
      </xsl:choose>
      <link><xsl:value-of select="normalize-space($link)"/></link>
      <guid><xsl:value-of select="normalize-space($link)"/></guid>

      <pubDate>
	<xsl:call-template name="misc-format-date-string">
	    <xsl:with-param name="year" select="$year" />
	    <xsl:with-param name="month" select="$month" />
	    <xsl:with-param name="day" select="$day" />
	    <xsl:with-param name="date-format" select="$param-l10n-date-format-rfc822" />
	</xsl:call-template>
      </pubDate>
    </item>
  </xsl:template>

  <xsl:template match="name | date"/>

</xsl:stylesheet>
