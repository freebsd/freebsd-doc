<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/share/sgml/includes.xsl,v 1.1 2003/11/24 18:26:34 hrs Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="./includes.header.xsl" />
  <xsl:import href="./includes.misc.xsl" />
  <xsl:import href="./includes.release.xsl" />
  <xsl:import href="./transtable-common.xsl" />

  <xsl:variable name="base"   select="'.'" />
  <xsl:variable name="enbase" select="concat ($base, '/..')" />

</xsl:stylesheet>
