<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:db="http://docbook.org/ns/docbook"
                version='1.0'>

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:for-each select="//db:programlisting[@role='pgpkey']">
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
