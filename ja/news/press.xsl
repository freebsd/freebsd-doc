<?xml version="1.0" encoding="EUC-JP" ?>

<!--
    $FreeBSD: www/ja/news/press.xsl,v 1.3 2002/07/30 12:43:21 hrs Exp $
    Original revision: 1.5
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>


  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="title" select="'FreeBSD In The Press'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/ja/news/press.xsl,v 1.3 2002/07/30 12:43:21 hrs Exp $'"/>
  
  <xsl:output type="html" encoding="EUC-JP"/>

  <xsl:template match="press">
    <html>
      
      <xsl:copy-of select="$header1"/>

      <body xsl:use-attribute-sets="att.body">

	<xsl:copy-of select="$header2"/>

	<p>ここに載っていない FreeBSD に関連したニュース記事をご存じなら、
	  我々がここに載せられるように詳細を
	  <a href="mailto:www@freebsd.org">www@FreeBSD.org</a> まで
	  (英語で) 送ってください。</p>

	<p>また、FreeBSD Java プロジェクトの報道記事に関する情報は、
	  <a href="{$base}/java/press.html">FreeBSD/Java Press</a>
	  をご覧下さい。</p>
	
	<xsl:apply-templates select="//month"/>
	
	<xsl:copy-of select="$newshome"/>
	<xsl:copy-of select="$footer"/>
      </body>
    </html>
  </xsl:template>

  <!-- Everything that follows are templates for the rest of the content -->
  
  <xsl:template match="month">
    <h1><xsl:value-of select="ancestor::year/name"/> 年 <xsl:value-of select="name"/> 月</h1>

    <ul>
      <xsl:apply-templates select="descendant::story"/>
    </ul>
  </xsl:template>

  <xsl:template match="story">
    <xsl:variable name="url"><xsl:value-of select="url"/></xsl:variable>
    <xsl:variable name="site-url"><xsl:value-of
    select="site-url"/></xsl:variable>

    <li>
      <a>
	<xsl:attribute name="name">
	  <xsl:call-template name="generate-story-anchor"/>
	</xsl:attribute>
      </a>

      <p><a href="{$url}"><b><xsl:value-of
      select="name"/></b></a><br/>
	  
	<a href="{$site-url}"><xsl:value-of
	select="site-name"/></a>, <xsl:value-of select="author"/><br/>
	<xsl:copy-of select="p/child::node()"/>
      </p>
    </li>
  </xsl:template>
</xsl:stylesheet>
