<?xml version="1.0" encoding="KOI8-R" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD: www/ru/news/press.xsl,v 1.7 2004/12/30 17:53:44 hrs Exp $
     $FreeBSDru: frdp/www/ru/news/press.xsl,v 1.6 2004/04/09 10:59:01 phantom Exp $

     Original revision: 1.8
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>
  <xsl:variable name="section" select="'about'"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="title" select="'FreeBSD в прессе'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:param name="news.press.xml-master" select="'none'" />
  <xsl:param name="news.press.xml" select="'none'" />

  <xsl:output type="html" encoding="koi8-r"/>

  <xsl:template match="press">
    <html>
      
      <xsl:copy-of select="$header1"/>
      
            <body xsl:use-attribute-sets="att.body">
      
        <div id="containerwrap">
          <div id="container">
      
      	<xsl:copy-of select="$header2"/>
      
      	<div id="content">
      
      	      <xsl:copy-of select="$sidenav"/>
      
      	      <div id="contentwrap">
      	      
	      <xsl:copy-of select="$header3"/>

	<p>Если вы не нашли здесь определённой публикации, пожалуйста,
	  отрправте её URL на адрес <a
	  href="mailto:www@FreeBSD.org">www@FreeBSD.org</a></p>

	<p>Кроме того, новости прессы о проекте FreeBSD Java вы можете найти,
          посетив страничку <a
          href="{$base}/java/press.html">FreeBSD/Java в Прессе</a>.</p>

	<xsl:call-template name="html-news-list-press">
	  <xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
	  <xsl:with-param name="news.press.xml" select="$news.press.xml" />
	</xsl:call-template>

	<xsl:call-template name="html-news-make-olditems-list" />

	<xsl:copy-of select="$newshome"/>

	  	</div> <!-- contentwrap -->
		<br class="clearboth" />
	
	</div> <!-- content -->
	
	<xsl:copy-of select="$footer"/>
	
        </div> <!-- container -->
   </div> <!-- containerwrap -->

      </body>
    </html>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>Публикации прошлых лет:
      <a href="2002/press.html">2002</a>,
      <a href="2001/press.html">2001</a>,
      <a href="2000/press.html">2000</a>,
      <a href="1999/press.html">1999</a>,
      <a href="1998/press.html">1998-1996</a></p>
  </xsl:template>
</xsl:stylesheet>
