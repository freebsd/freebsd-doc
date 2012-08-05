<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "Mapa de sitio e &iacute;ndice de http://www.FreeBSD.org">
]>

<!-- $FreeBSD$ -->

<!-- The FreeBSD Spanish Documentation Project
     Original Revision: r1.29                   -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/xhtml.xsl"/>

  <xsl:variable name="lowercase" select="'aábcdeéfghiíjklmnñoópqrstuúvwxyz'"/>
  <xsl:variable name="uppercase" select="'AÁBCDEÉFGHIÍJKLMNÑOÓPQRSTUÚVWXYZ'"/>

  <xsl:key name="indexLetter" match="term" use="translate(substring(text, 1, 1), $lowercase, $uppercase)"/>

  <xsl:template name="process.contentwrap">
    <h1>Mapa del sitio</h1>

    <xsl:call-template name="html-sitemap"/>

    <h2>Metap&aacute;ginas</h2>

    <ul>
      <li><a href="&enbase;/commercial/commercial.html">Distribuidores comerciales</a></li>
      <li><a href="&base;/copyright/copyright.html">Copyright</a></li>
      <li><a href="&base;/docs.html">Documentaci&oacute;n</a></li>
      <li><a href="&base;/internal/internal.html">Informaci&oacute;n interna</a></li>
      <li><a href="&base;/news/news.html">Noticias</a></li>
      <li><a href="&base;/platforms/">Plataformas</a></li>
      <li><a href="&enbase;/ports/index.html">Ports</a></li>
      <li><a href="&base;/projects/projects.html">Proyectos</a></li>
      <li><a href="&base;/releases/index.html">Informaci&oacute;n de releases</a></li>
      <li><a href="&base;/search/search.html">B&acute;squeda</a></li>
      <li><a href="&enbase;/security/security.html">Seguridad</a></li>
      <li><a href="&base;/support.html">Soporte</a></li>
    </ul>

    <hr noshade="noshade"/>

    <h1>&Iacute;ndice alfab&eacute;tico</h1>

    <xsl:call-template name="html-index-toc"/>

    <hr noshade="noshade"/>

    <xsl:call-template name="html-index"/>
  </xsl:template>
</xsl:stylesheet>
