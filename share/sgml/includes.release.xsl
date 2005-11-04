<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/share/sgml/includes.release.xsl,v 1.13 2005/10/11 15:29:01 ceri Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="rel.head" select='"7.0"'/>
  <xsl:variable name="rel.head.major" select='"7"'/>

  <!-- An upcoming release that we want tested.  Set $beta.testing to 0
	if we're not in the middle of a release cycle.  Ha ha. -->
  <xsl:variable name="beta.testing" select="0" />
  <xsl:variable name="betarel.current" select='"6.0"'/>
  <xsl:variable name="betarel.vers" select='"RC1"'/>
  <xsl:variable name="u.betarel.schedule">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$betarel.current"/>R/schedule.html</xsl:variable>

  <xsl:variable name="rel.current" select='"6.0"'/>
  <xsl:variable name="rel.current.major" select='"6"'/>

  <xsl:variable name="u.rel.notes">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel.announce">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel.errata">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel.hardware">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel.installation">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/installation.html</xsl:variable>
  <xsl:variable name="u.rel.readme">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/readme.html</xsl:variable>
  <xsl:variable name="u.rel.early">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/migration-guide.html</xsl:variable>
  <xsl:variable name="u.rel.migration">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/migration-guide.html</xsl:variable>

  <xsl:variable name="rel2.current" select='"5.4"'/>
  <xsl:variable name="rel2.current.major" select='"5"'/>

  <xsl:variable name="u.rel2.notes">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel2.announce">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel2.errata">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel2.hardware">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel2.installation">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/installation.html</xsl:variable>
  <xsl:variable name="u.rel2.readme">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/readme.html</xsl:variable>

</xsl:stylesheet>
