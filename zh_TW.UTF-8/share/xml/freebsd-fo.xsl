<?xml version='1.0' encoding='utf-8'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

  <!-- Pull in the CJK-specific stylesheet -->
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/freebsd-fo-cjk.xsl"/>

  <!--
        CHINESE-SPECIFIC PARAMETERS
  -->

  <xsl:param name="local.l10n.xml" select="document('')"/>

  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="zh_tw">
      <l:context name="title-numbered">
	<l:template name="appendix" text="附錄 %n. %t"/>
	<l:template name="article/appendix" text="%n. %t" lang="en"/>
	<l:template name="bridgehead" text="%t"/>
	<l:template name="chapter" text="章 %n. %t"/>
	<l:template name="part" text="部 %n. %t"/>
      </l:context>
      <l:context name="title-numbered">
	<l:template name="appendix" text="附錄 %n. %t"/>
	<l:template name="article/appendix" text="%n. %t" lang="en"/>
	<l:template name="chapter" text="章 %n. %t"/>
	<l:template name="part" text="部 %n. %t"/>
	<l:template name="sect1" text="%n. %t"/>
	<l:template name="sect2" text="%n. %t"/>
	<l:template name="sect3" text="%n. %t"/>
	<l:template name="sect4" text="%n. %t"/>
	<l:template name="sect5" text="%n. %t"/>
	<l:template name="section" text="%n. %t"/>
	<l:template name="simplesect" text="%n. %t"/>
      </l:context>
    </l:l10n>
  </l:i18n>

  <!-- Base fonts -->
  <xsl:param name="body.font.family">Gentium Plus, AR PL Mingti2L Big5</xsl:param>
  <xsl:param name="sans.font.family">Droid Sans, AR PL KaitiM Big5</xsl:param>
  <xsl:param name="title.font.family">Droid Sans, AR PL KaitiM Big5</xsl:param>
  <xsl:param name="Monospace.font.family">Droid Sans Mono, Droid Sans Fallback</xsl:param>

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
