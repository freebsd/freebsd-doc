<?xml version="1.0" encoding="euc-jp" ?>

<!DOCTYPE xsl:stylesheet PUBLIC
  "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD Fragment//EN"
  "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [

<!ENTITY title "FreeBSD 関連イベント">
<!ENTITY rsslink "&enbase;/events/rss.xml">
<!ENTITY rsstitle "今後開催予定の FreeBSD 関連イベント">
]>

<!-- $FreeBSD$ -->
<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: r48669 -->

<!--  Copyright (c) 2003 Simon L. Nielsen <simon@FreeBSD.org>
      Copyright (c) 2008 Murray M Stokely <murray@FreeBSD.org>
      All rights reserved.

      Redistribution and use in source and binary forms, with or
      without modification, are permitted provided that the following
      conditions are met:

    1.  Redistributions of source code must retain the above
	copyright notice, this list of conditions and the following
	disclaimer.
    2.  Redistributions in binary form must reproduce the above
	copyright notice, this list of conditions and the following
	disclaimer in the documentation and/or other materials
	provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS''
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
    TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
    PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR
    OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
    USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
    AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns="http://www.w3.org/1999/xhtml"
  extension-element-prefixes="date">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:param name="startyear">2007</xsl:param>
  <xsl:param name="pastyears">2003 2004 2005 2006</xsl:param>

  <xsl:key name="event-by-month" match="event"
    use="concat(startdate/year, format-number(startdate/month, '00'))"/>

  <xsl:key name="event-by-country" match="event"
    use="location/country" />

  <xsl:key name="upcoming-event-by-country" match="event[((number(enddate/year) &gt; number(date:year())) or
	    (number(enddate/year) = number(date:year()) and
	     number(enddate/month) &gt; number(date:month-in-year())) or
	    (number(enddate/year) = number(date:year()) and
	    number(enddate/month) = number(date:month-in-year()) and
	    enddate/day &gt;= date:day-in-month()))]"
	    use="location/country" />

  <xsl:variable name="charturl" select="'https://chart.googleapis.com/chart?cht=t&amp;chs=400x200&amp;chtm=world&amp;chco=ffffff,ffbe38,600000&amp;chf=bg,s,4D89F9'" />

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:variable name="rsstitle">&rsstitle;</xsl:variable>

  <xsl:variable name="rsslink">&rsslink;</xsl:variable>

  <xsl:template name="process.content">
  <xsl:variable name="chart-countries">
    <xsl:for-each select="//event[
      generate-id() =
      generate-id(key('event-by-country', location/country)[1])]">
      <xsl:sort select="format-number(count(key('event-by-country', location/country)), '000')" order="descending"/>
      <xsl:value-of select="location/country/@code" />
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="chart-country-counts">
    <xsl:for-each select="//event[
      generate-id() =
      generate-id(key('event-by-country', location/country)[1])]">
      <xsl:sort select="format-number(count(key('event-by-country', location/country)), '000')" order="descending"/>
	<xsl:if test="count(key('upcoming-event-by-country', location/country)) != 0">100.0</xsl:if>
	<xsl:if test="count(key('upcoming-event-by-country', location/country)) = 0"><xsl:value-of select="count(key('event-by-country', location/country))" />.0</xsl:if>
	<xsl:if test="position()!=last()">,</xsl:if></xsl:for-each>
  </xsl:variable>

  <xsl:variable name="imageurl"><xsl:value-of select="$charturl"/>&amp;chd=t:<xsl:value-of select="$chart-country-counts"/>&amp;chld=<xsl:value-of select="$chart-countries"/></xsl:variable>

  <div id="sidewrap">
    &nav.community;
    <div id="feedlinks">
      <ul>
	<li>
	  <a href="&rsslink;" title="&rsstitle;">RSS 2.0 Feed</a>
	</li>
      </ul>
    </div> <!-- FEEDLINKS -->
  </div> <!-- SIDEWRAP -->

  <div id="contentwrap">
    <h1>&title;</h1>
    <!-- Note the current date to have a reference, if the -->
    <!-- upcoming/past events are split incorrectly.       -->

    <xsl:comment>
      <xsl:text>Generated on: </xsl:text>
	<xsl:value-of select="concat($curdate.year,
	  format-number($curdate.month, '00'),
	  format-number($curdate.day, '00'))"/>
    </xsl:comment>

    <xsl:for-each select="/events">
      <xsl:call-template name="html-events-list-preface" />

      <xsl:call-template name="html-events-map">
	<xsl:with-param name="mapurl" select="$imageurl" />
      </xsl:call-template>

      <xsl:call-template name="html-events-list-upcoming-heading" />
    </xsl:for-each>

    <xsl:for-each select="/events/event[generate-id() =
      generate-id(key('event-by-month',
      concat(startdate/year, format-number(startdate/month, '00')))[1])
      and ((number(enddate/year) &gt; number($curdate.year)) or
      (number(enddate/year) = number($curdate.year) and
      number(enddate/month) &gt; number($curdate.month)) or
      (number(enddate/year) = number($curdate.year) and
      number(enddate/month) = number($curdate.month) and
      enddate/day &gt;= $curdate.day))]">

      <xsl:sort select="startdate/year" order="ascending"/>
      <xsl:sort select="format-number(startdate/month, '00')"
	order="ascending"/>
      <xsl:sort select="format-number(startdate/day, '00')"
	order="ascending"/>

      <h3>
	<xsl:attribute name="id">
	  <xsl:text>month:</xsl:text>
	  <xsl:value-of select="concat(startdate/year,
	    format-number(startdate/month, '00'))"/>
	</xsl:attribute>

	<xsl:value-of select="startdate/year"/>
	  <xsl:text> 年 </xsl:text>
	<xsl:value-of select="startdate/month"/>

	<xsl:text> 月</xsl:text>
      </h3>

      <ul>
	<xsl:for-each select="key('event-by-month',
	  concat(startdate/year, format-number(startdate/month, '00')))">

	  <xsl:sort select="format-number(startdate/day, '00')" order="ascending"/>
	    <xsl:apply-templates select="." mode="upcoming"/>
	</xsl:for-each>
      </ul>
    </xsl:for-each>

    <xsl:for-each select="/events">
      <xsl:call-template name="html-events-list-past-heading" />
    </xsl:for-each>

    <xsl:for-each select="/events/event[generate-id() =
      generate-id(key('event-by-month', concat(startdate/year,
      format-number(startdate/month, '00')))[1])
      and ((number(enddate/year) &gt;= $startyear)) and
      ((number(enddate/year) &lt; number($curdate.year)) or
      (number(enddate/year) = number($curdate.year) and
      number(enddate/month) &lt; number($curdate.month)) or
      (number(enddate/year) = number($curdate.year) and
      number(enddate/month) = number($curdate.month) and
      number(enddate/day) &lt; number($curdate.day)))]">

      <xsl:sort select="number(startdate/year)" order="descending"/>
      <xsl:sort select="format-number(startdate/month, '00')" order="descending"/>
      <xsl:sort select="format-number(startdate/day, '00')" order="descending"/>

      <h3>
	<xsl:attribute name="id">
	  <xsl:text>month:</xsl:text>
	  <xsl:value-of select="concat(startdate/year,
	    format-number(startdate/month, '00'))"/>
	</xsl:attribute>
	<xsl:value-of select="startdate/year"/>
	  <xsl:text> 年 </xsl:text>
	  <xsl:value-of select="startdate/month"/>
	  <xsl:text> 月</xsl:text>
      </h3>

      <ul>
	<xsl:for-each select="key('event-by-month',
	  concat(startdate/year, format-number(startdate/month, '00')))">

	  <xsl:sort select="format-number(startdate/day, '00')" order="descending"/>
	  <xsl:apply-templates select="."/>
	</xsl:for-each>
      </ul>
    </xsl:for-each>

    <p>過去のイベント</p>

    <ul id="events-past-years">
      <xsl:for-each select="/events">
	<xsl:call-template name="split-string">
	  <xsl:with-param name="seperator" select="' '"/>
	  <xsl:with-param name="text" select="$pastyears"/>
	</xsl:call-template>
      </xsl:for-each>
    </ul>
  </div> <!-- contentwrap -->

  <br class="clearboth" />
