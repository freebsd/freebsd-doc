<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:variable name="title" select="'untitled'"/>

  <xsl:variable name="ftpbase" select="'ftp://ftp.FreeBSD.org/pub/FreeBSD/CERT/advisories/'" />
  <xsl:variable name="ulopen" select="'&lt;ul&gt;'" />
  <xsl:variable name="ulclose" select="'&lt;/ul&gt;'" />

  <xsl:output type="xml" encoding="iso-8859-1"
              omit-xml-declaration="yes" />

  <xsl:template match="/">
    <xsl:value-of select="$ulopen" disable-output-escaping="yes" />
      <xsl:for-each select="descendant::advisory|descendant::release">
        <xsl:choose>
          <xsl:when test="self::release">
            <xsl:value-of select="$ulclose" disable-output-escaping="yes" />
            <p><xsl:value-of select="name"/> released.</p>
            <xsl:value-of select="$ulopen" disable-output-escaping="yes" />
          </xsl:when>
          
          <xsl:when test="self::advisory">
            <li><a><xsl:attribute name="href"><xsl:value-of select="concat($ftpbase, name, '.asc')" /></xsl:attribute><xsl:value-of select="concat(name, '.asc')" /></a></li>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
    <xsl:value-of select="$ulclose" disable-output-escaping="yes" />
  </xsl:template>
</xsl:stylesheet>
