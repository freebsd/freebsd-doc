<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/share/sgml/includes.release.xsl,v 1.1 2003/11/24 18:26:34 hrs Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="rel.current" select='"5.2"'/>

  <xsl:variable name="u.rel.notes">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel.announce">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel.errata">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel.hardware">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel.early">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/early-adopter.html</xsl:variable>

  <xsl:variable name="rel2.current" select='"4.9"'/>
  <xsl:variable name="u.rel2.notes">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel2.announce">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel2.errata">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel2.hardware">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/hardware.html</xsl:variable>

</xsl:stylesheet>
