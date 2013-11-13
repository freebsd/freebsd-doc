<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Plan du site">
]>

<!-- $FreeBSD$ -->

<!--
  The FreeBSD French Documentation Project
  Original revision: 1.27

  Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
  Version francaise (mise a jour) : Vincent Tougait <viny@scientiae.net>
  Version francaise (mise a jour) : Antoine Brodin <antoine.brodin@laposte.net>
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:variable name="lowercase" select="'aàbcçdeéèêfghiîjklmnoôpqrstuùûvwxyz'"/>
  <xsl:variable name="uppercase" select="'AÀBCÇDEÉÈÊFGHIÎJKLMNOÔPQRSTUÙÛVWXYZ'"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:key name="indexLetter" match="term" use="translate(substring(text, 1, 1), 'aàbcçdeéèêfghiîjklmnoôpqrstuùûvwxyz', 'AÀBCÇDEÉÈÊFGHIÎJKLMNOÔPQRSTUÙÛVWXYZ')"/>

  <xsl:template name="process.contentwrap">
    <xsl:call-template name="html-sitemap"/>

    <h2>Meta pages d'accueil</h2>

      <ul>
	<li><a href="../commercial/commercial.html">Commercial</a></li>
	<li><a href="../copyright/copyright.html">Copyright et Informations légales</a></li>
	<li><a href="../docs.html">Documentation</a></li>
	<li><a href="../internal/internal.html">Interne</a></li>
	<li><a href="../news/news.html">Nouvelles</a></li>
	<li><a href="../platforms/">Plateformes</a></li>
	<li><a href="../ports/index.html">Ports</a></li>
	<li><a href="../projects/projects.html">Projets</a></li>
	<li><a href="../releases/index.html">Information sur les versions</a></li>
	<li><a href="../search/search.html">Recherche</a></li>
	<li><a href="../security/security.html">Sécurité</a></li>
	<li><a href="../support.html">Support</a></li>
    </ul>

    <hr noshade="noshade"/>

    <h1>Index A-Z</h1>

    <xsl:call-template name="html-index-toc"/>

    <hr noshade="noshade"/>

    <xsl:call-template name="html-index"/>
  </xsl:template>
</xsl:stylesheet>
