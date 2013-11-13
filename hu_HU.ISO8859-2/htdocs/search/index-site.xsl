<?xml version="1.0" encoding="iso-8859-2"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Oldaltérkép">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:variable name="lowercase" select="'aábcdeéfghiíjklmnoóöőpqrstuúüűvwxyz'"/>
  <xsl:variable name="uppercase" select="'AÁBCDEÉFGHIÍJKLMNOÓÖŐPQRSTUÚÜŰVWXYZ'"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:key name="indexLetter" match="term" use="translate(substring(text, 1, 1), 'aábcdeéfghiíjklmnoóöőpqrstuúüűvwxyz', 'AÁBCDEÉFGHIÍJKLMNOÓÖŐPQRSTUÚÜŰVWXYZ')"/>

  <xsl:template name="process.contentwrap">
    <xsl:call-template name="html-sitemap"/>

    <h2>Metaoldalak</h2>

    <ul>
      <li><a href="&enbase;/commercial/commercial.html">Kereskedelmi terjesztők</a></li>
      <li><a href="&base;/copyright/copyright.html">Copyright és jogi információk</a></li>
      <li><a href="&base;/docs.html">Dokumentáció</a></li>
      <li><a href="&enbase;/internal/internal.html">Belső oldalak</a></li>
      <li><a href="&enbase;/news/news.html">Hírek</a></li>
      <li><a href="&base;/platforms/">Platformok</a></li>
      <li><a href="&enbase;/ports/index.html">Portok</a></li>
      <li><a href="&base;/projects/projects.html">Projektek</a></li>
      <li><a href="&enbase;/releases/index.html">A kiadásokkal kapcsolatos információk</a></li>
      <li><a href="&base;/search/search.html">Keresés</a></li>
      <li><a href="&enbase;/security/security.html">Biztonság</a></li>
      <li><a href="&base;/support.html">Támogatás</a></li>
    </ul>

    <hr noshade="noshade"/>

    <h1>A-Z Index</h1>

    <xsl:call-template name="html-index-toc"/>

    <hr noshade="noshade"/>

    <xsl:call-template name="html-index"/>
  </xsl:template>
</xsl:stylesheet>