</xsl:template>

<!-- Template: event -->
<xsl:template name="eventbody">
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
</xsl:template>

<!-- Template: event -->
<xsl:template match="event" mode="upcoming">
  <li>
    <xsl:call-template name="eventbody"/>
  </li>
</xsl:template>

<!-- Template: event -->
<xsl:template match="event">
  <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
  <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
  <xsl:variable name="name" select="name" />
  <xsl:variable name="lcname" select="translate($name, $upper, $lower)" />

<!--  Note that only AsiaBSDCon, DCBSDCon, MeetBSD, and NYCBSDCon have
      a significant number of videos on YouTube so we hard code them
      for now.  When we have a better track record of getting videos
      from our conferences posted to YouTube then we can implement a
      more generic solution here, but for now we don't want to add the
      link to youtube when we know in most cases there is no content
      there. -->

  <li>
    <xsl:call-template name="eventbody"/>
      <p>ソーシャルリンク : <a rel="nofollow">
	<xsl:attribute name="href">http://www.flickr.com/search/?w=all&amp;q=<xsl:value-of select="name" />&amp;m=text</xsl:attribute>
      Flickr</a>, <a rel="nofollow">
	<xsl:attribute name="href">http://blogsearch.google.com/blogsearch?q=<xsl:value-of select="name" /></xsl:attribute>Blog Search</a><xsl:if test="contains($lcname, 'meetbsd') or contains($lcname, 'nycbsdcon') or contains($lcname, 'dcbsdcon') or contains($lcname, 'asiabsdcon')">,
	<a rel="nofollow">
	<xsl:attribute name="href">http://www.youtube.com/results?search_query=bsdconferences+<xsl:value-of select="name" /></xsl:attribute>YouTube</a></xsl:if>.</p>
  </li>
</xsl:template>

<!-- Template: link -->
<xsl:template match="link">
  <xsl:apply-templates select="url"/>
  <xsl:if test="not(position()=last())">
    <xsl:text>&nbsp;</xsl:text>
  </xsl:if>
</xsl:template>

<!-- Template: url -->
<xsl:template match="url">
  <a>
    <xsl:attribute name="href">
      <xsl:if test="@type='freebsd-website'">&base;</xsl:if>
	<xsl:value-of select="."/>
    </xsl:attribute>
    <xsl:value-of select="../name"/>
  </a>
</xsl:template>

<xsl:template name="split-string">
  <xsl:param name="seperator"/>
  <xsl:param name="text"/>
  <xsl:variable name="first" select="substring-before($text, $seperator)"/>
  <xsl:choose>
    <xsl:when test="$first or substring-after($text,$seperator)">
      <xsl:if test="$first">
	<li><a>
	  <xsl:attribute name="href">events<xsl:value-of select="$first"/>.html</xsl:attribute>
	    <xsl:value-of select="$first" />
	</a></li>
      </xsl:if>
      <xsl:call-template name="split-string">
	<xsl:with-param name="text" select="substring-after($text,$seperator)"/>
	<xsl:with-param name="seperator" select="$seperator"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <li><a>
	<xsl:attribute name="href">events<xsl:value-of select="$text"/>.html</xsl:attribute>
	<xsl:value-of select="$text" />
      </a></li>
    </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
