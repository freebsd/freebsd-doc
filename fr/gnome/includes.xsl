<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD$ -->

<!-- 
  The FreeBSD French Documentation Project
  Original revision: 1.2

  Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="newshome">
    <a href="{$base}/news/news.html">Accueil Nouvelles FreeBSD</a>
  </xsl:variable>

  <xsl:variable name="author">                                                  
    <a>                                                                         
      <xsl:attribute name="href">                                               
        <xsl:value-of select="concat($base, '/gnome/contact.html')"/>           
      </xsl:attribute>                                                          
      <xsl:value-of select="'freebsd-gnome'"/>@FreeBSD.org</a><br/><xsl:value-of select="$copyright"/>
  </xsl:variable>

  <!-- Generate a unique anchor for this event -->
  <xsl:template name="generate-event-anchor">
    <xsl:value-of select="ancestor::year/name"/>
    <xsl:value-of select="ancestor::month/name"/>
    <xsl:value-of select="ancestor::day/name"/>:<xsl:value-of select="count(preceding-sibling::event)"/>
  </xsl:template>

</xsl:stylesheet>
