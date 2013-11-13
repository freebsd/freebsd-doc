<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>

  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="Nouvelles FreeBSD"/>

    <p>FreeBSD est un système d'exploitation en constante évolution. Se tenir informé
      des derniers développements peut devenir une corvée ! Pour rester à jour,
      consultez cette page régulièrement. Vous pouvez également
      vous inscrire à la liste de diffusion
      <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/eresources.html#ERESOURCES-MAIL">freebsd-announce</a>
      ou au <a href="news.rdf">flux RDF</a>.</p>

    <p>Les projets suivants ont leurs propres pages de nouvelles, vous pouvez les consulter
      pour les mises à jour spécifiques à ces projets.</p>

    <ul>
      <li><a href="&base;/java/newsflash.html">&java; sur FreeBSD</a></li>
      <li><a href="http://freebsd.kde.org/">KDE sur FreeBSD</a></li>
      <li><a href="&base;/gnome/newsflash.html">GNOME sur FreeBSD</a></li>
    </ul>

    <p>Pour une description détaillée des versions passées, présentes et futures,
      consultez la page <strong><a href="&base;/releases/index.html">d'information
	  sur les versions</a></strong>.</p>

    <p>Pour les avis de sécurité concernant FreeBSD, veuillez consulter la page
      <a href="&base;/security/#adv">d'information sur la sécurité</a>.</p>
  </xsl:template>

  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">Accueil Nouvelles</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>Anciennes annonces :
      <a href="2002/index.html">2002</a>,
      <a href="2001/index.html">2001</a>,
      <a href="2000/index.html">2000</a>,
      <a href="1999/index.html">1999</a>,
      <a href="1998/index.html">1998</a>,
      <a href="1997/index.html">1997</a>,
      <a href="1996/index.html">1996</a></p>
  </xsl:template>

  <xsl:variable name="html-news-list-press-homelink">
    <a href="&base;/news/press.html">Accueil Presse</a>
  </xsl:variable>

  <xsl:template name="html-news-list-press-preface">
    <p>Si vous connaissez d'autres articles à propos de FreeBSD que nous n'avons pas
      indiqués ici, veuillez envoyer tous les détails à l'adresse
      <a href="mailto:doc@freebsd.org">doc@FreeBSD.org</a> afin que nous puissions
      les ajouter.</p>

    <p>Vous pouvez également consulter la page <a href="&base;/java/press.html">FreeBSD/Java
	dans la Presse</a> pour des nouvelles sur le projet Java pour FreeBSD</p>
  </xsl:template>

  <xsl:template name="html-events-list-preface">
    <p>Si vous avez connaissance d'événements liés à FreeBSD, ou d'événements qui
      pourraient intéressés les utilisateurs FreeBSD, qui ne sont pas indiqués
      ici, veuillez envoyer tous les détails à <a
	href="mailto:www@FreeBSD.org">www@FreeBSD.org</a> de manière
      à ce qu'ils puissent être ajoutés.</p>

    <p>Les utilisateurs disposant d'un logiciel d'organisation comprenant le
      format iCalendar peuvent s'abonner au
      <a href="&base;/events/events.ics">
	calendrier des événements FreeBSD</a>
      qui comprend tous les événements mentionnés ici.</p>
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
    <h2 id="upcoming">Evénements actuels / à venir :</h2>
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
    <h2 id="past">Evénements passés :</h2>
  </xsl:template>

  <!-- Convert a month number to the corresponding long English name. -->
  <xsl:template name="gen-long-en-month">
    <xsl:param name="nummonth"/>
    <xsl:variable name="month" select="number($nummonth)"/>
    <xsl:choose>
      <xsl:when test="$month=1">Janvier</xsl:when>
      <xsl:when test="$month=2">Février</xsl:when>
      <xsl:when test="$month=3">Mars</xsl:when>
      <xsl:when test="$month=4">Avril</xsl:when>
      <xsl:when test="$month=5">Mai</xsl:when>
      <xsl:when test="$month=6">Juin</xsl:when>
      <xsl:when test="$month=7">Juillet</xsl:when>
      <xsl:when test="$month=8">Août</xsl:when>
      <xsl:when test="$month=9">Septembre</xsl:when>
      <xsl:when test="$month=10">Octobre</xsl:when>
      <xsl:when test="$month=11">Novembre</xsl:when>
      <xsl:when test="$month=12">Décembre</xsl:when>
      <xsl:otherwise>Mois invalide</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
