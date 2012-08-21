<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns="http://www.w3.org/1999/xhtml"
exclude-result-prefixes="rdf"
 version="1.0">

<xsl:output
 method="html"
 indent="no"
 encoding="utf-8"/>

<!-- match first element whether we're using namespaces or not -->

<xsl:template match="/*[1]">
    <xsl:comment>Generated from XSLT</xsl:comment>

    <xsl:choose>
      <xsl:when test="*[local-name()='item']">
<ul>
  <xsl:for-each select="*[local-name()='item']">
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
