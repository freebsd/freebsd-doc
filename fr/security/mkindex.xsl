<?xml version="1.0"?>

<!-- $FreeBSD: www/fr/security/mkindex.xsl,v 1.1 2003/12/15 15:41:15 stephane Exp $ -->

<!-- 
  The FreeBSD French Documentation Project
  Original revision: 1.4

  Version francaise : Stephane Legrand <stephane@freebsd-fr.org> 
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/fr/security/mkindex.xsl,v 1.1 2003/12/15 15:41:15 stephane Exp $'"/>
  <xsl:variable name="title" select="'untitled'"/>

  <xsl:output type="xml" encoding="iso-8859-1"
              omit-xml-declaration="yes" />

  <xsl:template match="/">
    <xsl:call-template name="html-list-advisories">
       <xsl:with-param name="advisories.xml" select="$advisories.xml" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="html-list-advisories-release-label">
    <xsl:param name="relname" select="'none'" />

    <p>Sortie de <xsl:value-of select="$relname" />.</p>
  </xsl:template>
</xsl:stylesheet>
