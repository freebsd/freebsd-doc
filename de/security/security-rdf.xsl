<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD$
     $FreeBSDde: de-www/security/security-rdf.xsl,v 1.1 2004/07/04 13:37:38 brueffer Exp $
     basiert auf: 1.1
-->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:variable name="dedate" select="'$FreeBSDde: de-www/security/security-rdf.xsl,v 1.1 2004/07/04 13:37:38 brueffer Exp $'"/>
  <xsl:variable name="title" select="'untitled'"/>

  <xsl:template match="/">
    <xsl:call-template name="rdf-security-advisories">
       <xsl:with-param name="advisories.xml" select="$advisories.xml" />
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
