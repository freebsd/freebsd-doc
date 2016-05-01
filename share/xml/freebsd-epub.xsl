<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:str="http://exslt.org/strings"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="db str"
		extension-element-prefixes="str"
                version='1.0'>

  <!-- Pull in the base stylesheets -->
  <xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/epub3/chunk.xsl"/>

  <!-- Pull in common XHTML customizations -->
  <xsl:import href="freebsd-xhtml-common.xsl"/>

  <!-- The localization layer is the same preference level of this file -->
  <xsl:include href="http://www.FreeBSD.org/XML/lang/share/xml/freebsd-epub.xsl"/>

  <xsl:param name="generate.legalnotice.link" select="'1'"/>
  <xsl:param name="html.chunk" select="'1'"/>
  <xsl:param name="img.src.path" select="'./'"/>

  <xsl:param name="docbook.css.source">../xml/docbook-epub.css.xml</xsl:param>
  <xsl:param name="formal.title.placement">
figure after
example before
equation after
table before
procedure before
  </xsl:param>
  <xsl:param name="variablelist.term.break.after" select="1"/>
  <xsl:param name="variablelist.term.separator"/>

  <!--
	XXX: $docbook.css.source source is interpreted as a relative path
	when referenced from a template and it should be relative to
	this stylesheets and not the stock one, so xopy this file here.
  -->
  <xsl:template name="generate.default.css.file">
    <xsl:if test="$make.clean.html != 0 and 
                  $generate.css.header = 0 and
                  $docbook.css.source != ''">
      <!-- Select default file relative to stylesheet -->
      <xsl:variable name="css.node" select="document($docbook.css.source)/*[1]"/>
      <xsl:variable name="fname" select="str:tokenize($docbook.css.source, '/')[last()]"/>

      <xsl:call-template name="generate.css.file">
        <xsl:with-param name="src" select="$fname"/>
        <xsl:with-param name="css.node" select="$css.node"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="make.css.link">
    <xsl:param name="css.filename" select="''"/>

    <xsl:variable name="href" select="substring-before(str:tokenize($docbook.css.source, '/')[last()], '.xml')"/>

    <xsl:if test="string-length($css.filename) != 0">
      <link rel="stylesheet" type="text/css" href="{$href}"/>
    </xsl:if>
  </xsl:template>

<xsl:template name="user.footer.navigation"/>
</xsl:stylesheet>

