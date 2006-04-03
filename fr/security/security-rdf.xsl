<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD$ -->
<!-- 
  The FreeBSD French Documentation Project
  Original revision: 1.1
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:variable name="title" select="'untitled'"/>

  <xsl:template match="/">
    <xsl:call-template name="rdf-security-advisories">
       <xsl:with-param name="advisories.xml" select="$advisories.xml" />
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
