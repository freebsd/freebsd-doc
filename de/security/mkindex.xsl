<?xml version="1.0"?>

<!--
	$FreeBSD: www/de/security/mkindex.xsl,v 1.1 2004/01/11 00:32:03 mheinen Exp $
	$FreeBSDde: de-www/security/mkindex.xsl,v 1.2 2004/01/25 03:50:13 brueffer Exp $
	basiert auf: 1.4
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/de/security/mkindex.xsl,v 1.1 2004/01/11 00:32:03 mheinen Exp $'"/>
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

    <p><xsl:value-of select="$relname" /> released.</p>
  </xsl:template>
</xsl:stylesheet>
