<?xml version="1.0" encoding="EUC-JP" ?>

<!-- $FreeBSD$ -->
<!-- Original revision: 1.1 -->

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
