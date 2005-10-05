<?xml version="1.0" encoding="KOI8-R" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD: www/ru/news/newsflash.xsl,v 1.8 2004/12/30 17:53:44 hrs Exp $
     $FreeBSDru: frdp/www/ru/news/newsflash.xsl,v 1.12 2004/04/09 11:18:50 phantom Exp $

     Original revision: 1.11
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>
  <xsl:variable name="section" select="'about'"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="title" select="'Последние новости FreeBSD'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>
  
  <xsl:output type="html" encoding="koi8-r"/>

  <xsl:template match="news">
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

	<!-- Notice how entity references in SGML become variable references
	     in the stylesheet, and that the syntax for referring to variables
	     inside an attribute is "{$variable}".

	     This is just dis-similar enough to Perl and the shell that you
	     end up writing ${variable} all the time, and then scratch your 
	     head wondering why the stylesheet isn't working.-->

	<!-- Also notice that because this is now XML and not SGML, empty
             elements, like IMG, must have a trailing "/" just inside the 
   	     closing angle bracket, like this " ... />" -->
	<img src="{$base}/../gifs/news.jpg" align="right" border="0" width="193"
	     height="144" alt="FreeBSD News"/>

	<p>FreeBSD является быстро развивающейся операционной системой. Быть
	  в курсе всех последних разработок бывает просто необходимо! Чтобы
	  сделать это, периодически обращайтесь к этой страничке. Может быть, вы
	  также захотите подписаться на <a
	  href="../../doc/ru_RU.KOI8-R/books/handbook/eresources.html#ERESOURCES-MAIL">
          список рассылки freebsd-announce</a> или использовать
          <a href="news.rdf">RSS</a>.</p>

        <p>Следующие проекты имеют собственные страницы новостей, к которым
          нужно обращаться в поисках информации о событиях, произошедших в
          соответствующих проектах.</p>

        <ul>
          <li><a href="../../java/newsflash.html"><xsl:value-of
            select="$java"/> на FreeBSD</a></li>

          <li><a href="http://freebsd.kde.org/">KDE на FreeBSD</a></li>

          <li><a href="../../gnome/newsflash.html">GNOME на FreeBSD</a></li>
        </ul>

	<p>Подробное описание прошлых, настоящих и будущих релизов находится на
	  странице <strong><a href="{$base}/releases/index.html">Информации
	  о релизах</a></strong>.</p>

	<p>Бюллетени по безопасности FreeBSD находятся на странице <a
	  href="{$base}/security/#adv">Информации о Безопасности</a>.</p>

	<xsl:call-template name="html-news-list-newsflash">
          <xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
          <xsl:with-param name="news.project.xml" select="$news.project.xml" />
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
    <p>Анонсы прошлых лет:
      <a href="2002/index.html">2002</a>,
      <a href="2001/index.html">2001</a>,
      <a href="2000/index.html">2000</a>,
      <a href="1999/index.html">1999</a>,
      <a href="1998/index.html">1998</a>,
      <a href="1997/index.html">1997</a>,
      <a href="1996/index.html">1996</a></p>
  </xsl:template>

  <!-- When the href attribute contains a '$base', expand it to the current
       value of the $base variable. -->

  <!-- All your $base are belong to us.  Ho ho ho -->
  <xsl:template match="a">
    <a><xsl:attribute name="href">
	<xsl:choose>
	  <xsl:when test="contains(@href, '$base')">
	    <xsl:value-of select="concat(substring-before(@href, '$base'), $base, substring-after(@href, '$base'))"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@href"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
</xsl:stylesheet>
