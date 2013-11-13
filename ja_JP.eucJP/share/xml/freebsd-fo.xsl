<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

  <!-- Pull in the CJK-specific stylesheet -->
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/freebsd-fo-cjk.xsl"/>

  <!--
	JAPANESE-SPECIFIC PARAMETERS
  -->

  <xsl:param name="local.l10n.xml" select="document('')"/>

  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="ja">
      <l:context name="styles">
	<l:template name="person-name" text="first-last"/>
      </l:context>
    </l:l10n>
  </l:i18n>

  <!-- Base fonts -->
  <xsl:param name="body.font.family">IPAPMincho, Gentium Plus</xsl:param>
  <xsl:param name="sans.font.family">IPAPGothic, Droid Sans</xsl:param>
  <xsl:param name="title.font.family">IPAPGothic, Droid Sans</xsl:param>

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

  <!-- Increase inline monospace fonts to better fit the Japanese font-size -->
  <xsl:attribute-set name="monospace.properties">
  <xsl:attribute name="font-family">
  <xsl:value-of select="$monospace.font.family"></xsl:value-of>
  </xsl:attribute>
  <xsl:attribute name="font-size">10pt</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
