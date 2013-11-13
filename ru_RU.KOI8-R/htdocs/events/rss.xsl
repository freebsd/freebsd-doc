<?xml version="1.0" encoding="koi8-r" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD Fragment//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$

     Original revision: 1.1
-->

<!-- Copyright (c) 2008 Murray Stokely <murray@FreeBSD.org>
     Copyright (c) 2003 Simon L. Nielsen <simon@FreeBSD.org>

     All rights reserved.

     Redistribution and use in source and binary forms, with or without
     modification, are permitted provided that the following conditions
     are met:
     1. Redistributions of source code must retain the above copyright
	notice, this list of conditions and the following disclaimer.
     2. Redistributions in binary form must reproduce the above copyright
	notice, this list of conditions and the following disclaimer in the
	documentation and/or other materials provided with the distribution.

     THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
     ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
     IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
     ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
     FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
     DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
     OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
     LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
     OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
     SUCH DAMAGE.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  xmlns:date="http://exslt.org/dates-and-times"
  extension-element-prefixes="date"
  exclude-result-prefixes="cvs">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:key name="event-by-month" match="event"
    use="concat(startdate/year, format-number(startdate/month, '00'))"/>

  <!-- Template: events -->
  <xsl:template match="events">
    <xsl:variable name="title">Предстоящие события FreeBSD</xsl:variable>
    <xsl:variable name="link">http://www.FreeBSD.org/ru/events/</xsl:variable>

    <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
      <channel>
        <title><xsl:value-of select="$title" /></title>
        <link><xsl:value-of select="$link" /></link>
        <description>Раздача RSS новостей о предстоящих конференциях по FreeBSD, саммитах, учебных курсах и других соответствующих мероприятиях.</description>
        <language>ru-ru</language>
        <webMaster>freebsd-www@FreeBSD.org (FreeBSD Web Team)</webMaster>
        <managingEditor>freebsd-www@FreeBSD.org (FreeBSD Web Team)</managingEditor>
        <docs>http://blogs.law.harvard.edu/tech/rss</docs>
        <ttl>120</ttl>
        <image>
          <url>http://www.FreeBSD.org/logo/logo-full.png</url>
          <title><xsl:value-of select="$title" /></title>
          <link><xsl:value-of select="$link" /></link>
        </image>
        <atom:link rel="self" type="application/rss+xml">
          <xsl:attribute name="href">
            <xsl:value-of select="$link" /><xsl:text>rss.xml</xsl:text>
          </xsl:attribute>
        </atom:link>

	<xsl:for-each select="event[generate-id() =
          generate-id(key('event-by-month',
	    concat(startdate/year, format-number(startdate/month, '00')))[1])
	  and ((number(enddate/year) &gt; number($curdate.year)) or
	    (number(enddate/year) = number($curdate.year) and
	     number(enddate/month) &gt; number($curdate.month)) or
	    (number(enddate/year) = number($curdate.year) and
	     number(enddate/month) = number($curdate.month) and
	     enddate/day &gt;= $curdate.day))]">

	  <xsl:sort select="startdate/year" order="ascending"/>
	  <xsl:sort select="format-number(startdate/month, '00')" order="ascending"/>
	  <xsl:sort select="format-number(startdate/day, '00')" order="ascending"/>

          <xsl:variable name="guid"><xsl:value-of select="url"/></xsl:variable>

          <item>
            <title><xsl:value-of select="name"/></title>
            <description>
              <xsl:value-of select="name"/>
              <xsl:if test="url">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="url"/>
                <xsl:text>)</xsl:text>
              </xsl:if>

              <xsl:if test="location/site!=''">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="location/site"/>
              </xsl:if>
              <xsl:if test="location/city!=''">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="location/city"/>
              </xsl:if>
              <xsl:if test="location/state!=''">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="location/state"/>
              </xsl:if>
              <xsl:if test="location/country!=''">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="location/country"/>
              </xsl:if>

              <xsl:text> </xsl:text>

              <xsl:call-template name="gen-date-interval">
                <xsl:with-param name="startdate" select="startdate" />
                <xsl:with-param name="enddate" select="enddate" />
              </xsl:call-template>

              <xsl:text>. </xsl:text>

              <xsl:apply-templates select="description"/>

            </description>

            <link><xsl:value-of select="$guid" /></link>
            <guid><xsl:value-of select="$guid" /></guid>
          </item>
        </xsl:for-each>

      </channel>
    </rss>

  </xsl:template>

</xsl:stylesheet>
