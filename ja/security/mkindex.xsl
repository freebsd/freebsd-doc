<?xml version="1.0" encoding="EUC-JP" ?>

<!-- $FreeBSD: www/ja/security/mkindex.xsl,v 1.1 2003/10/11 07:12:37 hrs Exp $ -->
<!-- Original revision: 1.4 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/ja/security/mkindex.xsl,v 1.1 2003/10/11 07:12:37 hrs Exp $'"/>
  <xsl:variable name="title" select="'untitled'"/>

  <xsl:output type="xml" encoding="euc-jp"
              omit-xml-declaration="yes" />

  <xsl:template match="/">
    <xsl:call-template name="html-list-advisories">
       <xsl:with-param name="advisories.xml" select="$advisories.xml" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="html-list-advisories-release-label">
    <xsl:param name="relname" select="'none'" />

    <p><xsl:value-of select="$relname" /> の公開。</p>
  </xsl:template>
</xsl:stylesheet>
