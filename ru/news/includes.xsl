<?xml version="1.0" encoding="KOI8-R" ?>

<!-- $FreeBSD$ -->
<!-- The FreeBSD Russian Documentation Project -->
<!-- $FreeBSDru: frdp/www/ru/news/includes.xsl,v 1.1 2001/12/05 19:23:41 phantom Exp $ -->
<!-- Original revision: 1.4 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="newshome">
    <a href="{$base}/news/news.html">News Home</a>
  </xsl:variable>

  <!-- Generate a unique anchor for this event -->
  <xsl:template name="generate-event-anchor">
    <xsl:value-of select="ancestor::year/name"/>
    <xsl:value-of select="ancestor::month/name"/>
    <xsl:value-of select="ancestor::day/name"/>:<xsl:value-of select="count(preceding-sibling::event)"/>
  </xsl:template>

  <!-- Generate a unique anchor for this story -->
  <xsl:template name="generate-story-anchor">
    <xsl:value-of select="ancestor::year/name"/>
    <xsl:value-of select="ancestor::month/name"/>:<xsl:text/>
    <xsl:value-of select="count(following-sibling::story)"/>
  </xsl:template>
</xsl:stylesheet>
