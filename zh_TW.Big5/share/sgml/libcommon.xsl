<?xml version="1.0" encoding="Big5" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/libcommon.xsl"/>

  <!-- Language-specific definitions should be put below this line -->
  <!-- default format for date string -->
  <xsl:param name="param-l10n-date-format-YMD"
             select="'%Y �~ %M %D ��'" />
  <xsl:param name="param-l10n-date-format-YM"
             select="'%Y �~ %M'" />
  <xsl:param name="param-l10n-date-format-MD"
             select="'%M %D ��'" />

  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="FreeBSD �s�D�ֻ�"/>

    <p>FreeBSD �O�ӵo�i���t���@�~�t�ΡC
      �O���̷s���}�o���O����c�����I�A�i�H�w���Ӭd�\�����A���~�A�]�i��q�\
      <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/eresources.html#ERESOURCES-MAIL">freebsd-announce
	�l��׾�</a> �Ψϥ� <a href="news.rdf">RSS feed</a>�C</p>

    <p>�U�C���C�������ۤv���s�D�����A�̭����o�Ǫ���s�Ӹ`�C</p>

    <ul>
      <li><a href="&enbase;/java/newsflash.html">FreeBSD �W�� &java;</a></li>
      <li><a href="http://freebsd.kde.org/">FreeBSD �W�� KDE</a></li>
      <li><a href="&enbase;/gnome/newsflash.html">FreeBSD �W�� GNOME</a></li>
    </ul>
	  
    <p>��ԲӪ��y�z�B���СB�M���Ӫ��o�檩���A�Ь� <strong><a
	  href="&enbase;/releases/index.html">Release ��T</a></strong>�o���C</p>
	
    <p>��� FreeBSD ���w�����i�A �Ьd�\ <a href="&base;/security/#adv">�w����T</a> �����C</p>
  </xsl:template>

  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">�s�D����</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>�󦭪����i�G
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
    <a href="&base;/news/press.html">�C����ɭ���</a>
  </xsl:variable>

  <xsl:template name="html-news-list-press-preface">
    <p>�p�G�z���D�ڭ̨S���b�o�̦C�X������ FreeBSD �������A �мg�H��
      <a href="mailto:www@FreeBSD.org">www@FreeBSD.org</a> �H�K�ڭ̧�s�A���¡C</p>
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
      <xsl:when test="$month=1">�@��</xsl:when>
      <xsl:when test="$month=2">�G��</xsl:when>
      <xsl:when test="$month=3">�T��</xsl:when>
      <xsl:when test="$month=4">�|��</xsl:when>
      <xsl:when test="$month=5">����</xsl:when>
      <xsl:when test="$month=6">����</xsl:when>
      <xsl:when test="$month=7">�C��</xsl:when>
      <xsl:when test="$month=8">�K��</xsl:when>
      <xsl:when test="$month=9">�E��</xsl:when>
      <xsl:when test="$month=10">�Q��</xsl:when>
      <xsl:when test="$month=11">�Q�@��</xsl:when>
      <xsl:when test="$month=12">�Q�G��</xsl:when>
      <xsl:otherwise>����L��</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="html-news-month-headings">
    <xsl:param name="year" />
    <xsl:param name="month" />

    <xsl:value-of select="concat($year, ' �~ ', $month)" />
  </xsl:template>

</xsl:stylesheet>
