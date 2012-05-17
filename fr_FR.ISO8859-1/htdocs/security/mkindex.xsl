<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base ".">
<!ENTITY title "">
]>

<!-- $FreeBSD: www/fr/security/mkindex.xsl,v 1.2 2006/04/03 19:58:44 blackend Exp $ -->

<!-- 
  The FreeBSD French Documentation Project
  Original revision: 1.4

  Version francaise : Stephane Legrand <stephane@freebsd-fr.org> 
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD: www/fr/security/mkindex.xsl,v 1.2 2006/04/03 19:58:44 blackend Exp $'"/>

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
