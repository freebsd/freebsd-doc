<?xml version="1.0" encoding="koi8-r" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/www/ru/gnome/newsflash.xsl,v 1.1 2003/10/26 18:32:48 andy Exp $

     Original revision: 1.3
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>
  <xsl:variable name="section" select="'developers'"/>

  <xsl:variable name="base" select="'../..'"/>
  <xsl:variable name="title" select="'Последние новости FreeBSD GNOME'"/>

  <xsl:template name="process.content">
    <div id="contentwrap">

	<xsl:apply-templates select="/events/descendant::month"/>

	<xsl:copy-of select="$newshome"/>

	  	</div> <!-- contentwrap -->
  </xsl:template>

  <!-- Everything that follows are templates for the rest of the content -->

  <xsl:template match="month">
    <h1><xsl:value-of select="name"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="ancestor::year/name"/></h1>

    <ul>
      <xsl:apply-templates select="descendant::day"/>
    </ul>
  </xsl:template>

  <xsl:template match="day">
    <xsl:apply-templates select="event"/>
  </xsl:template>

  <xsl:template match="event">
    <li><p><a>
	  <xsl:attribute name="name">
	    <xsl:call-template name="generate-event-anchor"/>
	  </xsl:attribute>
	</a>

	<b><xsl:value-of select="ancestor::day/name"/>
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="ancestor::month/name"/>,
	  <xsl:value-of select="ancestor::year/name"/>:</b><xsl:text> </xsl:text>
	<xsl:copy-of select="p"/>
	</p>

    </li>
  </xsl:template>

  <xsl:template match="date"/>    <!-- Deliberately left blank -->
</xsl:stylesheet>
