<?xml version="1.0" encoding="iso-8859-1"?>
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output type="xml" encoding="iso-8859-1"
	      indent="yes"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="transtable.xml" select="'./transtable.xml'" />
  <xsl:param name="transtable-conv-element" select="''" />

  <xsl:key name="transtable-lookup-key" match="word" use="orig" />

  <xsl:template name="transtable-lookup">
    <xsl:param name="word" select="''"/>

    <xsl:for-each select="document($transtable.xml)">
      <xsl:choose>
        <xsl:when test="key('transtable-lookup-key', $word)">
          <xsl:for-each select="key('transtable-lookup-key', $word)">
	    <xsl:value-of select="tran" />
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
	  <xsl:value-of select="$word" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[local-name() = $transtable-conv-element]">
    <xsl:element name="{local-name(.)}" namespace="{namespace-uri(.)}">
      <xsl:copy-of select="@*" />

      <xsl:call-template name="transtable-lookup">
        <xsl:with-param name="word" select="." />
      </xsl:call-template>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
