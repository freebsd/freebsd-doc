<?xml version="1.0" encoding="koi8-r" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/www/ru/gnome/includes.xsl,v 1.2 2004/01/04 09:20:40 andy Exp $

     Original revision: 1.6
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="newshome">
    <a href="{$base}/ru/news/news.html">Главная страница новостей FreeBSD</a>
  </xsl:variable>

  <xsl:variable name="gnomever">
    2.4
  </xsl:variable>

  <xsl:variable name="gnomedevelver">
       2.5
  </xsl:variable>

  <xsl:variable name="author">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="concat($base, '/ru/gnome/contact.html')"/>
      </xsl:attribute>
      <xsl:value-of select="'freebsd-gnome'"/>@FreeBSD.org</a><br/><xsl:copy-of select="$copyright"/>
  </xsl:variable>

  <!-- Generate a unique anchor for this event -->
  <xsl:template name="generate-event-anchor">
    <xsl:text>event</xsl:text>
    <xsl:value-of select="ancestor::year/name"/>
    <xsl:value-of select="ancestor::month/name"/>
    <xsl:value-of select="ancestor::day/name"/>:<xsl:value-of select="count(preceding-sibling::event)"/>
  </xsl:template>

</xsl:stylesheet>
