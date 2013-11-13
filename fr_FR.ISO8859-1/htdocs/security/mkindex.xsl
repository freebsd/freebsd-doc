<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">

<!-- $FreeBSD$ -->

<!--
  The FreeBSD French Documentation Project
  Original revision: 1.4

  Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>

  <xsl:variable name="svnKeyword" select="'$FreeBSD$'"/>

  <xsl:output type="xml" encoding="iso-8859-1"
              omit-xml-declaration="yes" />

  <xsl:template match="/">
    <xsl:call-template name="html-list-advisories">
       <xsl:with-param name="advisories.xml" select="$advisories.xml" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="html-list-advisories-release-label">
    <xsl:param name="relname" select="'none'" />

    <p>Sortie de <xsl:value-of select="$relname" />.</p>
  </xsl:template>
</xsl:stylesheet>
