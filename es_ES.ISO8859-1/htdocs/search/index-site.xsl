<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Mapa del sitio">
]>

<!-- $FreeBSD$ -->

<!-- The FreeBSD Spanish Documentation Project
     Original Revision: r1.29                   -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:variable name="lowercase" select="'aábcdeéfghiíjklmnñoópqrstuúvwxyz'"/>
  <xsl:variable name="uppercase" select="'AÁBCDEÉFGHIÍJKLMNÑOÓPQRSTUÚVWXYZ'"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:key name="indexLetter" match="term" use="translate(substring(text, 1, 1), 'aábcdeéfghiíjklmnñoópqrstuúvwxyz', 'AÁBCDEÉFGHIÍJKLMNÑOÓPQRSTUÚVWXYZ')"/>

  <xsl:template name="process.contentwrap">
    <xsl:call-template name="html-sitemap"/>

    <h2>Metapáginas</h2>

    <ul>
      <li><a href="&enbase;/commercial/commercial.html">Distribuidores comerciales</a></li>
      <li><a href="&base;/copyright/copyright.html">Copyright</a></li>
      <li><a href="&base;/docs.html">Documentación</a></li>
      <li><a href="&base;/internal/internal.html">Información interna</a></li>
      <li><a href="&base;/news/news.html">Noticias</a></li>
      <li><a href="&base;/platforms/">Plataformas</a></li>
      <li><a href="&enbase;/ports/index.html">Ports</a></li>
      <li><a href="&base;/projects/projects.html">Proyectos</a></li>
      <li><a href="&base;/releases/index.html">Información de releases</a></li>
      <li><a href="&base;/search/search.html">B&acute;squeda</a></li>
      <li><a href="&enbase;/security/security.html">Seguridad</a></li>
      <li><a href="&base;/support.html">Soporte</a></li>
    </ul>

    <hr noshade="noshade"/>

    <h1>Índice alfabético</h1>

    <xsl:call-template name="html-index-toc"/>

    <hr noshade="noshade"/>

    <xsl:call-template name="html-index"/>
  </xsl:template>
</xsl:stylesheet>
