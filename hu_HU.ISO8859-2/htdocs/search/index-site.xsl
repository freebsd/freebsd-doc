<?xml version="1.0" encoding="ISO-8859-2"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "Oldaltérkép">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/xhtml.xsl"/>

  <xsl:variable name="lowercase" select="'aábcdeéfghiíjklmnoóöőpqrstuúüűvwxyz'"/>
  <xsl:variable name="uppercase" select="'AÁBCDEÉFGHIÍJKLMNOÓÖŐPQRSTUÚÜŰVWXYZ'"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:key name="indexLetter" match="term" use="translate(substring(text, 1, 1), $lowercase, $uppercase)"/>

  <xsl:template name="process.contentwrap">
    <xsl:call-template name="html-sitemap"/>

    <h2>Metaoldalak</h2>

    <ul>
      <li><a href="&enbase;/commercial/commercial.html">Kereskedelmi terjeszt&#245;k</a></li>
      <li><a href="&base;/copyright/copyright.html">Copyright &eacute;s jogi inform&aacute;ci&oacute;k</a></li>
      <li><a href="&base;/docs.html">Dokument&aacute;ci&oacute;</a></li>
      <li><a href="&enbase;/internal/internal.html">Bels&#245; oldalak</a></li>
      <li><a href="&enbase;/news/news.html">H&iacute;rek</a></li>
      <li><a href="&base;/platforms/">Platformok</a></li>
      <li><a href="&enbase;/ports/index.html">Portok</a></li>
      <li><a href="&base;/projects/projects.html">Projektek</a></li>
      <li><a href="&enbase;/releases/index.html">A kiad&aacute;sokkal kapcsolatos inform&aacute;ci&oacute;k</a></li>
      <li><a href="&base;/search/search.html">Keres&eacute;s</a></li>
      <li><a href="&enbase;/security/security.html">Biztons&aacute;g</a></li>
      <li><a href="&base;/support.html">T&aacute;mogat&aacute;s</a></li>
    </ul>

    <hr noshade="noshade"/>

    <h1>A-Z Index</h1>

    <xsl:call-template name="html-index-toc"/>

    <hr noshade="noshade"/>

    <xsl:call-template name="html-index"/>
  </xsl:template>
</xsl:stylesheet>
