<?xml version="1.0" encoding="gb2312" ?>

<!-- $FreeBSD: www/zh_CN/news/includes.xsl,v 1.1.1002.5 2005/12/17 19:59:37 delphij Exp $ -->

<!-- The FreeBSD Simplified Chinese Documentation Project -->
<!-- Original Revision www/en/news/includes.xsl,v 1.6 2004/04/07 11:37:55 phantom -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="newshome">
    <a href="{$base}/news/news.html">新闻首页</a>
  </xsl:variable>

  <xsl:variable name="presshome">
    <a href="{$base}/news/press.html">媒体报道首页</a>
  </xsl:variable>

  <!-- Generate a unique anchor for this event -->
  <xsl:template name="generate-event-anchor">
    <xsl:text>event</xsl:text>
    <xsl:value-of select="ancestor::year/name"/>
    <xsl:value-of select="ancestor::month/name"/>
    <xsl:value-of select="ancestor::day/name"/>:<xsl:value-of select="count(preceding-sibling::event)"/>
  </xsl:template>

  <!-- Generate a unique anchor for this story -->
  <xsl:template name="generate-story-anchor">
    <xsl:text>story</xsl:text>
    <xsl:value-of select="ancestor::year/name"/>
    <xsl:value-of select="ancestor::month/name"/>:<xsl:text/>
    <xsl:value-of select="count(following-sibling::story)"/>
  </xsl:template>

  <!-- From FreeBSD: www/share/sgml/includes.misc.xsl,v 1.27 2005/11/09 22:10:00 simon -->
  <xsl:template name="html-news-make-olditems-list">
    <p>更早的公告：
      <a href="{$enbase}/news/2003/index.html">2003</a>,
      <a href="{$enbase}/news/2002/index.html">2002</a>,
      <a href="{$enbase}/news/2001/index.html">2001</a>,
      <a href="{$enbase}/news/2000/index.html">2000</a>,
      <a href="{$enbase}/news/1999/index.html">1999</a>,
      <a href="{$enbase}/news/1998/index.html">1998</a>,
      <a href="{$enbase}/news/1997/index.html">1997</a>,
      <a href="{$enbase}/news/1996/index.html">1996</a></p>
  </xsl:template>

</xsl:stylesheet>
