<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Site Map and Index of http://www.FreeBSD.org">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:key name="indexLetter" match="term" use="translate(substring(text, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.contentwrap">
    <h1>Site Map</h1>

    <xsl:call-template name="html-sitemap"/>

    <h2>Meta homepages</h2>

    <ul>
      <li><a href="../commercial/commercial.html">Commercial Vendors</a></li>
      <li><a href="../copyright/copyright.html">Copyright and Legal</a></li>
      <li><a href="../docs.html">Documentation</a></li>
      <li><a href="../internal/internal.html">Internal</a></li>
      <li><a href="../news/news.html">News</a></li>
      <li><a href="../platforms/">Platforms</a></li>
      <li><a href="../ports/index.html">Ports</a></li>
      <li><a href="../projects/projects.html">Projects</a></li>
      <li><a href="../releases/index.html">Release Information</a></li>
      <li><a href="../search/search.html">Search</a></li>
      <li><a href="../security/security.html">Security</a></li>
      <li><a href="../support.html">Support</a></li>
    </ul>

    <hr noshade="noshade"/>

    <h1>A-Z Index</h1>

    <xsl:call-template name="html-index-toc"/>

    <hr noshade="noshade"/>

    <xsl:call-template name="html-index"/>
  </xsl:template>
</xsl:stylesheet>
