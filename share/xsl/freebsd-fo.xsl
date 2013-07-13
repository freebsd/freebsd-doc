<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db"
                version="1.0">

  <!-- Pull in the base stylesheets -->
  <xsl:import href="/usr/local/share/xsl/docbook-ns/fo/docbook.xsl"/>

  <!-- Include the common customizations -->
  <xsl:include href="freebsd-common.xsl"/>

  <!-- Redefine variables, and replace templates as necessary here -->

  <!-- FO specific customisation goes here -->

<!--
  <xsl:param name="use.extensions" select="1"/>
  <xsl:param name="fop1.extensions" select="1"/>
-->

  <xsl:param name="hyphenate">false</xsl:param>
<!--
  <xsl:param name="hyphenate.verbatim" select="1"/>
-->
  <xsl:param name="header.column.widths">1 5 1</xsl:param>

  <xsl:param name="callout.graphics.path">imagelib/callouts/</xsl:param>
  <xsl:param name="callout.graphics.extension">.png</xsl:param>
  <xsl:param name="default.image.width">400</xsl:param>


<xsl:template match="pubdate" mode="article.titlepage.recto.auto.mode"/>

<xsl:attribute-set name="abstract.title.properties">
  <xsl:attribute name="font-size">
    <xsl:value-of select="$body.font.master * 2.0736"></xsl:value-of>
    <xsl:text>pt</xsl:text>
  </xsl:attribute>
  <xsl:attribute name="text-align">left</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="abstract.properties">
  <xsl:attribute name="margin-left">0</xsl:attribute>
  <xsl:attribute name="margin-right">0</xsl:attribute>
  <xsl:attribute name="padding-left">0</xsl:attribute>
  <xsl:attribute name="padding-right">0</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="toc.margin.properties">
  <xsl:attribute name="margin-left">
    <xsl:value-of select="'0'"/>
  </xsl:attribute>
  <xsl:attribute name="margin-right">
    <xsl:value-of select="'0'"/>
  </xsl:attribute>
  <xsl:attribute name="padding-left">
    <xsl:value-of select="'0'"/>
  </xsl:attribute>
  <xsl:attribute name="padding-right">
    <xsl:value-of select="'0'"/>
  </xsl:attribute>
</xsl:attribute-set>

<!--
<xsl:template match="legalnotice" mode="article.titlepage.recto.auto.mode">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" text-align="start" font-family="{$body.fontset}">
    <xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
  </fo:block>
</xsl:template>
-->

<xsl:template match="db:abstract" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" space-before="0.5em" text-align="start" margin-left="0.5in" margin-right="0.5in" font-family="{$body.fontset}">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

</xsl:stylesheet>

