<?xml version="1.0"?>
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output type="xml" encoding="euc-jp"
	      omit-xml-declaration="yes"
	      indent="yes"/>

  <xsl:param name="transtable" select="'./transtable.xml'" />

  <xsl:key name="transname" match="word" use="name" />

  <xsl:template name="transtable">
    <xsl:param name="name" value="'Japan'"/>
    <xsl:for-each select="document($transtable)">
      <xsl:choose>
        <xsl:when test="key('transname', $name)">
          <xsl:for-each select="key('transname', $name)">
             <xsl:value-of select="name[@lang='ja']" />
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
           <xsl:value-of select="$name" />
        </xsl:otherwise>
      </xsl:choose>         
    </xsl:for-each>
  </xsl:template>

<!-- for debug
  <xsl:template match="/">
    <xsl:call-template name="transtable">
      <xsl:with-param name="name" select="'United Kingdom'" /> 
    </xsl:call-template>
  </xsl:template>
-->

</xsl:stylesheet>
