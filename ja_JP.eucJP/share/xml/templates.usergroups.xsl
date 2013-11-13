<?xml version="1.0" encoding="euc-jp"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD Fragment//EN"
                                "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "ユーザグループ">
]>

<!-- $FreeBSD$ -->
<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: 1.12 -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:key name="usergroup-by-country" match="entry"
    use="../@code" />

  <xsl:variable name="charturl" select="'http://chart.apis.google.com/chart?cht=t&amp;chs=400x200&amp;chtm=world&amp;chco=ffffff,ffbe38,600000&amp;chf=bg,s,4D89F9'" />

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.sidewrap">
    &nav.community;
  </xsl:template>

  <xsl:template name="process.contentwrap">
  <xsl:variable name="chart-countries">
    <xsl:for-each select="//entry[
	generate-id() =
	generate-id(key('usergroup-by-country', ../@code)[1])]">
<!--      <xsl:sort select="format-number(count(key('event-by-country', location/country)), '000')" order="descending"/>
-->
        <xsl:value-of select="../@code" />
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="chart-country-counts">
    <xsl:for-each select="//entry[
	generate-id() =
	generate-id(key('usergroup-by-country', ../@code)[1])]">
        <xsl:value-of select="count(key('usergroup-by-country', ../@code))" />.0<xsl:if test="position()!=last()">,</xsl:if></xsl:for-each>
  </xsl:variable>

  <xsl:variable name="imageurl"><xsl:value-of select="$charturl"/>&amp;chd=t:<xsl:value-of select="$chart-country-counts"/>&amp;chld=<xsl:value-of select="$chart-countries"/></xsl:variable>

	<xsl:call-template name="html-usergroups-list-header" />

	<xsl:call-template name="html-usergroups-list-regions">
          <xsl:with-param name="usergroups.xml" select="$usergroups.xml" />
          <xsl:with-param name="usergroups-local.xml" select="$usergroups-local.xml" />
	</xsl:call-template>

	<xsl:call-template name="html-usergroups-map">
	  <xsl:with-param name="mapurl" select="$imageurl" />
	</xsl:call-template>

	<xsl:call-template name="html-usergroups-list-entries">
          <xsl:with-param name="usergroups.xml" select="$usergroups.xml" />
          <xsl:with-param name="usergroups-local.xml" select="$usergroups-local.xml" />
	</xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
