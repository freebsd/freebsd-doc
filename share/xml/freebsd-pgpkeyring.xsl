<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:db="http://docbook.org/ns/docbook"
                version='1.0'>

  <xsl:output method="text"/>

  <xsl:param name="generate.fingerprint.only" select="0"/>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="$generate.fingerprint.only">
	<xsl:for-each select="//db:programlisting[@role='pgpfingerprint']">
	  <xsl:value-of select="."/>
	  <xsl:text>&#xA;</xsl:text>
	</xsl:for-each>
      </xsl:when>

      <xsl:otherwise>
	<xsl:for-each select="//db:programlisting[@role='pgpkey' or @role='pgpfingerprint']">
	  <xsl:value-of select="."/>
	  <xsl:text>&#xA;</xsl:text>
	</xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
