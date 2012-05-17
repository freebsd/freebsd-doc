<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base ".">
<!ENTITY title "">
]>
<!-- $FreeBSD$ -->

<!-- The FreeBSD Hungarian Documentation Project
     Translated by: PALI, Gabor <pgj@FreeBSD.org>
     %SOURCE%	en/security/security-rdf.xsl
     %SRCID%	1.2
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <xsl:call-template name="rdf-security-advisories">
       <xsl:with-param name="advisories.xml" select="$advisories.xml" />
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
