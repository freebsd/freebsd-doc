<?xml version="1.0" encoding="KOI8-R" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/www/ru/news/press.xsl,v 1.5 2004/01/22 15:09:50 den Exp $

     Original revision: 1.6
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="title" select="'FreeBSD в прессе'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>
  
  <xsl:output type="html" encoding="koi8-r"/>

  <xsl:template match="press">
    <html>
      
      <xsl:copy-of select="$header1"/>

      <body xsl:use-attribute-sets="att.body">

	<xsl:copy-of select="$header2"/>

	<p>Если вы не нашли здесь определённой публикации, пожалуйста,
	  пошлите её URL на адрес <a
	  href="mailto:www@FreeBSD.org">www@FreeBSD.org</a></p>

	<p>Кроме того, новости прессы о проекте FreeBSD Java вы можете найти,
          посетив страничку <a
          href="{$base}/java/press.html">FreeBSD/Java Press</a>.</p>

	<xsl:apply-templates select="//month"/>
	
	<xsl:copy-of select="$newshome"/>
	<xsl:copy-of select="$footer"/>
      </body>
    </html>
  </xsl:template>

  <!-- Everything that follows are templates for the rest of the content -->
  
  <xsl:template match="month">
    <h1>
      <xsl:call-template name="transtable-lookup">
	<xsl:with-param name="word-group" select="'number-month'" />
	<xsl:with-param name="word">
	  <xsl:value-of select="name"/>
	</xsl:with-param>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:value-of select="ancestor::year/name"/></h1>

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
