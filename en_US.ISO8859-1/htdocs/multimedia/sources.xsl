<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Multimedia">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>
  <xsl:import href="include.xsl"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.sidewrap">&nav.about;</xsl:template>

  <xsl:template name="process.contentwrap">
    <xsl:call-template name="multimedia.pre"/>

    <h1>Source List</h1>

    <ul>
      <xsl:for-each select="//source">
	<xsl:sort select="name"/>

	<li>
	  <a>
	    <xsl:attribute name="href">
	      <xsl:value-of select="concat('#', @id)"/>
	    </xsl:attribute>

	    <xsl:value-of select="name"/>
          </a>
	</li>
      </xsl:for-each>
    </ul>

    <h1>Multimedia Resources</h1>

    <xsl:for-each select="//source">
      <xsl:sort select="name"/>

      <xsl:variable name="sourceId" select="@id"/>

      <h2 id="{@id}"><xsl:value-of select="name"/></h2>

      <ul>
	<xsl:apply-templates select="/multimedia/items/item[@source = $sourceId]"/>
      </ul>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
