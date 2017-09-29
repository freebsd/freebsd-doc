<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD in the Press">
<!ENTITY link "https://www.FreeBSD.org/news/press.html">
<!ENTITY email "freebsd-www">
<!ENTITY realname "Webmaster Team">
]>

<!-- $FreeBSD$ -->

<!-- Copyright (c) 2008 Murray Stokely <murray@FreeBSD.org>

     All rights reserved.

     Redistribution and use in source and binary forms, with or without
     modification, are permitted provided that the following conditions
     are met:
     1. Redistributions of source code must retain the above copyright
	notice, this list of conditions and the following disclaimer.
     2. Redistributions in binary form must reproduce the above copyright
	notice, this list of conditions and the following disclaimer in the
	documentation and/or other materials provided with the distribution.

     THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
     ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
     IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
     ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
     FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
     DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
     OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
     LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
     OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
     SUCH DAMAGE.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>

  <xsl:output method="xml" indent="yes" encoding="&xml.encoding;"/>

  <!-- Generate the main body of the RSS file -->
  <xsl:template match="press">
    <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">

      <channel>
	<title>&title;</title>
	<link>&link;</link>
	<description>Press Stories about FreeBSD</description>
	<language>en-us</language>
	<webMaster>&email;@FreeBSD.org (&realname;)</webMaster>
	<managingEditor>&email;@FreeBSD.org (&realname;)</managingEditor>
	<docs>http://blogs.law.harvard.edu/tech/rss</docs>
	<ttl>120</ttl>
	<image>
	  <url>https://www.FreeBSD.org/logo/logo-full.png</url>
	  <title>&title;</title>
	  <link>&link;</link>
	</image>
	<atom:link href="https://www.FreeBSD.org/news/press-rss.xml" rel="self" type="application/rss+xml" />

        <!-- Only include the last 10 stories -->
        <xsl:apply-templates select="descendant::story[position() &lt;= 10]"/>

      </channel>
      </rss>
  </xsl:template>

  <!-- Generate the <item> elements and their content -->
  <xsl:template match="story">
    <xsl:param name="year" select="../../name" />
    <xsl:param name="month" select="../name" />
    <xsl:param name="this" select="." />
    <xsl:param name="pos">
      <xsl:for-each select="../story">
	<xsl:if test=". = $this">
	  <xsl:value-of select="position()" />
	</xsl:if>
      </xsl:for-each>
    </xsl:param>

    <xsl:variable name="link">
	<xsl:text>https://www.FreeBSD.org/news/press.html#</xsl:text>
	<xsl:call-template name="html-news-generate-anchor">
	  <xsl:with-param name="label" select="'story'" />
	  <xsl:with-param name="year" select="$year" />
	  <xsl:with-param name="month" select="$month" />
	  <xsl:with-param name="pos" select="$pos" />
	</xsl:call-template>
    </xsl:variable>

    <item>
      <title>
        <xsl:value-of select="name" />
        <xsl:if test="site-name"><xsl:text>, </xsl:text></xsl:if>
        <xsl:value-of select="site-name" />
        <xsl:if test="author"><xsl:text>, </xsl:text></xsl:if>
        <xsl:value-of select="author" />
      </title>

      <description><xsl:value-of select="normalize-space(p)"/></description>

      <link><xsl:value-of select="normalize-space($link)"/></link>
      <guid><xsl:value-of select="normalize-space($link)"/></guid>

      <pubDate>
	<xsl:call-template name="misc-format-date-string">
	    <xsl:with-param name="year" select="$year" />
	    <xsl:with-param name="month" select="$month" />
	    <xsl:with-param name="day" select="number(substring(date,0,3))" />
	    <xsl:with-param name="date-format" select="$param-l10n-date-format-rfc822" />
	</xsl:call-template>
      </pubDate>
    </item>
  </xsl:template>

  <xsl:template match="name | date"/>

</xsl:stylesheet>
