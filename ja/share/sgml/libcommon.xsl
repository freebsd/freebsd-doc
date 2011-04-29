<?xml version="1.0" encoding="euc-jp"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd">
<!-- $FreeBSD: www/ja/share/sgml/libcommon.xsl,v 1.10 2011/02/08 11:29:15 ryusuke Exp $ -->

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
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="FreeBSD News"/>

    <p>FreeBSD は急速に発展を続けるオペレーティングシステムなので、
      最新の進歩について行くのが面倒になる時がありますよね。
      情報通になるために、このページを定期的にチェックするようにしましょう。
      また、<a href="&enbase;/doc/en_US.ISO8859-1/books/handbook/eresources.html#ERESOURCES-MAIL">freebsd-announce
	メーリングリスト</a> や <a href="&base;/news/rss.xml">RSS フィード</a>
      を購読したいという方もいるかもしれませんね。</p>

    <p>それぞれのプロジェクトの最新情報は、次の各ウェブページをご覧ください。</p>

    <ul>
      <li><a href="&base;/java/newsflash.html">&java; on FreeBSD</a></li>
      <li><a href="http://freebsd.kde.org/">KDE on FreeBSD</a></li>
      <li><a href="&enbase;/gnome/newsflash.html">GNOME on FreeBSD</a></li>
    </ul>

    <p>過去、現在、そして将来のリリースの詳細については、
      <a href="&base;/releases/index.html">リリース情報</a>
      のページをご覧ください。</p>

    <p>FreeBSD セキュリティ情報やセキュリティ勧告の一覧については、
      <a href="&base;/security/">セキュリティ情報</a>
      のページをご覧ください。</p>
  </xsl:template>

  <!-- template: "html-news-list-newsflash-homelink" -->
  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="news.html">ニュースページ</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>過去のニュース:
      <a href="&enbase;/news/2009/index.html">2009</a>,
      <a href="&enbase;/news/2008/index.html">2008</a>,
      <a href="&enbase;/news/2007/index.html">2007</a>,
      <a href="&enbase;/news/2006/index.html">2006</a>,
      <a href="&enbase;/news/2005/index.html">2005</a>,
      <a href="&enbase;/news/2004/index.html">2004</a>,
      <a href="&enbase;/news/2003/index.html">2003</a>,
      <a href="&enbase;/news/2002/index.html">2002</a>,
      <a href="2001/index.html">2001</a>,
      <a href="&enbase;/news/2000/index.html">2000</a>,
      <a href="&enbase;/news/1999/index.html">1999</a>,
      <a href="&enbase;/news/1998/index.html">1998</a>,
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

  <!-- template: "html-press-make-olditems-list" -->
  <xsl:template name="html-press-make-olditems-list">
    <p>過去のニュース記事:
      <a href="&enbase;/news/2008/press.html">2008</a>,
      <a href="&enbase;/news/2007/press.html">2007</a>,
      <a href="&enbase;/news/2006/press.html">2006</a>,
      <a href="&enbase;/news/2005/press.html">2005</a>,
      <a href="&enbase;/news/2004/press.html">2004</a>,
      <a href="&enbase;/news/2003/press.html">2003</a>,
      <a href="&enbase;/news/2002/press.html">2002</a>,
      <a href="&enbase;/news/2001/press.html">2001</a>,
      <a href="&enbase;/news/2000/press.html">2000</a>,
      <a href="&enbase;/news/1999/press.html">1999</a>,
      <a href="&enbase;/news/1998/press.html">1998-1996</a></p>
  </xsl:template>

  <!-- for l10n -->
  <xsl:template name="html-news-month-headings">
    <xsl:param name="year" />
    <xsl:param name="month" />

    <xsl:value-of select="concat($year, ' 年 ', $month)" />
  </xsl:template>

  <xsl:template name="html-events-list-preface">
    <p>ここに載っていない FreeBSD に関連したイベントや、
      FreeBSD ユーザが興味をもちそうなイベントをご存じなら、
      我々がここに載せられるように詳細を
      <a href="mailto:www@freebsd.org">www@FreeBSD.org</a> まで
      (英語で) 送ってください。</p>

    <p>iCalendar 形式に対応したスケジュール管理ソフトウェアを使っているなら、
      ここに載っているすべてのイベントを集めた
      <a href="&base;/events/events.ics">FreeBSD イベントカレンダ</a>
      を利用できます。</p>
  </xsl:template>

  <xsl:template name="html-events-map">
    <xsl:param name="mapurl" select="'none'" />

    <p>今後 FreeBSD に関連したイベントを開催する国や地域は、
      以下の地図において暗赤色に塗られています。
      過去に FreeBSD に関連したイベントを開催した国は黄色やオレンジ色で塗られています。
      より暗い色で塗られた地域ほど過去に多くのイベントを開催しています。</p>

    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="$mapurl" />
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
    <h2 id="upcoming">現在開催中、または今後開催予定のイベント</h2>
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
    <h2 id="past">過去のイベント</h2>
  </xsl:template>

  <!-- Generate a date interval. -->
  <!-- Sample: 27 November, 2002 - 29 December, 2003 -->
  <xsl:template name="gen-date-interval">
    <xsl:param name="startdate"/>
    <xsl:param name="enddate"/>

    <xsl:value-of select="startdate/year"/>
    <xsl:text> 年 </xsl:text>
    <xsl:value-of select="startdate/month"/>
    <xsl:text> 月 </xsl:text>
    <xsl:value-of select="startdate/day"/>

    <xsl:if test="number(startdate/month) != number(enddate/month) or
		  number(startdate/day) != number(enddate/day) or
		  number(startdate/year) != number(enddate/year)">

      <xsl:if test="number(startdate/month) != number(enddate/month) or
		    number(startdate/year) != number(enddate/year)">
	<xsl:text> 日</xsl:text>
      </xsl:if>

      <xsl:text> - </xsl:text>

      <xsl:if test="number(startdate/year) != number(enddate/year)">
	<xsl:value-of select="enddate/year"/>
	<xsl:text> 年 </xsl:text>
      </xsl:if>

      <xsl:if test="number(startdate/month) != number(enddate/month) or
		    number(startdate/year) != number(enddate/year)">
	<xsl:value-of select="enddate/month"/>
	<xsl:text> 月</xsl:text>
      </xsl:if>

      <xsl:if test="number(startdate/day) != number(enddate/day) or
		    number(startdate/month) != number(enddate/month) or
		    number(startdate/year) != number(enddate/year)">
	<xsl:text> </xsl:text>
	<xsl:value-of select="enddate/day"/>
	<xsl:text> 日</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="number(startdate/month) = number(enddate/month) and
		  number(startdate/day) = number(enddate/day) and
		  number(startdate/year) = number(enddate/year)">
      <xsl:text> 日</xsl:text>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
