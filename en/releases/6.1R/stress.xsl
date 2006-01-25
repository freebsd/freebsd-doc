<!-- $FreeBSD: www/en/releases/6.0R/stress.xsl,v 1.1 2005/07/18 20:42:13 murray Exp $ -->

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

</xsl:template>

</xsl:stylesheet>
