<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Multimedia">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:set="http://exslt.org/sets"
	xmlns="http://www.w3.org/1999/xhtml"
	extension-element-prefixes="set">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>
  <xsl:import href="include.xsl"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.sidewrap">&nav.about;</xsl:template>

  <xsl:template name="process.contentwrap">
    <xsl:param name="nodes" select="//tag"/>

    <xsl:call-template name="multimedia.pre"/>

    <h1>Tag Cloud</h1>

    <xsl:for-each select="set:distinct(//tag)">
      <xsl:sort select="."/>

      <xsl:variable name="tagName" select="./text()"/>

      <a>
        <xsl:attribute name="style">
          <xsl:text>font-size:</xsl:text>
          <xsl:value-of select="count(//tag[. = $tagName]) div 3 + 6"/>
          <xsl:text>pt;</xsl:text>
        </xsl:attribute>

        <xsl:attribute name="href">
          <xsl:value-of select="concat('#', translate($tagName, ' ', '_'))"/>
        </xsl:attribute>

        <xsl:value-of select="translate($tagName, ' ', '&nbsp;')"/>
      </a>
    </xsl:for-each>

    <br/>

    <h1 style="margin-top: 32pt">Multimedia Resources</h1>

    <xsl:for-each select="set:distinct(//tag)">
      <xsl:sort select="."/>

      <xsl:variable name="tagName" select="./text()"/>

      <h2 id="{translate($tagName, ' ', '_')}"><xsl:value-of select="."/></h2>

      <ul>
	<xsl:apply-templates select="/multimedia/items/item[tags/tag = $tagName]"/>
      </ul>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
