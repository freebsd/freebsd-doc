<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

  <!-- Global customisation -->

  <!-- Redefine variables, and replace templates as necessary here -->
  <xsl:template match="hostid|username|groupname|devicename|maketarget|makevar|command">
    <xsl:call-template name="inline.monoseq"/>
  </xsl:template>

  <xsl:template name="svnweb.link">
    <xsl:param name="repo" select="'base'"/>
    <xsl:param name="rev"/>

    <xsl:value-of select="concat('http://svnweb.freebsd.org/', $repo,
      '?view=revision&amp;revision=', $rev)"/>
  </xsl:template>

  <xsl:param name="toc.section.depth" select="1"/>
  <xsl:param name="section.autolabel" select="1"/>
  <xsl:param name="section.label.includes.component.label" select="1"/>

  <xsl:param name="generate.index" select="0"/>

  <xsl:param name="graphic.default.extension">png</xsl:param>

  <xsl:param name="callout.graphics.number.limit">30</xsl:param>
</xsl:stylesheet>
