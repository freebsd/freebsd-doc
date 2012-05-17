<!-- $FreeBSD: www/en/releases/6.2R/stress.xsl,v 1.2 2007/02/18 09:43:41 hrs Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
exclude-result-prefixes="rdf cvs"
 version="1.0">

<xsl:output 
 method="html"
 indent="no"
 encoding="utf-8"/>

<!-- match first element whether we're using namespaces or not -->

<xsl:template match="/*[1]">
    <xsl:comment>Generated from XSLT</xsl:comment>

    <xsl:choose>
      <xsl:when test="channel/item">
<ul>
  <xsl:for-each select="channel/item">
  <li>
    <xsl:element name="a">
      <xsl:attribute name="href"><xsl:value-of select="*[local-name()='link']"/></xsl:attribute>
      <xsl:value-of select="*[local-name()='title']"/>
    </xsl:element>
  </li>
</xsl:for-each>
</ul>
      </xsl:when>

      <xsl:otherwise>
	<p>Currently none reported.</p>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
