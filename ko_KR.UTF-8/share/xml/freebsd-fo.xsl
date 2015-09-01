<?xml version='1.0'?>

<!--
     The FreeBSD Korean Documentation Project

     $FreeBSD$
     Original revision: r47317
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

  <!-- Pull in the CJK-specific stylesheet -->
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/freebsd-fo-cjk.xsl"/>

  <!--
	Korean-SPECIFIC PARAMETERS
  -->

  <!-- Base fonts -->
  <xsl:param name="body.font.family">NanumMyeongjo, Gentium Plus</xsl:param>
  <xsl:param name="sans.font.family">NanumGothic, Droid Sans</xsl:param>
  <xsl:param name="title.font.family">NanumGothic, Droid Sans</xsl:param>

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

  <!-- Increase inline monospace fonts to better fit the Korean font-size -->
  <xsl:attribute-set name="monospace.properties">
  <xsl:attribute name="font-family">
  <xsl:value-of select="$monospace.font.family"></xsl:value-of>
  </xsl:attribute>
  <xsl:attribute name="font-size">10pt</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
