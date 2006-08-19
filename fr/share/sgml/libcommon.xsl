<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/libcommon.xsl"/>

  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="Nouvelles FreeBSD"/>

    <p>FreeBSD est un syst&#232;me d'exploitation en constante &#233;volution. Se tenir inform&#233;
      des derniers d&#233;veloppements peut devenir une corv&#233;e ! Pour rester &#224; jour,
      consultez cette page r&#233;guli&#232;rement. Vous pouvez &#233;galement
      vous inscrire &#224; la liste de diffusion
      <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/eresources.html#ERESOURCES-MAIL">freebsd-announce</a>
      ou au <a href="news.rdf">flux RDF</a>.</p>

    <p>Les projets suivants ont leurs propres pages de nouvelles, vous pouvez les consulter
      pour les mises &#224; jour sp&#233;cifiques &#224; ces projets.</p>

    <ul>
      <li><a href="&base;/java/newsflash.html">&java; sur FreeBSD</a></li>
      <li><a href="http://freebsd.kde.org/">KDE sur FreeBSD</a></li>
      <li><a href="&base;/gnome/newsflash.html">GNOME sur FreeBSD</a></li>
    </ul>

    <p>Pour une description d&#233;taill&#233;e des versions pass&#233;es, pr&#233;sentes et futures,
      consultez la page <strong><a href="&base;/releases/index.html">d'information
	  sur les versions</a></strong>.</p>

    <p>Pour les avis de s&#233;curit&#233; concernant FreeBSD, veuillez consulter la page
      <a href="&base;/security/#adv">d'information sur la s&#233;curit&#233;</a>.</p>
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
    <p>Si vous connaissez d'autres articles &#224; propos de FreeBSD que nous n'avons pas
      indiqu&#233;s ici, veuillez envoyer tous les d&#233;tails &#224; l'adresse
      <a href="mailto:doc@freebsd.org">doc@FreeBSD.org</a> afin que nous puissions
      les ajouter.</p>

    <p>Vous pouvez &#233;galement consulter la page <a href="&base;/java/press.html">FreeBSD/Java
	dans la Presse</a> pour des nouvelles sur le projet Java pour FreeBSD</p>
  </xsl:template>

  <xsl:template name="html-events-list-preface">
    <p>Si vous avez connaissance d'&#233;v&#233;nements li&#233;s &#224; FreeBSD, ou d'&#233;v&#233;nements qui
      pourraient int&#233;ress&#233;s les utilisateurs FreeBSD, qui ne sont pas indiqu&#233;s
      ici, veuillez envoyer tous les d&#233;tails &#224; <a
	href="mailto:www@FreeBSD.org">www@FreeBSD.org</a> de mani&#232;re
      &#224; ce qu'ils puissent &#234;tre ajout&#233;s.</p>

    <p>Les utilisateurs disposant d'un logiciel d'organisation comprenant le
      format iCalendar peuvent s'abonner au
      <a href="&base;/events/events.ics">
	calendrier des &#233;v&#233;nements FreeBSD</a>
      qui comprend tous les &#233;v&#233;nements mentionn&#233;s ici.</p>
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
    <h2 id="upcoming">Ev&#233;nements actuels / &#224; venir :</h2>
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
    <h2 id="past">Ev&#233;nements pass&#233;s :</h2>
  </xsl:template>

  <!-- Convert a month number to the corresponding long English name. -->
  <xsl:template name="gen-long-en-month">
    <xsl:param name="nummonth"/>
    <xsl:variable name="month" select="number($nummonth)"/>
    <xsl:choose>
      <xsl:when test="$month=1">Janvier</xsl:when>
      <xsl:when test="$month=2">F&#233;vrier</xsl:when>
      <xsl:when test="$month=3">Mars</xsl:when>
      <xsl:when test="$month=4">Avril</xsl:when>
      <xsl:when test="$month=5">Mai</xsl:when>
      <xsl:when test="$month=6">Juin</xsl:when>
      <xsl:when test="$month=7">Juillet</xsl:when>
      <xsl:when test="$month=8">Ao&#251;t</xsl:when>
      <xsl:when test="$month=9">Septembre</xsl:when>
      <xsl:when test="$month=10">Octobre</xsl:when>
      <xsl:when test="$month=11">Novembre</xsl:when>
      <xsl:when test="$month=12">D&#233;cembre</xsl:when>
      <xsl:otherwise>Mois invalide</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
