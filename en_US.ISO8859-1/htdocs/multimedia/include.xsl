<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
	xmlns="http://www.w3.org/1999/xhtml"
	extension-element-prefixes="str">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>

  <xsl:template name="multimedia.pre">
    <h1>FreeBSD Multimedia Resources List</h1>

    <p>Links on this page refer to multimedia resources (podcast, vodcast,
      audio recordings, video recordings, photos) related to FreeBSD or
      of interest for FreeBSD users.</p>

    <p>This list is available as <a href="multimedia.html">chronological
	overview</a>, as a <a href="tags.html">tag cloud</a> and
      via <a href="sources.html">the sources</a>.</p>

    <p>This list is also available as RSS feed <a href="multimedia.xml"><img
	src="&base;/layout/images/ico_rss.png"
	alt="RSS Feed"/></a></p>

    <p>If you know any resources not listed here, or notice any dead links,
      please send details to the <a
	href="mailto:freebsd-doc@FreeBSD.org">documentation mailing
	list</a> so that
      it can be included or updated.</p>
  </xsl:template>

  <xsl:template match="item">
    <xsl:variable name="srcId" select="@source"/>
    <xsl:variable name="source" select="//source[@id = $srcId]"/>

    <li>
      <a href="{overview}"><xsl:value-of select="title"/></a><br/>

      Source:

      <a>
	<xsl:attribute name="href">
	  <xsl:value-of select="$source/url"/>
	</xsl:attribute>

	<xsl:value-of select="$source/name"/>
      </a>

      <br/>

      Added:

      <xsl:call-template name="misc-format-date-string">
	<xsl:with-param name="year" select="substring(@added, 1, 4)"/>
	<xsl:with-param name="month" select="substring(@added, 5, 2)"/>
	<xsl:with-param name="day" select="substring(@added, 7, 2)"/>
      </xsl:call-template>

      <br/>

      Tags:

      <xsl:for-each select="tags/tag">
	<a>
	  <xsl:attribute name="href">
	    <xsl:value-of select="concat('tags.html#', str:replace(., ' ', '_'))"/>
	  </xsl:attribute>

	  <xsl:value-of select="."/>
	</a>

	<xsl:if test="position() != last()">
	  <xsl:text>, </xsl:text>
	</xsl:if>
      </xsl:for-each>

      <br/>

      <xsl:if test="files/file">
        <xsl:text>Files: </xsl:text>
      </xsl:if>

      <xsl:for-each select="files/file">
	<a href="{url}"><xsl:value-of select="desc"/></a>
	<xsl:if test="size|length">
	  <xsl:text>&nbsp;(</xsl:text>
	  <xsl:for-each select="size|length">
	    <xsl:value-of select="."/>
	    <xsl:if test="position() != last()">
	      <xsl:text>,&nbsp;</xsl:text>
	    </xsl:if>
	  </xsl:for-each>
	  <xsl:text>)</xsl:text>
	</xsl:if>
	<xsl:if test="position() != last()">
	  <xsl:text>, </xsl:text>
	</xsl:if>
      </xsl:for-each>

      <br/>

      <p>
	<xsl:value-of select="desc"/>
      </p>
    </li>
  </xsl:template>
</xsl:stylesheet>
