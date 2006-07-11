<?xml version="1.0" encoding="gb2312" ?>

<!-- $FreeBSD: www/zh_CN/security/mkindex.xsl,v 1.1.1002.1 2005/12/18 08:09:14 delphij Exp $ -->
<!-- Original Revision: 1.4 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="enbase" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/zh_CN/security/mkindex.xsl,v 1.1.1002.1 2005/12/18 08:09:14 delphij Exp $'"/>
  <xsl:variable name="title" select="'untitled'"/>

  <xsl:output type="xml" encoding="gb2312"
              omit-xml-declaration="yes" />

  <xsl:template match="/">
    <xsl:call-template name="html-list-advisories">
       <xsl:with-param name="advisories.xml" select="$advisories.xml" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="html-list-advisories-release-label">
    <xsl:param name="relname" select="'none'" />

    <p><xsl:value-of select="$relname" /> 发布了。</p>
  </xsl:template>
</xsl:stylesheet>
