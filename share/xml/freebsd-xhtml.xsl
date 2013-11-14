<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                     "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

  <!-- Pull in the base stylesheets -->
  <xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/xhtml/docbook.xsl"/>

  <!-- Pull in common XHTML customizations -->
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/freebsd-xhtml-common.xsl"/>

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/freebsd-xhtml.xsl"/>

  <xsl:output encoding="&doc.html.charset;" />

  <xsl:param name="html.chunk" select="'0'"/>
</xsl:stylesheet>
