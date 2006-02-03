<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/fr/gnome/includes.xsl,v 1.2 2006/01/09 19:54:30 blackend Exp $ -->

<!-- 
  The FreeBSD French Documentation Project
  Original revision: 1.12

  Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="newshome">
    <a href="{$base}/news/news.html">Accueil Nouvelles FreeBSD</a>
  </xsl:variable>

  <xsl:variable name="gnomever">
    2.12
  </xsl:variable>

  <xsl:variable name="gnomedevelver">
	2.13
  </xsl:variable>

  <!-- Generate a unique anchor for this event -->
  <xsl:template name="generate-event-anchor">
    <xsl:text>event</xsl:text>
    <xsl:value-of select="ancestor::year/name"/>
    <xsl:value-of select="ancestor::month/name"/>
    <xsl:value-of select="ancestor::day/name"/>:<xsl:value-of select="count(preceding-sibling::event)"/>
  </xsl:template>

</xsl:stylesheet>
