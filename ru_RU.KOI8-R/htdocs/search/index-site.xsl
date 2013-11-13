<?xml version="1.0" encoding="koi8-r"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Карта сервера">
]>

<!-- $FreeBSD$ -->

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSDru: frdp/www/ru/search/index-site.xml,v 1.6 2004/04/08 07:08:56 den Exp $

     Original revision: 1.25
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:key name="indexLetter" match="term" use="translate(substring(text, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.contentwrap">
    <xsl:call-template name="html-sitemap"/>

    <h2>Разделы сайта</h2>

    <ul>
      <li><a href="../commercial/commercial.html">Коммерческие предложения</a></li>
      <li><a href="../copyright/copyright.html">Copyright and Legal</a></li>
      <li><a href="../docs.html">Документация</a></li>
      <li><a href="../FAQ/index.html">FAQ</a></li>
      <li><a href="../gallery/gallery.html">Галерея</a></li>
      <li><a href="../gnome/index.html">GNOME</a></li>
      <li><a href="../../doc/ru_RU.KOI8-R/books/handbook/index.html">Руководство</a></li>
      <li><a href="../internal/internal.html">Внутренняя информация</a></li>
      <li><a href="../java/index.html">Java</a></li>
      <li><a href="../news/news.html">Новости</a></li>
      <li><a href="../platforms/">Платформы</a></li>
      <li><a href="../ports/index.html">Порты</a></li>
      <li><a href="../projects/projects.html">Проекты</a></li>
      <li><a href="../releases/index.html">Информация о релизах</a></li>
      <li><a href="../search/search.html">Поиск</a></li>
      <li><a href="../security/security.html">Безопасность</a></li>
      <li><a href="../support.html">Поддержка</a></li>
    </ul>

    <hr noshade="noshade"/>

    <h1>Алфавитный указатель A-Z</h1>

    <xsl:call-template name="html-index-toc"/>

    <hr noshade="noshade"/>

    <xsl:call-template name="html-index"/>
  </xsl:template>
</xsl:stylesheet>
