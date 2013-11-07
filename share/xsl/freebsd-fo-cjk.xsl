<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db"
                version="1.0">

  <!--
	This file holds customizations that commonly
	apply to CJK languages.
  -->

  <!-- Use bold instead of italic since CJK languages do not
       have italic glyphs -->
  <xsl:template name="inline.italicseq">
    <xsl:param name="content">
      <xsl:call-template name="simple.xlink">
        <xsl:with-param name="content">
          <xsl:apply-templates/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:param>

    <fo:inline font-weight="bold">
      <xsl:call-template name="anchor"/>
      <xsl:if test="@dir">
        <xsl:attribute name="direction">
          <xsl:choose>
            <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
            <xsl:otherwise>rtl</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
      <xsl:copy-of select="$content"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="*" mode="insert.olink.docname.markup">
    <xsl:param name="docname" select="''"/>

    <fo:inline font-weight="bold">
      <xsl:value-of select="$docname"/>
    </fo:inline>
  </xsl:template>

  <xsl:template name="title.xref">
    <xsl:param name="target" select="."/>
    <xsl:choose>
      <xsl:when test="local-name($target) = 'figure'
                    or local-name($target) = 'example'
                    or local-name($target) = 'equation'
                    or local-name($target) = 'table'
                    or local-name($target) = 'dedication'
                    or local-name($target) = 'acknowledgements'
                    or local-name($target) = 'preface'
                    or local-name($target) = 'bibliography'
                    or local-name($target) = 'glossary'
                    or local-name($target) = 'index'
                    or local-name($target) = 'setindex'
                    or local-name($target) = 'colophon'">
        <xsl:call-template name="gentext.startquote"/>
        <xsl:apply-templates select="$target" mode="title.markup"/>
        <xsl:call-template name="gentext.endquote"/>
      </xsl:when>
      <xsl:otherwise>
        <fo:inline font-weight="bold">
          <xsl:apply-templates select="$target" mode="title.markup"/>
        </fo:inline>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:chapter|db:appendix" mode="insert.title.markup">
    <xsl:param name="purpose"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="title"/>

    <xsl:choose>
      <xsl:when test="$purpose = 'xref'">
        <fo:inline font-weight="bold">
          <xsl:copy-of select="$title"/>
        </fo:inline>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="$title"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
