<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

  <!-- Pull in the language-independent stylesheet -->
  <xsl:import href="http://www.FreeBSD.org/XML/doc/share/xsl/freebsd-xhtml.xsl"/>

  <!-- Language-specific general customizations -->
  <xsl:import href="freebsd-common.xsl"/>

  <!-- Language-specific common XHTML customizations -->
  <xsl:import href="freebsd-xhtml-common.xsl"/>
</xsl:stylesheet>
