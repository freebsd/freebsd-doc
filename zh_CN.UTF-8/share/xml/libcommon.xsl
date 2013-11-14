<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->
<!-- Original Revision: 1.7 -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>

  <!-- Language-specific definitions should be put below this line -->
  <!-- default format for date string -->
  <xsl:variable name="param-l10n-date-format-YMD"
             select="'%Y 年 %M %D 日'" />
  <xsl:variable name="param-l10n-date-format-YM"
             select="'%Y 年 %M'" />
  <xsl:variable name="param-l10n-date-format-MD"
             select="'%M %D 日'" />

  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="FreeBSD 新闻速递"/>

    <p>FreeBSD 是一个正在迅速开发着的操作系统。
      保持一个最终的开发版是比较繁琐的！你可以定期来查看这个页面，同样，你可能希望订阅
      <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/eresources.html#ERESOURCES-MAIL">freebsd-announce
	邮件列表</a> 或使用 <a href="news.rdf">RSS feed</a>。</p>

    <p>下列的每个项目都有自己的新闻页面，里面包含这些项目的详细更新。</p>

    <ul>
      <li><a href="&enbase;/java/newsflash.html">FreeBSD 上的 &java;</a></li>
      <li><a href="http://freebsd.kde.org/">FreeBSD 上的 KDE</a></li>
      <li><a href="&enbase;/gnome/newsflash.html">FreeBSD 上的 GNOME</a></li>
    </ul>

    <p>更详细的描述，介绍，和将来的发行版本，请看<strong><a
	  href="&base;/releases/index.html">版本信息</a></strong>页面。</p>

    <p>对于 FreeBSD 的安全公告， 请访问 <a href="&base;/security/#adv">安全信息</a> 页面。</p>
  </xsl:template>

  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">新闻首页</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>更早的公告：
      <a href="&enbase;/news/2005/index.html">2005</a>,
      <a href="&enbase;/news/2004/index.html">2004</a>,
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
    <a href="&base;/news/press.html">媒体报道首页</a>
  </xsl:variable>

  <xsl:template name="html-news-list-press-preface">
    <p>如果您知道我们没有在这里列出的关于 FreeBSD 的消息， 请致信
      <a href="mailto:www@FreeBSD.org">www@FreeBSD.org</a> 以便我们把它添加进去。</p>
  </xsl:template>

  <xsl:template name="html-events-list-preface">
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
  </xsl:template>

  <!-- Convert a month number to the corresponding long English name. -->
  <xsl:template name="gen-long-en-month">
    <xsl:variable name="nummonth"/>
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
      <xsl:otherwise>月份无效</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="html-news-month-headings">
    <xsl:variable name="year" />
    <xsl:variable name="month" />

    <xsl:value-of select="concat($year, ' 年 ', $month)" />
  </xsl:template>

</xsl:stylesheet>
