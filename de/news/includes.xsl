<?xml version="1.0" encoding="ISO-8859-1" ?>

<!--
     $FreeBSD: www/de/news/includes.xsl,v 1.2 2003/08/26 16:08:17 mheinen Exp $
     $FreeBSDde: de-www/news/includes.xsl,v 1.4 2004/05/03 23:53:16 brueffer Exp $
     basiert auf: 1.6
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="newshome">
    <a href="{$base}/news/news.html">FreeBSD Neuigkeiten</a>
  </xsl:variable>

  <xsl:variable name="presshome">
    <a href="{$base}/news/press.html">FreeBSD Pressemeldungen</a>
  </xsl:variable>

  <!-- Generate a unique anchor for this event -->
  <xsl:template name="generate-event-anchor">
    <xsl:text>event</xsl:text>
    <xsl:value-of select="ancestor::year/name"/>
    <xsl:value-of select="ancestor::month/name"/>
    <xsl:value-of select="ancestor::day/name"/>:<xsl:value-of select="count(preceding-sibling::event)"/>
  </xsl:template>

  <!-- Generate a unique anchor for this story -->
  <xsl:template name="generate-story-anchor">
    <xsl:text>story</xsl:text>
    <xsl:value-of select="ancestor::year/name"/>
    <xsl:value-of select="ancestor::month/name"/>:<xsl:text/>
    <xsl:value-of select="count(following-sibling::story)"/>
  </xsl:template>
</xsl:stylesheet>
