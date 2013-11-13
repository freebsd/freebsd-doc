<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Multimedia">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns="http://www.w3.org/1999/xhtml"
	extension-element-prefixes="date">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>
  <xsl:import href="include.xsl"/>

  <xsl:key name="date" match="item" use="substring(@added, 1, 6)" />

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.sidewrap">&nav.about;</xsl:template>

  <xsl:template name="process.contentwrap">
    <xsl:call-template name="multimedia.pre"/>

    <h1>Newest Resources</h1>

    <xsl:for-each select="//item[count(. | key('date', substring(@added, 1, 6))[1]) = 1]">
      <xsl:sort select="@added" order="descending"/>

      <h2>
	<xsl:value-of select="date:month-name(concat('--', substring(@added, 5, 2), '--'))"/>
	<xsl:text> </xsl:text>
	<xsl:value-of select="substring(@added, 1, 4)"/>
      </h2>

      <ul>
	<xsl:for-each select="key('date', substring(@added, 1, 6))">
	  <xsl:sort select="@added" order="descending"/>

	  <xsl:apply-templates select="."/>
	</xsl:for-each>
      </ul>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
