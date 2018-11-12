<?xml version="1.0" encoding="koi8-r"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/libcommon.xsl"/>

  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/../gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="FreeBSD News"/>

    <p>FreeBSD �������� ������ ������������� ������������ ��������. ����
      � ����� ���� ��������� ���������� ������ ������ ����������! �����
      ������� ���, ������������ ����������� � ���� ���������. ����� ����, ��
      ����� �������� ����������� �� <a
	href="../../doc/ru_RU.KOI8-R/books/handbook/eresources.html#ERESOURCES-MAIL">
	������ �������� freebsd-announce</a> ��� ������������
      <a href="news.rdf">RSS</a>.</p>

    <p>��������� ������� ����� ����������� �������� ��������, � �������
      ����� ���������� � ������� ���������� � ��������, ������������ �
      ��������������� ��������.</p>

    <ul>
      <li><a href="../../java/newsflash.html">&java; �� FreeBSD</a></li>

      <li><a href="http://freebsd.kde.org/">KDE �� FreeBSD</a></li>

      <li><a href="../../gnome/newsflash.html">GNOME �� FreeBSD</a></li>
    </ul>

    <p>��������� �������� �������, ��������� � ������� ������� ��������� ��
      �������� <strong><a href="&base;/releases/index.html">����������
	  � �������</a></strong>.</p>

    <p>��������� �� ������������ FreeBSD ��������� �� �������� <a
	href="&base;/security/#adv">���������� � ������������</a>.</p>
  </xsl:template>

  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">� ��������</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>������ ������� ���:
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
    <a href="&base;/news/press.html">� ���������� � ������</a>
  </xsl:variable>

  <xsl:template name="html-news-list-press-preface">
    <p>���� �� �� ����� ����� ������̣���� ����������, ����������,
      ��������� ţ URL �� ����� <a
	href="mailto:www@FreeBSD.org">www@FreeBSD.org</a></p>

    <p>����� ����, ������� ������ � ������� FreeBSD Java �� ������ �����,
      ������� ��������� <a
	href="&base;/java/press.html">FreeBSD/Java � ������</a>.</p>
  </xsl:template>

  <xsl:template name="html-events-list-preface">
    <p>���� �� ������������ ����������� � ��������, ��������� � FreeBSD,
      ��� ������� ����� ��������� ������������� FreeBSD, �� �������������
      �����, ��, ����������, �������� ��� ����������� �� ����� <a
	href="mailto:www@FreeBSD.org">www@FreeBSD.org</a>, ����� ���
      ���������� ��������� �����.</p>
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
    <h2 id="upcoming">������� � ����������� �����������:</h2>
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
    <h2 id="past">������� �������:</h2>
  </xsl:template>

  <!-- Convert a month number to the corresponding long English name. -->
  <xsl:template name="gen-long-en-month">
    <xsl:param name="nummonth"/>
    <xsl:variable name="month" select="number($nummonth)"/>
    <xsl:choose>
      <xsl:when test="$month=1">������</xsl:when>
      <xsl:when test="$month=2">�������</xsl:when>
      <xsl:when test="$month=3">����</xsl:when>
      <xsl:when test="$month=4">������</xsl:when>
      <xsl:when test="$month=5">���</xsl:when>
      <xsl:when test="$month=6">����</xsl:when>
      <xsl:when test="$month=7">����</xsl:when>
      <xsl:when test="$month=8">������</xsl:when>
      <xsl:when test="$month=9">��������</xsl:when>
      <xsl:when test="$month=10">�������</xsl:when>
      <xsl:when test="$month=11">������</xsl:when>
      <xsl:when test="$month=12">�������</xsl:when>
      <xsl:otherwise>Invalid month</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
