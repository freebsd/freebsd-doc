<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="./includes.header.xsl" />
  <xsl:import href="./includes.misc.xsl" />
  <xsl:import href="./includes.release.xsl" />

  <xsl:variable name="base"   select="'.'" />
  <xsl:variable name="enbase" select="concat ($base, '/..')" />

</xsl:stylesheet>
