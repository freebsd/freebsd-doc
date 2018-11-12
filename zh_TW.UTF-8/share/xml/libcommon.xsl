<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>

  <!-- Language-specific definitions should be put below this line -->
  <!-- default format for date string -->
  <xsl:param name="param-l10n-date-format-YMD"
             select="'%Y 年 %M %D 日'" />
  <xsl:param name="param-l10n-date-format-YM"
             select="'%Y 年 %M'" />
  <xsl:param name="param-l10n-date-format-MD"
             select="'%M %D 日'" />

  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="FreeBSD 新聞快遞"/>

    <p>FreeBSD 是個發展迅速的作業系統。
      保持最新的開發版是比較繁瑣的！你可以定期來查閱本頁，此外，也可能訂閱
      <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/eresources.html#ERESOURCES-MAIL">freebsd-announce
	郵件論壇</a> 或使用 <a href="news.rdf">RSS feed</a>。</p>

    <p>下列的每項都有自己的新聞頁面，裡面有這些的更新細節。</p>

    <ul>
      <li><a href="&enbase;/java/newsflash.html">FreeBSD 上的 &java;</a></li>
      <li><a href="http://freebsd.kde.org/">FreeBSD 上的 KDE</a></li>
      <li><a href="&enbase;/gnome/newsflash.html">FreeBSD 上的 GNOME</a></li>
    </ul>

    <p>更詳細的描述、介紹、和未來的發行版本，請看 <strong><a
	  href="&enbase;/releases/index.html">Release 資訊</a></strong>這頁。</p>

    <p>對於 FreeBSD 的安全公告， 請查閱 <a href="&base;/security/#adv">安全資訊</a> 頁面。</p>
  </xsl:template>

  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">新聞首頁</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>更早的公告：
      <a href="&enbase;/news/2003/index.html">2003</a>,
      <a href="&enbase;/news/2002/index.html">2002</a>,
      <a href="&enbase;/news/2001/index.html">2001</a>,
      <a href="&enbase;/news/2000/index.html">2000</a>,
      <a href="&enbase;/news/1999/index.html">1999</a>,
      <a href="&enbase;/news/1998/index.html">1998</a>,
      <a href="&enbase;/news/1997/index.html">1997</a>,
      <a href="&enbase;/news/1996/index.html">1996</a></p>
  </xsl:template>

  <xsl:variable name="html-news-list-press-homelink">
    <a href="&base;/news/press.html">媒體報導首頁</a>
  </xsl:variable>

  <xsl:template name="html-news-list-press-preface">
    <p>如果您知道我們沒有在這裡列出的關於 FreeBSD 的消息， 請寫信到
      <a href="mailto:www@FreeBSD.org">www@FreeBSD.org</a> 以便我們更新，謝謝。</p>
  </xsl:template>

  <xsl:template name="html-events-list-preface">
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
  </xsl:template>

  <!-- Convert a month number to the corresponding long English name. -->
  <xsl:template name="gen-long-en-month">
    <xsl:param name="nummonth"/>
    <xsl:variable name="month" select="number($nummonth)"/>
    <xsl:choose>
      <xsl:when test="$month=1">一月</xsl:when>
      <xsl:when test="$month=2">二月</xsl:when>
      <xsl:when test="$month=3">三月</xsl:when>
      <xsl:when test="$month=4">四月</xsl:when>
      <xsl:when test="$month=5">五月</xsl:when>
      <xsl:when test="$month=6">六月</xsl:when>
      <xsl:when test="$month=7">七月</xsl:when>
      <xsl:when test="$month=8">八月</xsl:when>
      <xsl:when test="$month=9">九月</xsl:when>
      <xsl:when test="$month=10">十月</xsl:when>
      <xsl:when test="$month=11">十一月</xsl:when>
      <xsl:when test="$month=12">十二月</xsl:when>
      <xsl:otherwise>月份無效</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="html-news-month-headings">
    <xsl:param name="year" />
    <xsl:param name="month" />

    <xsl:value-of select="concat($year, ' 年 ', $month)" />
  </xsl:template>

</xsl:stylesheet>
