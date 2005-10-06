<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/share/sgml/includes.xsl,v 1.2 2004/01/12 21:27:00 hrs Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="./includes.header.xsl" />
  <xsl:import href="./includes.misc.xsl" />
  <xsl:import href="./includes.release.xsl" />
  <xsl:import href="./transtable-common.xsl" />

  <xsl:variable name="base"   select="'.'" />
  <xsl:variable name="cgibase"   select="'http://www.FreeBSD.org/cgi'" />
  <xsl:variable name="enbase" select="concat ($base, '/..')" />

</xsl:stylesheet>
