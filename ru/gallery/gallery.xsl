<?xml version="1.0" encoding="KOI8-R" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSDru: frdp/www/ru/gallery/gallery.xsl,v 1.3 2003/12/13 08:08:14 andy Exp $

     Original revision: 1.1
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'../..'"/>
  <xsl:variable name="title" select="'Галерея FreeBSD'"/>  
  <xsl:variable name="date" select="'$FreeBSD$'"/>

  <xsl:output type="html" encoding="koi8-r"/>

  <xsl:template match="gallery">
    <html>
      <xsl:copy-of select="$header1"/>
      <body xsl:use-attribute-sets="att.body">
	<xsl:copy-of select="$header2"/>

	<p>Во всём мире FreeBSD используется для обеспечения работы
	  инновационных приложений и служб.  В этой галерее представлено
	  <xsl:value-of select="count(//entry)"/> организаций и частных
	  лиц, которые выбрали FreeBSD.  Посмотрите и выберите, что ещё
	  может сделать FreeBSD для <b>вас</b>!</p>

	<ul>
	  <li><a href="cgallery.html"><xsl:value-of 
            select="count(//entry[@type='commercial'])"/> коммерческих
            компаний</a></li>

	  <li><a href="npgallery.html"><xsl:value-of
            select="count(//entry[@type='nonprofit'])"/> некоммерческих
            организаций</a></li>

          <li><a href="pgallery.html"><xsl:value-of
            select="count(//entry[@type='personal'])"/> персональных 
	    сайтов</a></li>
	</ul>

	<p>Чтобы добавить в этот список ваш сайт, просто заполните
	  <a href="http://www.FreeBSD.org/cgi/gallery.cgi">эту форму</a>.</p>

	<table width="100%" border="0">
	  <tr>
	    <td align="left"><img src="{$base}/gifs/powerlogo.gif" alt=""
	      align="left" border="0"/></td>

	    <td align="left"><img src="{$base}/gifs/power-button.gif" alt="" 
	      align="left" border="0"/></td>
	  </tr>

	  <tr>
	    <td align="right"><img src="{$base}/gifs/pbfbsd2.gif"
              width="171" height="64" border="0"/></td>

	    <td align="right"><img src="{$base}/gifs/powerani.gif"
              width="171" height="64"/></td>

	    <td align="right"><img src="{$base}/gifs/fhp_mini.jpg"
              width="171" height="64"/></td>
	  </tr>
	</table>

	<p align="center"><img src="{$base}/gifs/banner1.gif" alt="" 
          width="446" height="63" border="0"/></p>

	<p align="center"><img src="{$base}/gifs/banner2.gif" alt=""
          width="310" height="63" border="0"/></p>

	<p align="center"><img src="{$base}/gifs/banner3.gif" alt=""
          width="250" height="35" border="0"/></p>

	<p align="center"><img src="{$base}/gifs/banner4.gif" alt=""
          width="225" height="46" border="0"/></p>

	<p>Вышеприведённые логотипы "Powered by FreeBSD" разрешается <a
	  href="{$base}/gifs/powerlogo.gif">сгружать</a> и выводить на
	  персональных или коммерческих сайтах, для организации работы которых
	  используется FreeBSD.  Использование этого или похожих логотипов <a
	  HREF="../copyright/daemon.html">Даемонов BSD</a> для извлечения
	  коммерческой выгоды требует согласия <a
	  HREF="mailto:taob@risc.org">Брайана Тао</a> (Brian Tao), (создателя
	  логотипа "power") и <A HREF="mailto:mckusick@mckusick.com">Маршалла
	  Кёрка МакКузика</A> (Marshall Kirk McKusick), держателя торговой марки
	  на изображение Даемона BSD).</p>

	<xsl:copy-of select="$footer"/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
