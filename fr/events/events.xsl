<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- Copyright (c) 2003 Simon L. Nielsen <simon@FreeBSD.org>
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

     $FreeBSD$
-->

<!-- 
   The FreeBSD French Documentation Project
   Original revision: 1.2
   
   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>

  <xsl:variable name="curdate" select="document('curdate.xml')//curdate"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>
  <xsl:variable name="email" select="'freebsd-www'"/>
  <xsl:variable name="title" select="'Ev&#233;nements FreeBSD'"/>

  <xsl:output method="xml" encoding="iso-8859-1"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

  <xsl:key name="event-by-month" match="event"
    use="concat(startdate/year, format-number(startdate/month, '00'))"/>

  <!-- Template: events -->
  <xsl:template match="events">
    <html>
      <xsl:copy-of select="$header1"/>

      <body xsl:use-attribute-sets="att.body">

	<xsl:copy-of select="$header2"/>

	<!--
	     Note the current date to have a reference, if the
	     upcoming/past events are split incorrectly.
	-->
	<xsl:comment>
	  <xsl:text>G&#233;n&#233;r&#233; le : </xsl:text>
	  <xsl:value-of select="concat($curdate/year,
	    format-number($curdate/month, '00'),
	    format-number($curdate/day, '00'))"/>
	</xsl:comment>

	<p>Si vous avez connaissance d'&#233;v&#233;nements li&#233;s &#224; FreeBSD, ou d'&#233;v&#233;nements qui
	  pourraient int&#233;ress&#233;s les utilisateurs FreeBSD, qui ne sont pas indiqu&#233;s
	  ici, veuillez envoyer tous les d&#233;tails &#224; <a
	  href="mailto:www@freebsd.org">www@FreeBSD.org</a> de mani&#232;re
	  &#224; ce qu'ils puissent &#234;tre ajout&#233;s.</p>

	<h2 id="upcoming">
          <xsl:text>Ev&#233;nements actuels / &#224; venir :</xsl:text>
	</h2>

	<xsl:for-each select="event[generate-id() =
          generate-id(key('event-by-month',
	    concat(startdate/year, format-number(startdate/month, '00')))[1])
	  and ((number(enddate/year) &gt; number($curdate/year)) or
	    (number(enddate/year) = number($curdate/year) and
	     number(enddate/month) &gt; number($curdate/month)) or
	    (number(enddate/year) = number($curdate/year) and
	     number(enddate/month) = number($curdate/month) and
	     enddate/day &gt;= $curdate/day))]">

	  <xsl:sort select="startdate/year" order="ascending"/>
	  <xsl:sort select="format-number(startdate/month, '00')" order="ascending"/>
	  <xsl:sort select="format-number(startdate/day, '00')" order="ascending"/>

	  <h3>
	    <xsl:attribute name="id">
	      <xsl:text>mois :</xsl:text>
	      <xsl:value-of select="concat(startdate/year,
		format-number(startdate/month, '00'))"/>
	    </xsl:attribute>
	    <xsl:call-template name="gen-long-en-month">
	      <xsl:with-param name="nummonth" select="startdate/month"/>
	    </xsl:call-template>
	    <xsl:text> </xsl:text>
	    <xsl:value-of select="startdate/year"/>
	  </h3>

	  <ul>
	    <xsl:for-each select="key('event-by-month',
	      concat(startdate/year, format-number(startdate/month, '00')))">

	      <xsl:sort select="format-number(startdate/day, '00')" order="ascending"/>
	      <xsl:apply-templates select="."/>
	    </xsl:for-each>
	  </ul>
	</xsl:for-each>

	<h2 id="past">
	  <xsl:text>Ev&#233;nements pass&#233;s :</xsl:text>
	</h2>

	<xsl:for-each select="event[generate-id() =
	  generate-id(key('event-by-month', concat(startdate/year,
	    format-number(startdate/month, '00')))[1])
	  and ((number(enddate/year) &lt; number($curdate/year)) or
	    (number(enddate/year) = number($curdate/year) and
	     number(enddate/month) &lt; number($curdate/month)) or
	    (number(enddate/year) = number($curdate/year) and
	     number(enddate/month) = number($curdate/month) and
	     number(enddate/day) &lt; number($curdate/day)))]">

	  <xsl:sort select="number(startdate/year)" order="descending"/>
	  <xsl:sort select="format-number(startdate/month, '00')" order="descending"/>
	  <xsl:sort select="format-number(startdate/day, '00')" order="descending"/>

	  <h3>
	    <xsl:attribute name="id">
	      <xsl:text>mois :</xsl:text>
	      <xsl:value-of select="concat(startdate/year,
		format-number(startdate/month, '00'))"/>
	    </xsl:attribute>
	    <xsl:call-template name="gen-long-en-month">
	      <xsl:with-param name="nummonth" select="startdate/month"/>
	    </xsl:call-template>
	    <xsl:text> </xsl:text>
	    <xsl:value-of select="startdate/year"/>
	  </h3>

	  <ul>
	    <xsl:for-each select="key('event-by-month',
	      concat(startdate/year, format-number(startdate/month, '00')))">

	      <xsl:sort select="format-number(startdate/day, '00')" order="descending"/>
	      <xsl:apply-templates select="."/>
	    </xsl:for-each>
	  </ul>
	</xsl:for-each>
	<xsl:copy-of select="$footer"/>
      </body>
    </html>
  </xsl:template>

  <!-- Template: event -->
  <xsl:template match="event">
    <li>
      <xsl:attribute name="id">
	<xsl:call-template name="generate-event-anchor"/>
      </xsl:attribute>

      <p>
	<b>
	  <xsl:if test="url">
	    <xsl:apply-templates select="url"/>
	  </xsl:if>
	  <xsl:if test="not(url)">
	    <xsl:value-of select="name"/>
	  </xsl:if>
	</b>
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
	<br/>
	<em>
	  <xsl:call-template name="gen-date-interval">
	    <xsl:with-param name="startdate" select="startdate" />
	    <xsl:with-param name="enddate" select="enddate" />
	  </xsl:call-template>
	</em><br/>
	<xsl:copy-of select="description/child::node()"/>
      </p>
      <xsl:if test="link">
	<p><xsl:apply-templates select="link"/></p>
      </xsl:if>
    </li>
  </xsl:template>

  <!-- Template: link -->
  <xsl:template match="link">
    <xsl:apply-templates select="url"/>
    <xsl:if test="not(position()=last())">
      <xsl:text>&#160;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- Template: url -->
  <xsl:template match="url">
    <a>
      <xsl:attribute name="href">
	<xsl:choose>
	  <xsl:when test="@type='freebsd-website'">
	    <xsl:value-of select="$base"/>
	  </xsl:when>
	</xsl:choose>
        <xsl:value-of select="."/>
      </xsl:attribute>
      <xsl:value-of select="../name"/>
    </a>
  </xsl:template>
</xsl:stylesheet>
