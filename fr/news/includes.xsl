<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/fr/news/includes.xsl,v 1.1 2002/12/08 16:45:35 stephane Exp $ -->

<!-- 
   The FreeBSD French Documentation Project
   Original revision: 1.6
   
   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
   Version francaise (mise a jour) : Mathieu Arnold <mat@FreeBSD.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="newshome">
    <a href="{$base}/news/news.html">Accueil Nouvelles</a>
  </xsl:variable>

  <xsl:variable name="presshome">
    <a href="{$base}/news/press.html">Accueil Presse</a>
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
