<?xml version="1.0" encoding="koi8-r"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>

  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/../gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="FreeBSD News"/>

    <p>FreeBSD является быстро развивающейся операционной системой. Быть
      в курсе всех последних разработок бывает просто необходимо! Чтобы
      сделать это, периодически обращайтесь к этой страничке. Может быть, вы
      также захотите подписаться на <a
	href="../../doc/ru_RU.KOI8-R/books/handbook/eresources.html#ERESOURCES-MAIL">
	список рассылки freebsd-announce</a> или использовать
      <a href="news.rdf">RSS</a>.</p>

    <p>Следующие проекты имеют собственные страницы новостей, к которым
      нужно обращаться в поисках информации о событиях, произошедших в
      соответствующих проектах.</p>

    <ul>
      <li><a href="../../java/newsflash.html">&java; на FreeBSD</a></li>

      <li><a href="http://freebsd.kde.org/">KDE на FreeBSD</a></li>

      <li><a href="../../gnome/newsflash.html">GNOME на FreeBSD</a></li>
    </ul>

    <p>Подробное описание прошлых, настоящих и будущих релизов находится на
      странице <strong><a href="&base;/releases/index.html">Информации
	  о релизах</a></strong>.</p>

    <p>Бюллетени по безопасности FreeBSD находятся на странице <a
	href="&base;/security/#adv">Информации о Безопасности</a>.</p>
  </xsl:template>

  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">К Новостям</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>Анонсы прошлых лет:
      <a href="2003/index.html">2003</a>,
      <a href="2002/index.html">2002</a>,
      <a href="2001/index.html">2001</a>,
      <a href="2000/index.html">2000</a>,
      <a href="1999/index.html">1999</a>,
      <a href="1998/index.html">1998</a>,
      <a href="1997/index.html">1997</a>,
      <a href="1996/index.html">1996</a></p>
  </xsl:template>

  <xsl:variable name="html-news-list-press-homelink">
    <a href="&base;/news/press.html">К Информации в Прессе</a>
  </xsl:variable>

  <xsl:template name="html-news-list-press-preface">
    <p>Если вы не нашли здесь определённой публикации, пожалуйста,
      отправьте её URL на адрес <a
	href="mailto:www@FreeBSD.org">www@FreeBSD.org</a></p>

    <p>Кроме того, новости прессы о проекте FreeBSD Java вы можете найти,
      посетив страничку <a
	href="&base;/java/press.html">FreeBSD/Java в Прессе</a>.</p>
  </xsl:template>

  <xsl:template name="html-events-list-preface">
    <p>Если вы располагаете информацией о событиях, связанных с FreeBSD,
      или которые будут интересны пользователям FreeBSD, из отсутствующих
      здесь, то, пожалуйста, пришлите все подробности на адрес <a
	href="mailto:www@FreeBSD.org">www@FreeBSD.org</a>, чтобы эта
      информация оказалась здесь.</p>
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
    <h2 id="upcoming">Текущие и планируемые мероприятия:</h2>
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
    <h2 id="past">Прошлые события:</h2>
  </xsl:template>

  <!-- Convert a month number to the corresponding long English name. -->
  <xsl:template name="gen-long-en-month">
    <xsl:param name="nummonth"/>
    <xsl:variable name="month" select="number($nummonth)"/>
    <xsl:choose>
      <xsl:when test="$month=1">Январь</xsl:when>
      <xsl:when test="$month=2">Февраль</xsl:when>
      <xsl:when test="$month=3">Март</xsl:when>
      <xsl:when test="$month=4">Апрель</xsl:when>
      <xsl:when test="$month=5">Май</xsl:when>
      <xsl:when test="$month=6">Июнь</xsl:when>
      <xsl:when test="$month=7">Июль</xsl:when>
      <xsl:when test="$month=8">Август</xsl:when>
      <xsl:when test="$month=9">Сентябрь</xsl:when>
      <xsl:when test="$month=10">Октябрь</xsl:when>
      <xsl:when test="$month=11">Ноябрь</xsl:when>
      <xsl:when test="$month=12">Декабрь</xsl:when>
      <xsl:otherwise>Invalid month</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
