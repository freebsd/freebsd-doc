<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD Fragment//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
]>

<!-- $FreeBSD$ -->

<!-- Copyright (c) 2005 Ceri Davies <ceri@FreeBSD.org>
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

<!-- Generate an iCalendar file from a www/en/events/events.dtd
  compliant events.xml -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">
  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>

  <xsl:variable name="freebsd-web-base" select="'https://www.FreeBSD.org'"/>

  <xsl:output method="text" encoding="&xml.encoding;"/>
  <xsl:strip-space elements="*"/>

  <!-- Template: events -->
  <xsl:template match="events">BEGIN:VCALENDAR
VERSION:2.0
PRODID:$FreeBSD$
    <xsl:apply-templates select="event"/>
END:VCALENDAR</xsl:template>

  <!-- Template: event -->
  <xsl:template match="event">
BEGIN:VEVENT
SEQUENCE:<xsl:value-of select="position()" />
SUMMARY:<xsl:value-of select="name"/>
    <xsl:if test="url">
      <xsl:apply-templates select="url"/>
    </xsl:if>
LOCATION:<xsl:if test="location/site!=''">
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
    <xsl:call-template name="gen-ical-date-interval">
      <xsl:with-param name="startdate" select="startdate" />
      <xsl:with-param name="enddate" select="enddate" />
    </xsl:call-template>
DESCRIPTION:<xsl:copy-of select="description/child::node()"/>
    <xsl:if test="link">
      <xsl:apply-templates select="link"/>
    </xsl:if>
END:VEVENT</xsl:template>

  <!-- Template: link -->
  <xsl:template match="link">
    <xsl:apply-templates select="url"/>
  </xsl:template>

  <!-- Template: url -->
  <xsl:template match="url">
URL;VALUE=URI:<xsl:choose>
      <xsl:when test="@type='freebsd-website'">
        <xsl:value-of select="$freebsd-web-base"/>
      </xsl:when>
    </xsl:choose>
    <xsl:value-of select="."/>
  </xsl:template>

  <!-- Generate iCalendar DTSTART and DTEND entries -->
  <xsl:template name="gen-ical-date-interval">
    <xsl:param name="startdate"/>
    <xsl:param name="enddate"/>

DTSTART;VALUE=DATE:<xsl:value-of select="concat(startdate/year,
	    format-number(startdate/month, '00'),
	    format-number(startdate/day, '00'))"/>

    <xsl:if test="number(startdate/month) != number(enddate/month) or
		  number(startdate/day) != number(enddate/day) or
		  number(startdate/year) != number(enddate/year)">
DTEND;VALUE=DATE:<xsl:value-of select="concat(enddate/year,
	format-number(enddate/month, '00'),
	format-number(enddate/day, '00'))"/>

     </xsl:if>
  </xsl:template>
</xsl:stylesheet>
