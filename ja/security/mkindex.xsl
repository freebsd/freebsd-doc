<?xml version="1.0" encoding="EUC-JP" ?>

<!-- $FreeBSD$ -->
<!-- Original revision: 1.2 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:variable name="title" select="'untitled'"/>

  <xsl:variable name="ftpbase" select="'ftp://ftp.FreeBSD.org/pub/FreeBSD/CERT/advisories/'" />
  <xsl:variable name="ftpbaseold" select="'ftp://ftp.FreeBSD.org/pub/FreeBSD/CERT/advisories/old/'" />
  <xsl:variable name="ulopen" select="'&lt;ul&gt;'" />
  <xsl:variable name="ulclose" select="'&lt;/ul&gt;'" />

  <xsl:output type="xml" encoding="euc-jp"
              omit-xml-declaration="yes" />

  <xsl:template match="/">
    <xsl:value-of select="$ulopen" disable-output-escaping="yes" />
      <xsl:for-each select="descendant::advisory|descendant::release">
        <xsl:choose>
          <xsl:when test="self::release">
            <xsl:value-of select="$ulclose" disable-output-escaping="yes" />
            <p><xsl:value-of select="name"/> の公開。</p>
            <xsl:value-of select="$ulopen" disable-output-escaping="yes" />
          </xsl:when>
          
          <xsl:when test="self::advisory">
            <li>
            <xsl:choose>
              <xsl:when test="./name/@role='old'">
                <a><xsl:attribute name="href"><xsl:value-of select="concat($ftpbaseold, name, '.asc')" /></xsl:attribute><xsl:value-of select="concat(name, '.asc')" /></a>
              </xsl:when>
              <xsl:otherwise>
                 <a><xsl:attribute name="href"><xsl:value-of select="concat($ftpbase, name, '.asc')" /></xsl:attribute><xsl:value-of select="concat(name, '.asc')" /></a>             </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="./ulink/@lang='ja'">
               <a><xsl:attribute name="href"><xsl:value-of select="ulink" /></xsl:attribute>(日本語訳)</a>
            </xsl:if>
            </li>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
    <xsl:value-of select="$ulclose" disable-output-escaping="yes" />
  </xsl:template>
</xsl:stylesheet>
