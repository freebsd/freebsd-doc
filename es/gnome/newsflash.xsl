<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/es/gnome/newsflash.xsl,v 1.3 2003/08/26 07:44:05 marcus Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS" exclude-result-prefixes="cvs">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>


  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="title" select="'Flash de Noticias FreeBSD GNOME'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:output type="html" encoding="iso-8859-1"/>

  <xsl:template match="news">
    <html>

      <xsl:copy-of select="$header1"/>

      <body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#840084"
            alink="#0000FF">

        <xsl:copy-of select="$header2"/>

        <!-- Notice how entity references in SGML become variable references
             in the stylesheet, and that the syntax for referring to variables
             inside an attribute is "{$variable}".

             This is just dis-similar enough to Perl and the shell that you
             end up writing ${variable} all the time, and then scratch your
             head wondering why the stylesheet isn't working.-->

        <!-- Also notice that because this is now XML and not SGML, empty
             elements, like IMG, must have a trailing "/" just inside the
             closing angle bracket, like this " ... />" -->
        <img src="{$base}/gifs/news.jpg" align="right" border="0" width="193"
             height="144" alt="Noticias FreeBSD GNOME"/>

        <xsl:apply-templates select="descendant::month"/>

        <xsl:copy-of select="$newshome"/>
        <xsl:copy-of select="$footer"/>
      </body>
    </html>
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
        <xsl:apply-templates select="p"/>
        </p>

    </li>
  </xsl:template>

  <xsl:template match="date"/>    <!-- Deliberately left blank -->

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
