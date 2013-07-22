<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

  <!-- Pull in the language-independent stylesheet -->
  <xsl:import href="http://www.FreeBSD.org/XML/doc/share/xsl/freebsd-fo.xsl"/>

  <!-- Language-specific general customizations -->
  <xsl:import href="freebsd-common.xsl"/>

  <!--
        CHINESE-SPECIFIC PARAMETERS
  -->

  <!-- Base fonts -->
  <xsl:param name="body.font.family">AR PL SungtiL GB</xsl:param>
  <xsl:param name="sans.font.family">AR PL KaitiM GB</xsl:param>
  <xsl:param name="title.font.family">AR PL KaitiM GB</xsl:param>

  <!-- Slightly reduce header font-size to make headers fit -->
  <xsl:attribute-set name="header.content.properties">
  <xsl:attribute name="font-size">8pt</xsl:attribute>
  <xsl:attribute name="font-family">
  <xsl:value-of select="$body.fontset"></xsl:value-of>
  </xsl:attribute>
  <xsl:attribute name="margin-left">
  <xsl:value-of select="$title.margin.left"></xsl:value-of>
  </xsl:attribute>
  </xsl:attribute-set>

  <!-- Increase inline monospace fonts to better fit the Chinese font-size -->
  <xsl:attribute-set name="monospace.properties">
  <xsl:attribute name="font-family">
  <xsl:value-of select="$monospace.font.family"></xsl:value-of>
  </xsl:attribute>
  <xsl:attribute name="font-size">10pt</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
