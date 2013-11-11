<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
		xmlns:str="http://exslt.org/strings"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db"
		extension-element-prefixes="str">
  <!--
	BENGALI-SPECIFIC PARAMETERS
  -->

  <!-- Base fonts -->
  <xsl:param name="body.font.family">Lohit Bengali</xsl:param>
  <xsl:param name="sans.font.family">Lohit Bengali, Andika</xsl:param>
  <xsl:param name="title.font.family">Lohit Bengali</xsl:param>
  <xsl:param name="monospace.font.family">DejaVu Sans Mono</xsl:param>

  <xsl:attribute-set name="intermixed.english.attributes">
    <xsl:attribute name="font-family">Gentium Plus</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="*" mode="intermixed.english">
    <xsl:apply-templates select="."/>
  </xsl:template>

  <xsl:template match="text()" mode="intermixed.english">
    <xsl:for-each select="str:split(., ' ')">
      <xsl:choose>
	<xsl:when test="contains('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/(', substring(., 1, 1))">
	  <fo:inline xsl:use-attribute-sets="intermixed.english.attributes">
	    <xsl:value-of select="."/>
	    <xsl:text> </xsl:text>
	  </fo:inline>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="."/>
	  <xsl:text> </xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

<xsl:template match="db:para">
  <xsl:variable name="keep.together">
    <xsl:call-template name="pi.dbfo_keep-together"/>
  </xsl:variable>
  <fo:block xsl:use-attribute-sets="para.properties">
    <xsl:if test="$keep.together != ''">
      <xsl:attribute name="keep-together.within-column"><xsl:value-of
                      select="$keep.together"/></xsl:attribute>
    </xsl:if>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates mode="intermixed.english"/>
  </fo:block>
</xsl:template>

<xsl:template match="db:simpara">
  <xsl:variable name="keep.together">
    <xsl:call-template name="pi.dbfo_keep-together"/>
  </xsl:variable>
  <fo:block xsl:use-attribute-sets="normal.para.spacing">
    <xsl:if test="$keep.together != ''">
      <xsl:attribute name="keep-together.within-column"><xsl:value-of
                      select="$keep.together"/></xsl:attribute>
    </xsl:if>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates mode="intermixed.english"/>
  </fo:block>
</xsl:template>

</xsl:stylesheet>
