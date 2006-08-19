<?xml version="1.0" encoding="euc-jp"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/libcommon.xsl"/>

  <!-- default format for date string -->
  <xsl:param name="param-l10n-date-format-YMD"
             select="'%Y 年 %M %D 日'" />
  <xsl:param name="param-l10n-date-format-YM"
             select="'%Y 年 %M'" />
  <xsl:param name="param-l10n-date-format-MD"
             select="'%M %D 日'" />

  <!-- template: "html-news-list-newsflash-preface" -->
  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&base;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="FreeBSD News"/>

    <p>FreeBSD は急速に発展を続けるオペレーティングシステムなので、
      最新の進歩について行くのが面倒になる時がありますよね。
      情報通になるために、このページを定期的にチェックするようにしましょう。
      <a href="&base;/doc/en_US.ISO8859-1/books/handbook/eresources.html#ERESOURCES-MAIL">
	freebsd-announce メーリングリスト</a>を購読するとよいかも知れません。</p>

    <p>それぞれのプロジェクトの最新情報は、次の各ウェブページをご覧ください。</p>

    <ul>
      <li><a href="&base;/java/newsflash.html">&java; on FreeBSD</a></li>
      <li><a href="http://freebsd.kde.org/">KDE on FreeBSD</a></li>
      <li><a href="&base;/gnome/newsflash.html">GNOME on FreeBSD</a></li>
    </ul>

    <p>過去、現在、そして将来のリリースの詳細については、
      <strong><a href="&base;/releases/index.html">リリース情報</a></strong>
      のページをご覧ください。</p>

    <p>FreeBSD セキュリティ勧告については、<a href="&base;/security/#adv">
	セキュリティ情報</a> のページをご覧ください。</p>
  </xsl:template>

  <!-- template: "html-news-list-newsflash-homelink" -->
  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="news.html">ニュースページ</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>過去のニュース:
      <a href="2002/index.html">2002</a>,
      <a href="2001/index.html">2001</a>,
      <a href="2000/index.html">2000</a>,
      <a href="1999/index.html">1999</a>,
      <a href="1998/index.html">1998</a>,
      <a href="1997/index.html">1997</a>,
      <a href="1996/index.html">1996</a></p>
  </xsl:template>

  <!-- template: "html-news-list-press-preface" -->
  <xsl:template name="html-news-list-press-preface">
    <p>ここに載っていない FreeBSD に関連したニュース記事をご存じなら、
      我々がここに載せられるように詳細を
      <a href="mailto:www@freebsd.org">www@FreeBSD.org</a> まで
      (英語で) 送ってください。</p>
  </xsl:template>

  <!-- for l10n -->
  <xsl:template name="html-news-month-headings">
    <xsl:param name="year" />
    <xsl:param name="month" />

    <xsl:value-of select="concat($year, ' 年 ', $month)" />
  </xsl:template>

  <xsl:template name="html-events-list-preface">
    <p>iCalendar 形式に対応したスケジュール管理ソフトウェアを使っているなら、
      イベントを集めた
      <a href="&enbase;/events/events.ics">FreeBSD イベントカレンダー</a>
      が利用できます。</p>
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
    <h2 id="upcoming">Current/Upcoming Events:</h2>
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
    <h2 id="past">Past Events:</h2>
  </xsl:template>
</xsl:stylesheet>
