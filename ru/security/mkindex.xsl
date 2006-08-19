<?xml version="1.0" encoding="koi8-r"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base ".">
<!ENTITY title "">
]>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD: www/ru/security/mkindex.xsl,v 1.2 2004/01/26 07:23:31 andy Exp $
     $FreeBSDru: frdp/www/ru/security/mkindex.xsl,v 1.4 2004/01/25 15:22:12 andy Exp $

     Original revision: 1.4
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD: www/ru/security/mkindex.xsl,v 1.2 2004/01/26 07:23:31 andy Exp $'"/>

  <xsl:output type="xml" encoding="KOI8-R"
              omit-xml-declaration="yes" />

  <xsl:template match="/">
    <xsl:call-template name="html-list-advisories">
       <xsl:with-param name="advisories.xml" select="$advisories.xml" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="html-list-advisories-release-label">
    <xsl:param name="relname" select="'none'" />

    <p>Выпущена <xsl:value-of select="$relname" />.</p>
  </xsl:template>
</xsl:stylesheet>
