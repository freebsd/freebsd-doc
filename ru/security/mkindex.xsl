<?xml version="1.0" encoding="KOI8-R" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/www/ru/security/mkindex.xsl,v 1.4 2004/01/25 15:22:12 andy Exp $

     Original revision: 1.4
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:variable name="title" select="'untitled'"/>

  <xsl:output type="xml" encoding="KOI8-R"
              omit-xml-declaration="yes" />

  <xsl:template match="/">
    <xsl:call-template name="html-list-advisories">
       <xsl:with-param name="advisories.xml" select="$advisories.xml" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="html-list-advisories-release-label">
    <xsl:param name="relname" select="'none'" />

    <p>Выпущена <xsl:value-of select="$relname" />.</p>
  </xsl:template>
</xsl:stylesheet>
