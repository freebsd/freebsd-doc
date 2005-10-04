<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/en/gnome/newsflash.xsl,v 1.5 2004/12/28 06:21:15 marcus Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS" exclude-result-prefixes="cvs">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>


  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="title" select="'FreeBSD GNOME News Flash'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>
  <xsl:variable name="section" select="'developers'"/>

  <xsl:output type="html" encoding="iso-8859-1"/>

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
	<img src="{$base}/gifs/news.jpg" align="right" border="0" width="193"
	     height="144" alt="FreeBSD GNOME News"/>

	<xsl:apply-templates select="descendant::month"/>

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

  <xsl:template match="i">
    <i><xsl:value-of select="self::i"/></i>
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
