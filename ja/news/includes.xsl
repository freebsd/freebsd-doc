<?xml version="1.0" encoding="EUC-JP" ?>

<!-- $FreeBSD: www/ja/news/includes.xsl,v 1.1 2001/08/07 03:58:32 kuriyama Exp $ -->
<!-- Original revision: 1.2 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="newshome">
    <a href="news.html">News ホーム</a>
  </xsl:variable>

  <!-- Generate a unique anchor for this event -->
  <xsl:template name="generate-event-anchor">
	  <xsl:value-of select="ancestor::year/name"/>
	  <xsl:value-of select="ancestor::month/name"/>
	  <xsl:value-of select="ancestor::day/name"/>:<xsl:value-of select="count(preceding-sibling::event)"/>
  </xsl:template>
  
</xsl:stylesheet>
