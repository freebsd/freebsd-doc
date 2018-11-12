<?xml version="1.0" encoding="iso-8859-1"?>
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="transtable.xml" select="'./transtable.xml'" />
  <xsl:param name="transtable-sortkey.xml" select="'./transtable-sortkey.xml'" />

  <xsl:key name="transtable-lookup-key" match="word" use="orig" />
  <xsl:key name="transtable-lookup-group" match="group/word" use="../@id" />
  <xsl:key name="transtable-sortkey-lookup-key" match="word" use="@orig" />

  <xsl:template name="transtable-lookup">
    <xsl:param name="word" select="''"/>
    <xsl:param name="word-group" select="''"/>

    <xsl:for-each select="document($transtable.xml)">
      <xsl:choose>
	<!-- $p[count(.|$q) = count($q)] means product set of $p and $q-->
	<xsl:when test="
	  key('transtable-lookup-group', string($word-group))
	  [count(.|key('transtable-lookup-key', string($word)))
	  = count(key('transtable-lookup-key', string($word)))]
	  ">
	  <xsl:value-of select="
	    key('transtable-lookup-group', string($word-group))
	    [count(.|key('transtable-lookup-key', string($word)))
	    = count(key('transtable-lookup-key', string($word)))]/tran" />
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="$word" />
	</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="transtable-sortkey-lookup">
    <xsl:param name="word" select="''"/>

    <xsl:for-each select="document($transtable-sortkey.xml)/sortkeys">
      <xsl:for-each select="key('transtable-sortkey-lookup-key', string($word))">
	<xsl:attribute name="sortkey">
	  <xsl:value-of select="@sortkey" />
	</xsl:attribute>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
