<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd">
<!-- $FreeBSD$
     $FreeBSDde: de-www/share/sgml/libcommon.xsl,v 1.1 2006/10/19 19:26:11 jkois Exp $
     basiert auf: 1.1
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/libcommon.xsl"/>

  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="Nouvelles FreeBSD"/>

    <p>Manchmal ist es m&#252;hsam, mit der schnellen Entwicklung
      des FreeBSD Betriebssystems Schritt zu halten.  Besuchen
      Sie diese Seite &#246;fter, um informiert zu bleiben.
      Weiterhin k&#246;nnen Sie die
      <a href="&base;/../doc/de_DE.ISO8859-1/books/handbook/eresources.html#ERESOURCES-MAIL">Mailingliste
	freebsd-announce</a> abonnieren oder den <a href="news.rdf">RSS
	Ticker</a> benutzen.</p>

    <p>Die nachstehenden Projekte besitzen eigene Seiten,
      auf denen Sie projektbezogene Ank&#252;ndigungen finden:</p>

    <ul>
      <li><a href="&enbase;/java/newsflash.html">&java; unter FreeBSD</a></li>
      <li><a href="http://freebsd.kde.org/">KDE unter FreeBSD</a></li>
      <li><a href="&enbase;/gnome/newsflash.html">GNOME unter FreeBSD</a></li>
    </ul>

    <p>Informationen &#252;ber fr&#252;here, aktuelle und k&#252;nftige
      Releases finden Sie auf der Seite
      <strong><a href="&base;/releases/index.html">Release
	  Information</a></strong>.</p>

    <p>Die FreeBSD Sicherheitshinweise finden Sie auf der Seite
      <a href="&base;/security/#adv">FreeBSD Sicherheit</a>.</p>
  </xsl:template>

  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">FreeBSD Neuigkeiten</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>&#196;ltere Ank&#252;ndigungen:
      <a href="2002/index.html">2002</a>,
      <a href="&enbase;/news/2001/index.html">2001</a>,
      <a href="&enbase;/news/2000/index.html">2000</a>,
      <a href="&enbase;/news/1999/index.html">1999</a>,
      <a href="&enbase;/news/1998/index.html">1998</a>,
      <a href="&enbase;/news/1997/index.html">1997</a>,
      <a href="&enbase;/news/1996/index.html">1996</a></p>
  </xsl:template>

  <xsl:variable name="html-news-list-press-homelink">
    <a href="&base;/news/press.html">FreeBSD Pressemeldungen</a>
  </xsl:variable>

  <xsl:template name="html-news-list-press-preface">
    <p>Kennen Sie einen hier nicht aufgef&#252;hrten Artikel?
      Senden Sie bitte die Einzelheiten an
      <a href="mailto:www@FreeBSD.org">www@FreeBSD.org</a> und
      wir nehmen den Artikel auf.</p>
  </xsl:template>
</xsl:stylesheet>
