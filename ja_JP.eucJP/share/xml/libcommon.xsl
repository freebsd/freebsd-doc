<?xml version="1.0" encoding="euc-jp"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->
<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: r48667 -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>

  <!-- default format for date string -->
  <xsl:param name="param-l10n-date-format-YMD"
             select="'%Y 年 %M %D 日'" />
  <xsl:param name="param-l10n-date-format-YM"
             select="'%Y 年 %M'" />
  <xsl:param name="param-l10n-date-format-MD"
             select="'%M %D 日'" />

  <!-- template: "html-usergroups-list-regions"
       list all regions in a usergroup database -->

  <xsl:key name="html-usergroups-regions-key" match="entry" use="../../@name" />
  <xsl:key name="html-usergroups-id-key" match="entry" use="@id" />

  <xsl:template name="html-usergroups-map">
    <xsl:param name="mapurl" select="'none'" />

    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="$mapurl" />
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template name="html-usergroups-list-regions">
    <xsl:param name="usergroups.xml" select="'usergroups.xml'" />

    <ul>
      <xsl:for-each select="document($usergroups.xml)//continent">
      <xsl:sort select="format-number(count(country/entry), '000')"
      		order="descending"/>

	<xsl:variable name="id" select="
	  translate(@name,
	  ' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	  '--abcdefghijklmnopqrstuvwxyz')" />

	<li>
	  <p><xsl:element name="a">
	      <xsl:attribute name="href">
		<xsl:value-of select="concat('#', $id)" />
	      </xsl:attribute>

	      <xsl:call-template name="transtable-lookup">
		<xsl:with-param name="word-group" select="'continents'" />
		<xsl:with-param name="word" select="@name" />
	      </xsl:call-template>
	    </xsl:element>
	    ( <xsl:value-of select="count(country/entry)" /> ユーザグループ)</p>
	</li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- template: "html-usergroups-list-header"
       print header part of usergroup listing (l10n) -->

  <xsl:template name="html-usergroups-list-header">
    <p>FreeBSD は広く使われており、世界中にたくさんのユーザグループがあります。</p>
    <p>このリストに載っていないユーザグループをご存知でしたら、
      ぜひ、<a href="https://www.FreeBSD.org/support/bugreports.html">障害報告</a>
      の Documentation->Website カテゴリを使って以下の情報をお知らせください。</p>
    <ol>
      <li>ユーザグループのウェブサイトの URL</li>
      <li>訪問者とウェブサイトの管理のために、担当者の連絡先のメールアドレス</li>
      <li>ユーザグループの簡単な (一段落の) 紹介文</li>
    </ol>

    <p>報告は HTML 形式でお願いします。
      FreeBSD のポリシーから、
      活発なユーザグループの活動の公開は好ましいことです。
      近くにユーザグループがなければ、<a
	href="http://bsd.meetup.com/">http://bsd.meetup.com/</a>
      を使って近所にいる興味を持っている個人を見つけてください。
      そして、あなた自身のユーザグループを作ってください!</p>

    <h3>地域</h3>
  </xsl:template>

  <!-- template: "html-news-list-newsflash-preface" -->
  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="FreeBSD News"/>

    <p>FreeBSD は急速に発展を続けるオペレーティングシステムなので、
      最新の進歩について行くのが面倒になる時がありますよね。
      情報通になるために、このページを定期的にチェックするようにしましょう。
      ニュースは、
      <a href="https://lists.freebsd.org/mailman/listinfo/freebsd-announce">freebsd-announce
	メーリングリスト</a> および
      <a href="&base;/news/rss.xml">RSS フィード</a>
      でもアナウンスされます。</p>

    <p>それぞれのプロジェクトの最新情報は、次の各ウェブページをご覧ください。</p>

    <ul>
      <li><a href="http://freebsd.kde.org/">KDE on FreeBSD</a></li>
      <li><a href="&enbase;/gnome/newsflash.html">GNOME on FreeBSD</a></li>
    </ul>

    <p>過去、現在、そして将来のリリースの詳細については、
      <a href="&base;/releases/index.html">リリース情報</a>
      のページをご覧ください。</p>

    <p>FreeBSD セキュリティ情報やセキュリティ勧告の一覧は、
      <a href="&base;/security/">セキュリティ情報</a>
      ページにあります。</p>
  </xsl:template>

  <!-- template: "html-news-list-newsflash-homelink" -->
  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">ニュースページ</a>
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
      <a href="1996/index.html">1996</a>,
      <a href="&enbase;/news/1993/index.html">1993</a></p>
  </xsl:template>

  <!-- template: "html-news-list-press-preface" -->
  <xsl:template name="html-news-list-press-preface">
    <p>FreeBSD に関連したニュース記事の詳細を <a
	href="mailto:freebsd-doc@FreeBSD.org">freebsd-doc@FreeBSD.org</a>
      まで (英語で) 送ってください。</p>
  </xsl:template>

  <!-- template: "html-press-make-olditems-list" -->
  <xsl:template name="html-press-make-olditems-list">
    <p>過去のニュース記事:
      <a href="&enbase;/news/2009/press.html">2009</a>,
      <a href="&enbase;/news/2008/press.html">2008</a>,
      <a href="&enbase;/news/2007/press.html">2007</a>,
      <a href="&enbase;/news/2006/press.html">2006</a>,
      <a href="&enbase;/news/2005/press.html">2005</a>,
      <a href="&enbase;/news/2004/press.html">2004</a>,
      <a href="&enbase;/news/2003/press.html">2003</a>,
      <a href="&enbase;/news/2002/press.html">2002</a>,
      <a href="&base;/news/2001/press.html">2001</a>,
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
    <p>ここに掲載されていない FreeBSD に関連したイベントや、
      FreeBSD ユーザが興味をもちそうなイベント詳細をご存知でしたら、
      <a href="mailto:freebsd-doc@FreeBSD.org">freebsd-doc@FreeBSD.org</a>
      まで (英語で) 送ってください。</p>

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
