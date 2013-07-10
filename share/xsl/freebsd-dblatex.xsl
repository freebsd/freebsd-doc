<?xml version='1.0' encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:str="http://exslt.org/strings"
		extension-element-prefixes="str"
		version='1.0'>

  <!-- $FreeBSD$ -->

  <xsl:param name="latex.encoding">utf8</xsl:param>
  <xsl:param name="latex.hyperparam">linktocpage,colorlinks,linkcolor=blue,citecolor=blue,urlcolor=blue</xsl:param>

  <xsl:template match="filename">
    <xsl:choose>
    <!-- \Url cannot stand in a section heading -->
    <xsl:when test="$filename.as.url='1' and
      not(ancestor::title or ancestor::refentrytitle)">
    <xsl:text>\nolinkurl{</xsl:text><xsl:apply-templates mode="tex.escape"/><xsl:text>}</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="inline.monoseq"/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
 
  <xsl:template match="text()" mode="tex.escape">
    <xsl:variable name="t1" select="str:replace(., '\', '\\')"/>
    <xsl:variable name="t2" select="str:replace($t1, '^', '\^')"/>
    <xsl:variable name="t3" select="str:replace($t2, '~', '\~')"/>
    <xsl:variable name="t4" select="str:replace($t3, '{', '\{')"/>
    <xsl:variable name="t5" select="str:replace($t4, '}', '\}')"/>
    <xsl:variable name="t6" select="str:replace($t5, '%', '\%')"/>
    <xsl:variable name="t7" select="str:replace($t6, '$', '\$')"/>
    <xsl:variable name="t8" select="str:replace($t7, '&amp;', '\&amp;')"/>
    <xsl:variable name="t9" select="str:replace($t8, '#', '\#')"/>
    <xsl:variable name="t10" select="str:replace($t9, '_', '\_')"/>

    <xsl:value-of select="$t10"/>
  </xsl:template>
</xsl:stylesheet>
