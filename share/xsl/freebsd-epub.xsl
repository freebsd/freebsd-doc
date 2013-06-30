<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

  <!-- Pull in the base stylesheets -->
  <xsl:import href="/usr/local/share/xsl/docbook/epub/docbook.xsl"/>

  <!-- Pull in common XHTML customizations -->
  <xsl:include href="freebsd-xhtml-common.xsl"/>

  <xsl:param name="generate.legalnotice.link" select="'1'"/>
</xsl:stylesheet>

