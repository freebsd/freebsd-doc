<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/fr/includes.xsl,v 1.7 2004/11/24 21:29:06 stephane Exp $ -->

<!-- 
   The FreeBSD French Documentation Project
   Original revision: 1.20
   
   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../share/sgml/includes.xsl" />

  <xsl:variable name="url.doc.langcode" select="'fr_FR.ISO8859-1'" />

  <!-- Language-specific definitions should be put below this line -->
  
  <!-- Les "notes de version" ne sont pas forcement traduites => utilisation des versions anglaises -->
  <!-- voir le fichier share/sgml/includes.release.xsl -->
  <!-- on remplace $base par $enbase -->
  <xsl:variable name="u.rel.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/relnotes.html</xsl:variable>
  <xsl:variable name="u.rel.announce">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel.installation">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/installation.html</xsl:variable>
  <xsl:variable name="u.rel.readme">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/readme.html</xsl:variable>
  <xsl:variable name="u.rel.early">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/early-adopter.html</xsl:variable>
  <xsl:variable name="u.rel.migration">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/migration-guide.html</xsl:variable>

  <xsl:variable name="u.rel2.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/relnotes.html</xsl:variable>
  <xsl:variable name="u.rel2.announce">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel2.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel2.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel2.installation">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/installation.html</xsl:variable>
  <xsl:variable name="u.rel2.readme">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/readme.html</xsl:variable>

  <!-- -->

  <xsl:variable name="i.daemon">
    <img src="{$enbase}/gifs/daemon.gif" alt="Demon" align="left" width="80" height="76"/>
  </xsl:variable>

  <xsl:variable name="i.new">
    <img src="{$enbase}/gifs/new.gif" alt="[Nouveau !]" width="28" height="11"/>
  </xsl:variable>

  <xsl:variable name="copyright">
    <a href="{$base}/copyright/index.html">Copyright</a> &#169; 1995-2003 Le Projet FreeBSD. Tous droits r&#233;serv&#233;s.
  </xsl:variable>

  <xsl:variable name="home">
    <a href="{$base}/index.html"><img src="{$enbase}/gifs/home.gif" alt="Page accueil FreeBSD" border="0" align="right" width="101" height="33"/></a>
  </xsl:variable>

  <xsl:variable name="header2">
    <img src="{$enbase}/gifs/bar.gif" alt="Barre de navigation" width="565"
	 height="33" border="0" usemap="#bar"/>

    <h1 align="left"><font color="#660000"><xsl:value-of select="$title"/></font></h1>

    <br clear="all"/>

    <map name="bar">
      <area shape="rect" coords="1,1,111,31"
	    href="{$base}/index.html" alt="Accueil"/>
      <area shape="rect" coords="112,11,196,31"
	    href="{$enbase}/ports/index.html" alt="Applications"/>
      <area shape="rect" coords="196,12,257,33"
	      href="{$base}/support.html" alt="Support"/>
      <area shape="rect" coords="256,12,365,33"
	    href="{$base}/docs.html" alt="Documentation"/>
      <area shape="rect" coords="366,13,424,32"
	    href="{$base}/commercial/commercial.html" alt="Commercial"/>
      <area shape="rect" coords="425,16,475,32"
	      href="{$base}/search/search.html" alt="Recherche"/>
      <area shape="rect" coords="477,16,516,33"
	    href="{$base}/search/index-site.html" alt="Index"/>
      <area shape="rect" coords="516,15,562,33"
	    href="{$base}/index.html" alt="Accueil"/>
	<area shape="rect" coords="0,0,564,32"
	      href="{$base}/index.html" alt="Accueil"/>
    </map>
  </xsl:variable>

</xsl:stylesheet>
