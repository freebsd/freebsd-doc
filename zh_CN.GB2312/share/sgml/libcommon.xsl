<?xml version="1.0" encoding="gb2312" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->
<!-- Original Revision: 1.7 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/libcommon.xsl"/>

  <!-- Language-specific definitions should be put below this line -->
  <!-- default format for date string -->
  <xsl:variable name="param-l10n-date-format-YMD"
             select="'%Y �� %M %D ��'" />
  <xsl:variable name="param-l10n-date-format-YM"
             select="'%Y �� %M'" />
  <xsl:variable name="param-l10n-date-format-MD"
             select="'%M %D ��'" />

  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="FreeBSD �����ٵ�"/>

    <p>FreeBSD ��һ������Ѹ�ٿ����ŵĲ���ϵͳ��
      ����һ�����յĿ������ǱȽϷ����ģ�����Զ������鿴���ҳ�棬ͬ���������ϣ������
      <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/eresources.html#ERESOURCES-MAIL">freebsd-announce
	�ʼ��б�</a> ��ʹ�� <a href="news.rdf">RSS feed</a>��</p>

    <p>���е�ÿ����Ŀ�����Լ�������ҳ�棬���������Щ��Ŀ����ϸ���¡�</p>

    <ul>
      <li><a href="&enbase;/java/newsflash.html">FreeBSD �ϵ� &java;</a></li>
      <li><a href="http://freebsd.kde.org/">FreeBSD �ϵ� KDE</a></li>
      <li><a href="&enbase;/gnome/newsflash.html">FreeBSD �ϵ� GNOME</a></li>
    </ul>
	  
    <p>����ϸ�����������ܣ��ͽ����ķ��а汾���뿴<strong><a
	  href="&base;/releases/index.html">�汾��Ϣ</a></strong>ҳ�档</p>
	
    <p>���� FreeBSD �İ�ȫ���棬 ����� <a href="&base;/security/#adv">��ȫ��Ϣ</a> ҳ�档</p>
  </xsl:template>

  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">������ҳ</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>����Ĺ��棺
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
    <a href="&base;/news/press.html">ý�屨����ҳ</a>
  </xsl:variable>

  <xsl:template name="html-news-list-press-preface">
    <p>�����֪������û���������г��Ĺ��� FreeBSD ����Ϣ�� ������
      <a href="mailto:www@FreeBSD.org">www@FreeBSD.org</a> �Ա����ǰ�����ӽ�ȥ��</p>
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
      <xsl:when test="$month=1">һ��</xsl:when>
      <xsl:when test="$month=2">����</xsl:when>
      <xsl:when test="$month=3">����</xsl:when>
      <xsl:when test="$month=4">����</xsl:when>
      <xsl:when test="$month=5">����</xsl:when>
      <xsl:when test="$month=6">����</xsl:when>
      <xsl:when test="$month=7">����</xsl:when>
      <xsl:when test="$month=8">����</xsl:when>
      <xsl:when test="$month=9">����</xsl:when>
      <xsl:when test="$month=10">ʮ��</xsl:when>
      <xsl:when test="$month=11">ʮһ��</xsl:when>
      <xsl:when test="$month=12">ʮ����</xsl:when>
      <xsl:otherwise>�·���Ч</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="html-news-month-headings">
    <xsl:variable name="year" />
    <xsl:variable name="month" />

    <xsl:value-of select="concat($year, ' �� ', $month)" />
  </xsl:template>

</xsl:stylesheet>
