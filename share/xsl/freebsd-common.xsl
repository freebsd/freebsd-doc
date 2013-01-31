<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

  <!-- Global customisation -->

  <!-- Redefine variables, and replace templates as necessary here -->
  <xsl:template match="hostid|username|groupname|devicename|maketarget|makevar">
    <xsl:call-template name="inline.monoseq"/>
  </xsl:template>

  <xsl:template match="pubdate"/>

  <xsl:param name="toc.section.depth" select="1"/>
  <xsl:param name="section.autolabel" select="1"/>
  <xsl:param name="section.label.includes.component.label" select="1"/>

</xsl:stylesheet>
