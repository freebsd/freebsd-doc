<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:str="http://exslt.org/strings"
  extension-element-prefixes="date str"
  exclude-result-prefixes="date cvs">

  <xsl:import href="./transtable-common.xsl" />

  <xsl:variable name="svnKeyword">
    <xsl:value-of select="normalize-space(//cvs:keyword[1])"/>
  </xsl:variable>

  <xsl:variable name="date">
    <xsl:value-of select="str:split($svnKeyword, ' ')[4]"/>
  </xsl:variable>

  <!-- default format for date string -->
  <xsl:param name="param-l10n-date-format-YMD"
             select="'%Y-%M-%D'" />
  <xsl:param name="param-l10n-date-format-YM"
             select="'%M %Y'" />
  <xsl:param name="param-l10n-date-format-MD"
             select="'%D %M'" />
  <xsl:param name="param-l10n-date-format-rfc822"
             select="'%W, %D %m %Y 00:00:00 PST'" />

  <xsl:variable name="curdate.year" select="date:year()"/>
  <xsl:variable name="curdate.month" select="date:month-in-year()"/>
  <xsl:variable name="curdate.day" select="date:day-in-month()"/>

  <!--
     Used to copy HTML chunks to the output.
  -->
  <xsl:template match="*" mode="copy.html">
    <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
      <xsl:copy-of select="attribute::*"/>
      <xsl:apply-templates select="child::node()" mode="copy.html"/>
    </xsl:element>
  </xsl:template>

  <!--
     template name                               used in

     html-usergroups-map			 templates.usergroups.xsl
     html-usergroups-list-regions                templates.usergroups.xsl
     html-usergroups-list-entries                templates.usergroups.xsl
     html-usergroups-list-header                 templates.usergroups.xsl (for l10n)

     html-news-list-newsflash-preface            templates.newsflash.xsl (for l10n)
     html-news-list-newsflash                    templates.newsflash.xsl
     html-news-list-press                        templates.press.xsl
     html-news-list-datelabel                    templates.newsflash.xsl
     html-news-generate-anchor                   templates.newsflash.xsl
     html-news-make-olditems-list                templates.newsflash.xsl (for l10n)
     html-news-list-newsflash-homelink           templates.newsflash.xsl (for l10n)

     html-news-list-press-preface                templates.press.xsl (for l10n)
     html-news-list-press                        templates.press.xsl

     html-events-map			 	 templates.events.xsl (for l10n)
     html-events-list-preface                    templates.events.xsl (for l10n)
     html-events-list-upcoming-heading           templates.events.xsl (for l10n)
     html-events-list-past-heading               templates.events.xsl (for l10n)

     html-list-advisories                        security/mkindex.xsl
     html-list-advisories-putitems               security/mkindex.xsl
     html-list-advisories-release-label          security/mkindex.xsl (for l10n)
     rdf-security-advisories                     security/security-rdf.xsl
     rdf-security-advisories-title               security/security-rdf.xsl (for l10n)
     rdf-security-advisories-items               security/security-rdf.xsl

     rss-security-advisories                     security/security-rss.xsl
     rss-security-advisories-title               security/security-rss.xsl (for l10n)
     rss-security-advisories-items               security/security-rss.xsl

     rss-errata-notices				 security/errata-rss.xsl
     rss-errata-notices-title			 security/errata-rss.xsl (for l10n)
     rss-errata-notices-items			 security/errata-rss.xsl

     html-index-advisories-items                   index.xsl
     html-index-advisories-items-lastmodified      index.xsl (for i10n)
     html-index-news-project-items                 index.xsl
     html-index-news-project-items-lastmodified    index.xsl (for i10n)
     html-index-news-press-items                   index.xsl
     html-index-news-press-items-lastmodified      index.xsl (for i10n)
     html-index-events-items                       index.xsl
     html-index-mirrors-options-list               index.xsl

     misc-format-date-string                     generic
     calculate-dow                               generic

     gen-long-en-month                           templates.events.xsl
     gen-short-en-month                          templates.news-rss.xsl
     gen-date-interval                           templates.events.xsl
     generate-event-anchor                       templates.events.xsl

     generate-story-anchor                       templates.press.xsl

  -->

  <!-- template: "html-usergroups-list-regions"
       list all regions in a usergroup database -->

  <xsl:key name="html-usergroups-regions-key" match="entry" use="../../@name" />
  <xsl:key name="html-usergroups-id-key" match="entry" use="@id" />

  <xsl:template name="html-usergroups-map">
    <xsl:param name="mapurl" select="'none'" />

    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="$mapurl" />
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template name="html-usergroups-list-regions">
    <xsl:param name="usergroups.xml" select="'usergroups.xml'" />

    <ul>
      <xsl:for-each select="document($usergroups.xml)//continent">
      <xsl:sort select="format-number(count(country/entry), '000')"
      		order="descending"/>

	<xsl:variable name="id" select="
	  translate(@name,
	  ' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	  '--abcdefghijklmnopqrstuvwxyz')" />

	<li>
	  <p><xsl:element name="a">
	      <xsl:attribute name="href">
		<xsl:value-of select="concat('#', $id)" />
	      </xsl:attribute>

	      <xsl:call-template name="transtable-lookup">
		<xsl:with-param name="word-group" select="'continents'" />
		<xsl:with-param name="word" select="@name" />
	      </xsl:call-template>
	    </xsl:element>
	    ( <xsl:value-of select="count(country/entry)" /> user groups )</p>
	</li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- template: "html-usergroups-list-entries"
       list all entries in a usergroup database -->

  <xsl:template name="html-usergroups-list-entries">
    <xsl:param name="usergroups.xml" select="'usergroups.xml'" />
    <xsl:param name="usergroups-local.xml" select="'usergroups-local.xml'" />

    <xsl:for-each select="document($usergroups.xml)//continent">
      <xsl:sort select="format-number(count(country/entry), '000')"
      		order="descending"/>

      <xsl:variable name="continent" select="@name" />
      <xsl:variable name="continent-lc" select="
	translate(@name,
	' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	'--abcdefghijklmnopqrstuvwxyz')" />

      <h3><a name="{$continent-lc}" id="{$continent-lc}">
	  <xsl:call-template name="transtable-lookup">
	    <xsl:with-param name="word-group" select="'continents'" />
	    <xsl:with-param name="word" select="$continent" />
	  </xsl:call-template></a></h3>

      <dl>
        <xsl:for-each select="country/entry">

	  <xsl:variable name="id"><xsl:value-of select="@id" /></xsl:variable>

	  <xsl:variable name="name">
	    <xsl:for-each select="document($usergroups-local.xml)">
	      <xsl:choose>
		<!-- $p[count(.|$q) = count($q)] means product set of $p and $q-->
		<xsl:when test="
		  key('html-usergroups-regions-key', string($continent))
		  [count(.|key('html-usergroups-id-key', string($id)))
		  = count(key('html-usergroups-id-key', string($id)))]
		  ">
		  <xsl:copy-of select="
		    key('html-usergroups-regions-key', string($continent))
		    [count(.|key('html-usergroups-id-key', string($id)))
		    = count(key('html-usergroups-id-key', string($id)))]/name/node()
		    " />
		</xsl:when>
		<xsl:otherwise>
		  <xsl:for-each select="document($usergroups.xml)">
		    <xsl:copy-of select="key('html-usergroups-id-key', string($id))/name/node()" />
		  </xsl:for-each>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:for-each>
	  </xsl:variable>

	  <xsl:variable name="desc">
	    <xsl:for-each select="document($usergroups-local.xml)">
	      <xsl:choose>
		<!-- $p[count(.|$q) = count($q)] means product set of $p and $q-->
		<xsl:when test="
		  key('html-usergroups-regions-key', string($continent))
		  [count(.|key('html-usergroups-id-key', string($id)))
		  = count(key('html-usergroups-id-key', string($id)))]
		  ">
		  <xsl:apply-templates select="
		    key('html-usergroups-regions-key', string($continent))
		    [count(.|key('html-usergroups-id-key', string($id)))
		    = count(key('html-usergroups-id-key', string($id)))]/description/node()
		    " mode="copy.html"/>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:for-each select="document($usergroups.xml)">
		    <xsl:apply-templates select="key('html-usergroups-id-key', string($id))/description/node()" mode="copy.html"/>
		  </xsl:for-each>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:for-each>
	  </xsl:variable>

	  <dt><a name="{$continent-lc}-{$id}" href="{url}"><xsl:copy-of select="$name" /></a></dt>

	  <dd><p><xsl:copy-of select="$desc" /></p></dd>
	</xsl:for-each>
      </dl>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-usergroups-list-header"
       print header part of usergroup listing (l10n) -->

  <xsl:template name="html-usergroups-list-header">
    <p>FreeBSD's widespread popularity has spawned a number of user groups
      around the world.</p>
    <p>If you know of a FreeBSD user group not listed here,
      please fill out a <a href="https://www.FreeBSD.org/support/bugreports.html">
	problem report</a> in category Documentation->Website with the following information:</p>
    <ol>
      <li>A URL for the user group's website.</li>
      <li>An email contact address of a human in charge,
         for use by our visitors and website administrators.</li>
      <li>A short (one paragraph) description of the user group.</li>
    </ol>

    <p>Submissions should be in HTML. In keeping with the spirit of
      FreeBSD, we prefer user groups that are active and which conduct
      their business in public.  If there is no local group,
      <a
      href="http://bsd.meetup.com/">http://bsd.meetup.com/</a> can
      be used to locate interested individuals near by.  Consider
      forming your own user group!</p>

    <h3>Regions:</h3>
  </xsl:template>

  <!-- template: "calculate-dow"
       calculate the RFC822 day of the week for a given
       date between 1/1/2000 and 12/31/2099 -->

  <xsl:template name="calculate-dow">
    <xsl:param name="year" select="'none'" />
    <xsl:param name="month" select="'none'" />
    <xsl:param name="day" select="'none'" />

    <!-- whether the current year is a leap year -->
    <xsl:variable name="leap">
      <xsl:choose>
        <xsl:when test="(number($year) mod 4)=0">1</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- number of days since Jan 1 of the current year -->
    <xsl:variable name="daysthisyear">
      <xsl:choose>
        <xsl:when test="$month=1"><xsl:value-of select="number($day)"/></xsl:when>
        <xsl:when test="$month=2"><xsl:value-of select="31 + number($day)"/></xsl:when>
        <xsl:when test="$month=3"><xsl:value-of select="59 + $leap + number($day)"/></xsl:when>
        <xsl:when test="$month=4"><xsl:value-of select="90 + $leap + number($day)"/></xsl:when>
        <xsl:when test="$month=5"><xsl:value-of select="120 + $leap + number($day)"/></xsl:when>
        <xsl:when test="$month=6"><xsl:value-of select="151 + $leap + number($day)"/></xsl:when>
        <xsl:when test="$month=7"><xsl:value-of select="181 + $leap + number($day)"/></xsl:when>
        <xsl:when test="$month=8"><xsl:value-of select="212 + $leap + number($day)"/></xsl:when>
        <xsl:when test="$month=9"><xsl:value-of select="243 + $leap + number($day)"/></xsl:when>
        <xsl:when test="$month=10"><xsl:value-of select="273 + $leap + number($day)"/></xsl:when>
        <xsl:when test="$month=11"><xsl:value-of select="304 + $leap + number($day)"/></xsl:when>
        <xsl:when test="$month=12"><xsl:value-of select="334 + $leap + number($day)"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="number(0)"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- number of leap years prior to current year (after 2000). -->
    <xsl:variable name="leapyears" select="floor((number($year + 3) - 2000) div 4)"/>

    <xsl:variable name="totaldayssince2000" select="(number($year)-2000)*365 + $leapyears + $daysthisyear"/>

    <!-- 5 is constant for day of week Jan 1 2000. -->
    <xsl:variable name="dow" select="(5 + $totaldayssince2000) mod 7"/>

    <xsl:choose>
      <xsl:when test="$dow=0">Sun</xsl:when>
      <xsl:when test="$dow=1">Mon</xsl:when>
      <xsl:when test="$dow=2">Tue</xsl:when>
      <xsl:when test="$dow=3">Wed</xsl:when>
      <xsl:when test="$dow=4">Thu</xsl:when>
      <xsl:when test="$dow=5">Fri</xsl:when>
      <xsl:when test="$dow=6">Sat</xsl:when>
      <xsl:when test="$dow=7">Sun</xsl:when>
      <xsl:otherwise>???</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- template: "misc-format-date-string"
       format date string with localization if needed -->

  <xsl:template name="misc-format-date-string">
    <xsl:param name="year" select="'none'" />
    <xsl:param name="month" select="'none'" />
    <xsl:param name="day" select="'none'" />
    <xsl:param name="date-format" select="$param-l10n-date-format-YMD" />

    <xsl:param name="dow">
      <xsl:call-template name="calculate-dow">
        <xsl:with-param name="year" select="$year" />
        <xsl:with-param name="month" select="$month" />
        <xsl:with-param name="day" select="$day" />
      </xsl:call-template>
    </xsl:param>

    <xsl:param name="lmonth">
      <xsl:call-template name="transtable-lookup">
	<xsl:with-param name="word-group" select="'number-month'" />
	<xsl:with-param name="word" select="$month" />
      </xsl:call-template>
    </xsl:param>

    <xsl:param name="smonth">
      <xsl:call-template name="gen-short-en-month">
	<xsl:with-param name="nummonth" select="$month" />
      </xsl:call-template>
    </xsl:param>

    <xsl:param name="tmp-replace-year">
      <xsl:call-template name="misc-format-date-string-replace">
	<xsl:with-param name="target" select="$date-format" />
	<xsl:with-param name="before" select="'%Y'" />
	<xsl:with-param name="after" select="$year" />
      </xsl:call-template>
    </xsl:param>

    <xsl:param name="tmp-replace-day">
      <xsl:call-template name="misc-format-date-string-replace">
	<xsl:with-param name="target" select="$tmp-replace-year" />
	<xsl:with-param name="before" select="'%D'" />
	<xsl:with-param name="after" select="$day" />
      </xsl:call-template>
    </xsl:param>

    <xsl:param name="tmp-replace-day-of-week">
      <xsl:call-template name="misc-format-date-string-replace">
	<xsl:with-param name="target" select="$tmp-replace-day" />
	<xsl:with-param name="before" select="'%W'" />
	<xsl:with-param name="after" select="$dow" />
      </xsl:call-template>
    </xsl:param>

    <xsl:param name="tmp-replace-month">
      <xsl:call-template name="misc-format-date-string-replace">
	<xsl:with-param name="target" select="$tmp-replace-day-of-week" />
	<xsl:with-param name="before" select="'%M'" />
	<xsl:with-param name="after" select="$lmonth" />
      </xsl:call-template>
    </xsl:param>

    <xsl:call-template name="misc-format-date-string-replace">
      <xsl:with-param name="target" select="$tmp-replace-month" />
      <xsl:with-param name="before" select="'%m'" />
      <xsl:with-param name="after" select="$smonth" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="misc-format-date-string-replace">
    <xsl:param name="target" select="''" />
    <xsl:param name="before" select="''" />
    <xsl:param name="after" select="''" />

    <xsl:choose>
      <xsl:when test="contains($target, $before)">
	<xsl:value-of select="substring-before($target, $before)" />
	<xsl:value-of select="$after" />
	<xsl:call-template name="misc-format-date-string-replace">
	  <xsl:with-param name="target" select="substring-after($target, $before)" />
	  <xsl:with-param name="before" select="$before" />
	  <xsl:with-param name="after" select="$after" />
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$target" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- template: "html-news-make-olditems-list" -->
  <xsl:template name="html-news-make-olditems-list">
    <p>Old announcements:
      <a href="2009/index.html">2009</a>,
      <a href="2008/index.html">2008</a>,
      <a href="2007/index.html">2007</a>,
      <a href="2006/index.html">2006</a>,
      <a href="2005/index.html">2005</a>,
      <a href="2004/index.html">2004</a>,
      <a href="2003/index.html">2003</a>,
      <a href="2002/index.html">2002</a>,
      <a href="2001/index.html">2001</a>,
      <a href="2000/index.html">2000</a>,
      <a href="1999/index.html">1999</a>,
      <a href="1998/index.html">1998</a>,
      <a href="1997/index.html">1997</a>,
      <a href="1996/index.html">1996</a>,
      <a href="1993/index.html">1993</a></p>
  </xsl:template>

  <!-- template: "html-press-make-olditems-list" -->
  <xsl:template name="html-press-make-olditems-list">
    <p>Old press publications:
      <a href="2009/press.html">2009</a>,
      <a href="2008/press.html">2008</a>,
      <a href="2007/press.html">2007</a>,
      <a href="2006/press.html">2006</a>,
      <a href="2005/press.html">2005</a>,
      <a href="2004/press.html">2004</a>,
      <a href="2003/press.html">2003</a>,
      <a href="2002/press.html">2002</a>,
      <a href="2001/press.html">2001</a>,
      <a href="2000/press.html">2000</a>,
      <a href="1999/press.html">1999</a>,
      <a href="1998/press.html">1998-1996</a></p>
  </xsl:template>

  <!-- template: "html-news-list-newsflash-preface" -->
  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&base;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="FreeBSD News"/>

    <p>FreeBSD is a rapidly developing operating system.  Keeping up on
      the latest developments can be a chore!  To keep on top of things,
      check this page periodically.  News is also announced on the
      <a href="https://lists.FreeBSD.org/mailman/listinfo/freebsd-announce">freebsd-announce
	mailing list</a> and the <a href="rss.xml">RSS feed</a>.</p>

    <p>The following projects have their own news pages, which should
      be checked for project specific updates.</p>

    <ul>
      <li><a href="http://freebsd.kde.org/">KDE on FreeBSD</a></li>
      <li><a href="&base;/gnome/newsflash.html">GNOME on FreeBSD</a></li>
    </ul>

    <p>For a detailed description of past, present, and future releases,
      see the <a href="&base;/releases/index.html">Release Information</a>
      page.</p>

    <p>FreeBSD security information and a list of available
      Security Advisories are available on the
      <a href="&base;/security/">Security Information</a> page.</p>
  </xsl:template>

  <!-- template: "html-news-list-newsflash-homelink" -->
  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">News Home</a>
  </xsl:template>

  <!-- template: "html-news-list-press-preface" -->
  <xsl:template name="html-news-list-press-preface">
    <p>Please send details of any news stories featuring FreeBSD
      to <a
	href="mailto:freebsd-doc@FreeBSD.org">freebsd-doc@FreeBSD.org</a>.</p>
  </xsl:template>

  <xsl:template name="html-events-list-preface">
    <p>Please send details of any FreeBSD related events or events that
      are of interest for FreeBSD users which are not listed here
      to <a href="mailto:freebsd-doc@FreeBSD.org"
	>freebsd-doc@FreeBSD.org</a>.</p>

    <p>Users with organizational software that uses the
      iCalendar format can subscribe to the
      <a href="&base;/events/events.ics">FreeBSD events calendar</a>
      which contains all of the events listed here.</p>
  </xsl:template>

  <xsl:template name="html-events-map">
    <xsl:param name="mapurl" select="'none'" />

    <p>Countries and regions displayed in dark red on the map below
      are hosting upcoming FreeBSD-related events.  Countries that
      have hosted FreeBSD-related events in the past show up in yellow
      or orange, with darker colors representing a larger number of
      previous events.</p>

    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="$mapurl" />
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
    <h2 id="upcoming">Current/Upcoming Events:</h2>
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
    <h2 id="past">Past Events:</h2>
  </xsl:template>

  <!-- template: "html-news-list-newsflash" -->
  <xsl:template name="html-news-list-newsflash">
    <xsl:param name="news.project.xml-master" select="'none'" />
    <xsl:param name="news.project.xml" select="'none'" />

    <xsl:for-each select="document($news.project.xml-master)//descendant::year">
      <xsl:variable name="year" select="name" />

      <xsl:for-each select="month">
	<xsl:variable name="month" select="name" />

	<h1>
	  <xsl:call-template name="misc-format-date-string">
	    <xsl:with-param name="year" select="$year" />
	    <xsl:with-param name="month" select="$month" />
	    <xsl:with-param name="date-format" select="$param-l10n-date-format-YM" />
	  </xsl:call-template>
	</h1>

	<ul>
	  <xsl:for-each select="day">
	    <xsl:variable name="day" select="name" />
	    <xsl:variable name="index" select="position()" />

	    <!-- search localized items per day basis -->
	    <xsl:variable name="localizeditems"
	      select="document($news.project.xml)
	              //descendant::year[name = $year]
	              /month[name = $month]
	              /day[name = $day and position() = $index]" />

	    <xsl:choose>
	      <xsl:when test="$localizeditems">
		<!-- when localized item exists -->
		<xsl:for-each select="$localizeditems/event">
		  <xsl:variable name="anchor-position" select="position()" />

		  <li><p class="localized">
		      <a><xsl:attribute name="name">
			  <xsl:call-template name="html-news-generate-anchor">
			    <xsl:with-param name="label" select="local-name()" />
			    <xsl:with-param name="year" select="$year" />
			    <xsl:with-param name="month" select="$month" />
			    <xsl:with-param name="day" select="$day" />
			    <xsl:with-param name="pos" select="$anchor-position" />
			  </xsl:call-template>
			</xsl:attribute></a>
		      <b><xsl:call-template name="html-news-datelabel">
			  <xsl:with-param name="year" select="$year" />
			  <xsl:with-param name="month">
			    <xsl:call-template name="transtable-lookup">
			      <xsl:with-param name="word-group" select="'number-month'" />
			      <xsl:with-param name="word" select="$month" />
			    </xsl:call-template>
			  </xsl:with-param>
			  <xsl:with-param name="day" select="$day" />
			</xsl:call-template></b>
		      <!-- put localized text -->
		      <xsl:text> </xsl:text>
		      <xsl:for-each select="p">
		      <xsl:if test="position() &gt; 1"><br /><br /></xsl:if>
		      <xsl:apply-templates select="child::node()" mode="copy.html"/>
		      </xsl:for-each>
		    </p>
		  </li>
		</xsl:for-each>
	      </xsl:when>

	      <xsl:otherwise>
		<!-- when localized item does not exist -->
		<xsl:for-each select="event">
		  <xsl:variable name="anchor-position" select="position()" />

		  <li><p class="original">
		      <a><xsl:attribute name="name">
			  <xsl:call-template name="html-news-generate-anchor">
			    <xsl:with-param name="label" select="local-name()" />
			    <xsl:with-param name="year" select="$year" />
			    <xsl:with-param name="month" select="$month" />
			    <xsl:with-param name="day" select="$day" />
			    <xsl:with-param name="pos" select="$anchor-position" />
			  </xsl:call-template>
			</xsl:attribute></a>
		      <b><xsl:call-template name="html-news-datelabel">
			  <xsl:with-param name="year" select="$year" />
			  <xsl:with-param name="month">
			    <xsl:call-template name="transtable-lookup">
			      <xsl:with-param name="word-group" select="'number-month'" />
			      <xsl:with-param name="word" select="$month" />
			    </xsl:call-template>
			  </xsl:with-param>
			  <xsl:with-param name="day" select="$day" />
			</xsl:call-template></b>
		      <!-- put English text -->
		      <xsl:text> </xsl:text>
		      <xsl:for-each select="p">
		      <xsl:if test="position() &gt; 1"><br /><br /></xsl:if>
		      <xsl:apply-templates select="child::node()" mode="copy.html"/>
		      </xsl:for-each>
		    </p>
		  </li>
		</xsl:for-each>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each>
	</ul>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-news-list-press" -->
  <xsl:template name="html-news-list-press">
    <xsl:param name="news.press.xml-master" select="'none'" />
    <xsl:param name="news.press.xml" select="'none'" />

    <xsl:for-each select="document($news.press.xml-master)//descendant::year">
      <xsl:variable name="year" select="name" />

      <xsl:for-each select="month">
	<xsl:variable name="month" select="name" />

	<h1>
	  <xsl:call-template name="misc-format-date-string">
	    <xsl:with-param name="year" select="$year" />
	    <xsl:with-param name="month" select="$month" />
	    <xsl:with-param name="date-format" select="$param-l10n-date-format-YM" />
	  </xsl:call-template>
	</h1>

	<ul>
	  <xsl:for-each select="story">
	    <xsl:variable name="url"><xsl:value-of select="url"/></xsl:variable>
	    <xsl:variable name="site-url"><xsl:value-of select="site-url"/></xsl:variable>

	    <!-- search localized items per story(URL) basis -->
	    <xsl:variable name="localizeditems"
	      select="document($news.press.xml)
	              //descendant::year[name = $year]
	              /month[name = $month]
	              /story[url = $url]" />

	    <xsl:variable name="anchor-position" select="position()" />

	    <xsl:choose>
	      <xsl:when test="$localizeditems">
		<xsl:for-each select="$localizeditems">
		  <li><p>
		      <a><xsl:attribute name="name">
			  <xsl:call-template name="html-news-generate-anchor">
			    <xsl:with-param name="label" select="local-name()" />
			    <xsl:with-param name="year" select="$year" />
			    <xsl:with-param name="month" select="$month" />
			    <xsl:with-param name="pos" select="$anchor-position" />
			  </xsl:call-template>
			</xsl:attribute></a>
		      <a href="{$url}"><b><xsl:value-of select="name"/></b></a><br/>
		      <a href="{$site-url}"><xsl:value-of select="site-name"/></a>,
		      <xsl:value-of select="author"/><br/>
		      <xsl:apply-templates select="p/child::node()" mode="copy.html"/>
		    </p>
		  </li>
		</xsl:for-each>
	      </xsl:when>

	      <xsl:otherwise>
		<xsl:for-each select=".">
		  <li><p>
		      <a><xsl:attribute name="name">
			  <xsl:call-template name="html-news-generate-anchor">
			    <xsl:with-param name="label" select="local-name()" />
			    <xsl:with-param name="year" select="$year" />
			    <xsl:with-param name="month" select="$month" />
			    <xsl:with-param name="pos" select="$anchor-position" />
			  </xsl:call-template>
			</xsl:attribute></a>

		      <a href="{$url}"><b><xsl:value-of select="name"/></b></a><br/>
		      <a href="{$site-url}"><xsl:value-of select="site-name"/></a>,
		      <xsl:value-of select="author"/><br/>
		      <xsl:apply-templates select="p/child::node()" mode="copy.html"/>
		    </p>
		  </li>
		</xsl:for-each>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each>
	</ul>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-news-datelabel" -->
  <xsl:template name="html-news-datelabel">
    <xsl:param name="year" />
    <xsl:param name="month" />
    <xsl:param name="day" />

    <xsl:call-template name="misc-format-date-string">
      <xsl:with-param name="month" select="$month" />
      <xsl:with-param name="day" select="$day" />
      <xsl:with-param name="date-format" select="$param-l10n-date-format-MD" />
    </xsl:call-template>

    <xsl:text>:</xsl:text>
  </xsl:template>

  <!-- template: "generate-month-num" -->
  <xsl:template name="generate-month-num">
    <xsl:param name="month" />

    <xsl:choose>
      <xsl:when test="$month='January'">1</xsl:when>
      <xsl:when test="$month='February'">2</xsl:when>
      <xsl:when test="$month='March'">3</xsl:when>
      <xsl:when test="$month='April'">4</xsl:when>
      <xsl:when test="$month='May'">5</xsl:when>
      <xsl:when test="$month='June'">6</xsl:when>
      <xsl:when test="$month='July'">7</xsl:when>
      <xsl:when test="$month='August'">8</xsl:when>
      <xsl:when test="$month='September'">9</xsl:when>
      <xsl:when test="$month='October'">10</xsl:when>
      <xsl:when test="$month='November'">11</xsl:when>
      <xsl:when test="$month='December'">12</xsl:when>
      <xsl:otherwise>???</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- template: "html-news-generate-anchor" (for l10n) -->
  <xsl:template name="html-news-generate-anchor">
    <xsl:param name="label" />
    <xsl:param name="year" />
    <xsl:param name="month" />
    <xsl:param name="day" />
    <xsl:param name="pos" />

    <xsl:value-of select="concat(
      $label,
      format-number($year, '0000'),
      format-number($month, '00'))" />
    <xsl:if test="$label = 'event'" >
      <xsl:value-of select="format-number($day, '00')" />
    </xsl:if>
    <xsl:value-of select="format-number($pos, ':00')" />
  </xsl:template>

  <!-- template: "html-list-advisories"
       generate a list of all security advisories -->

  <xsl:template name="html-list-advisories">
    <xsl:param name="advisories.xml" select="'none'" />
    <xsl:param name="type" select="'advisory'" />

    <xsl:choose>
      <xsl:when test="$type = 'advisory'">
        <xsl:call-template name="html-list-advisories-putitems">
          <xsl:with-param name="items" select="document($advisories.xml)//advisory" />
          <xsl:with-param name="itemtype" select="'Advisory'" />
          <xsl:with-param name="prefix" select="'&ftpbase;'" />
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="$type = 'notice'">
	<xsl:call-template name="html-list-advisories-putitems">
	  <xsl:with-param name="items" select="document($advisories.xml)//notice" />
	  <xsl:with-param name="itemtype" select="'Errata Notice'" />
	  <xsl:with-param name="prefix" select="'&ftpbaseerrata;'" />
	</xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- template: "html-list-advisories-putitems"
       sub-routine to generate a list -->

  <xsl:template name="html-list-advisories-putitems">
    <xsl:param name="items" select="''" />
    <xsl:param name="itemtype" select="''" />
    <xsl:param name="prefix" select="''" />
    <xsl:param name="prefixold" select="''" />

    <xsl:if test="$items">
      <table xmlns="http://www.w3.org/1999/xhtml">
        <tr><th>Date</th><th><xsl:value-of select='$itemtype' /> name</th></tr>
        <xsl:for-each select="$items">
          <xsl:variable name="year" select="../../../name" />
          <xsl:variable name="month" select="../../name" />
          <xsl:variable name="day" select="../name" />
          <tr>
            <td class="txtdate">
	      <xsl:value-of select='
		concat(format-number($year, "####"), "-",
		format-number($month, "00"), "-",
		format-number($day, "00"))' />
            </td>
            <td>
	    <xsl:choose>
	      <xsl:when test="@type='release'">
                <i><xsl:value-of select="name" /></i>
	      </xsl:when>
	      <xsl:when test="@omithref='yes'">
		<xsl:value-of select="name" />
	      </xsl:when>
	      <xsl:otherwise>
		<a><xsl:attribute name="href">
		    <xsl:value-of select="concat($prefix, name, '.asc')" />
		  </xsl:attribute>
		  <xsl:value-of select="name" /></a>
	      </xsl:otherwise>
	    </xsl:choose>
          </td></tr>
	</xsl:for-each>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- template: "html-list-advisories-release-label"
       put label for release -->

  <xsl:template name="html-list-advisories-release-label">
    <xsl:param name="relname" select="'none'" />

    <p><xsl:value-of select="$relname" /> released.</p>
  </xsl:template>

  <!-- template: "html-index-advisories-items"
       pulls in the 6 most recent security advisories -->

  <xsl:template name="html-index-advisories-items">
    <xsl:param name="advisories.xml" select="''" />
    <xsl:param name="type" select="'advisory'" />

    <xsl:choose>
      <xsl:when test="$type = 'advisory'">
	<xsl:for-each select="document($advisories.xml)/descendant::advisory[position() &lt;= 4]">
	  <xsl:variable name="year" select="../../../name" />
          <xsl:variable name="month" select="../../name" />
          <xsl:variable name="day" select="../name" />
	<p>
	  <span class="txtdate">
	      <xsl:value-of select='
		concat(format-number($year, "####"), "-",
		format-number($month, "00"), "-",
		format-number($day, "00"))' />
	  </span><br />
	  <xsl:choose>
	    <xsl:when test="@omithref = 'yes'">
	      <xsl:value-of select="name"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <a><xsl:attribute name="href">
		  <xsl:value-of select="concat('&ftpbase;', name, '.asc')"/>
		</xsl:attribute>
		<xsl:value-of select="name"/></a>
	    </xsl:otherwise>
	  </xsl:choose>
	  </p>
	</xsl:for-each>
      </xsl:when>
      <xsl:when test="$type = 'notice'">
	<xsl:for-each select="document($advisories.xml)/descendant::notice[position() &lt;= 2]">
	<xsl:variable name="year" select="../../../name" />
	<xsl:variable name="month" select="../../name" />
	<xsl:variable name="day" select="../name" />
	<p>
	  <span class="txtdate">
	      <xsl:value-of select='
		concat(format-number($year, "####"), "-",
		format-number($month, "00"), "-",
		format-number($day, "00"))' />
	  </span><br />
	  <xsl:choose>
	    <xsl:when test="@omithref = 'yes'">
	      <xsl:value-of select="name"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <a><xsl:attribute name="href">
		  <xsl:value-of select="concat('&ftpbaseerrata;', name, '.asc')"/>
		</xsl:attribute>
		<xsl:value-of select="name"/></a>
	    </xsl:otherwise>
	  </xsl:choose>
	  </p>
	</xsl:for-each>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- template: "html-index-advisories-items-lastmodified" -->

  <xsl:template name="html-index-advisories-items-lastmodified">
    <xsl:param name="advisories.xml" select="''" />
    <xsl:param name="type" select="'advisory'" />

    <xsl:choose>
      <xsl:when test="$type = 'advisory'">
	<xsl:call-template name="misc-format-date-string">
	  <xsl:with-param name="year"
	    select="document($advisories.xml)/descendant::year[month/day/advisory[position() = 1]]/name" />
	  <xsl:with-param name="month"
	    select="document($advisories.xml)/descendant::month[day/advisory[position() = 1]]/name"/>
	  <xsl:with-param name="day"
	    select="document($advisories.xml)/descendant::day[advisory[position() = 1]]/name" />
	</xsl:call-template>
      </xsl:when>

      <xsl:when test="$type = 'notice'">
	<xsl:call-template name="misc-format-date-string">
	  <xsl:with-param name="year"
	    select="document($advisories.xml)/descendant::year[month/day/notice[position() = 1]]/name" />
	  <xsl:with-param name="month"
	    select="document($advisories.xml)/descendant::month[day/notice[position() = 1]]/name" />
	  <xsl:with-param name="day"
	    select="document($advisories.xml)/descendant::day[notice[position() = 1]]/name" />
	</xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- template: "rdf-security-advisories"
       generate a rdf of 10 most recent security advisories -->

  <xsl:template name="rdf-security-advisories">
    <xsl:param name="advisories.xml" select="''" />

    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	     xmlns="http://my.netscape.com/rdf/simple/0.9/">

      <xsl:call-template name="rdf-security-advisories-title" />

      <xsl:call-template name="rdf-security-advisories-items">
	<xsl:with-param name="advisories.xml" select="$advisories.xml" />
      </xsl:call-template>
    </rdf:RDF>
  </xsl:template>

  <!-- template: "rdf-security-advisories-title"
       generate title for the security advisories rdf -->

  <xsl:template name="rdf-security-advisories-title"
                xmlns="http://my.netscape.com/rdf/simple/0.9/">
    <channel>
      <title>FreeBSD Security Advisories</title>
      <link>https://www.FreeBSD.org/security/</link>
      <description>Security advisories published from the FreeBSD Project</description>
    </channel>
  </xsl:template>

  <!-- template: "rdf-security-advisories-items"
       pulls in the 10 most recent security advisories -->

  <xsl:template name="rdf-security-advisories-items"
                xmlns="http://my.netscape.com/rdf/simple/0.9/">
    <xsl:param name="advisories.xml" select="''" />

    <xsl:for-each select="document($advisories.xml)/descendant::advisory[position() &lt;= 10]">
      <item>
	<title><xsl:value-of select="name"/></title>
	<xsl:choose>
	  <xsl:when test="@omithref = 'yes'">
	    <xsl:value-of select="name"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <link><xsl:value-of select="concat('&ftpbase;', name, '.asc')" /></link>
	  </xsl:otherwise>
	</xsl:choose>

      </item>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "rss-security-advisories"
       generate a rdf of 10 most recent security advisories -->

  <xsl:template name="rss-security-advisories">
    <xsl:param name="advisories.xml" select="''" />

    <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
      <channel>
        <xsl:call-template name="rss-security-advisories-title">
	  <xsl:with-param name="advisories.xml" select="$advisories.xml" />
        </xsl:call-template>
        <xsl:call-template name="rss-security-advisories-items">
	  <xsl:with-param name="advisories.xml" select="$advisories.xml" />
        </xsl:call-template>
      </channel>
    </rss>

  </xsl:template>

  <!-- template: "rss-security-advisories-title"
       pulls in the 10 most recent security advisories -->

  <xsl:template name="rss-security-advisories-title"
                xmlns:atom="http://www.w3.org/2005/Atom">
    <xsl:param name="advisories.xml" select="''" />

    <xsl:variable name="title">FreeBSD Security Advisories</xsl:variable>
    <xsl:variable name="link">https://www.FreeBSD.org/security/</xsl:variable>

    <title><xsl:value-of select="$title" /></title>
    <link><xsl:value-of select="$link" /></link>
    <description>Security advisories published from the FreeBSD Project</description>
    <language>en-us</language>
    <webMaster>secteam@FreeBSD.org (FreeBSD Security Team)</webMaster>
    <managingEditor>secteam@FreeBSD.org (FreeBSD Security Team)</managingEditor>
    <docs>http://blogs.law.harvard.edu/tech/rss</docs>
    <ttl>120</ttl>
    <image>
      <url>https://www.FreeBSD.org/logo/logo-full.png</url>
      <title><xsl:value-of select="$title" /></title>
      <link><xsl:value-of select="$link" /></link>
    </image>
    <atom:link rel="self" type="application/rss+xml">
      <xsl:attribute name="href">
        <xsl:value-of select="$link" /><xsl:text>rss.xml</xsl:text>
      </xsl:attribute>
    </atom:link>
  </xsl:template>

  <!-- template: "rss-security-advisories-items"
       pulls in the 10 most recent security advisories -->

  <xsl:template name="rss-security-advisories-items"
                xmlns:atom="http://www.w3.org/2005/Atom">
    <xsl:param name="advisories.xml" select="''" />

    <xsl:for-each select="document($advisories.xml)/descendant::advisory[position() &lt;= 10]">
      <item>
	<title><xsl:value-of select="name"/></title>
	<xsl:choose>
	  <xsl:when test="@omithref = 'yes'">
	    <link>https://www.FreeBSD.org/security</link>
	  </xsl:when>
	  <xsl:otherwise>
	    <link><xsl:value-of select="concat('https:', '&ftpbase;', name, '.asc')" /></link>
	  </xsl:otherwise>
	</xsl:choose>
        <guid><xsl:value-of select="concat('https:', '&ftpbase;', name, '.asc')" /></guid>
        <pubDate>
          <xsl:call-template name="misc-format-date-string">
            <xsl:with-param name="year" select="../../../name" />
            <xsl:with-param name="month" select="../../name" />
            <xsl:with-param name="day" select="../name" />
            <xsl:with-param name="date-format" select="$param-l10n-date-format-rfc822" />
          </xsl:call-template>
        </pubDate>
      </item>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "rss-errata-notices"
       generate a rdf of 10 most recent errata notices -->

  <xsl:template name="rss-errata-notices">
    <xsl:param name="notices.xml" select="''" />

    <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
      <channel>
        <xsl:call-template name="rss-errata-notices-title">
	  <xsl:with-param name="notices.xml" select="$notices.xml" />
        </xsl:call-template>
        <xsl:call-template name="rss-errata-notices-items">
	  <xsl:with-param name="notices.xml" select="$notices.xml" />
        </xsl:call-template>
      </channel>
    </rss>

  </xsl:template>

  <!-- template: "rss-errata-notices-title"
       pulls in the 10 most recent errata notices -->

  <xsl:template name="rss-errata-notices-title"
                xmlns:atom="http://www.w3.org/2005/Atom">
    <xsl:param name="notices.xml" select="''" />

    <xsl:variable name="title">FreeBSD Errata Notices</xsl:variable>
    <xsl:variable name="link">https://www.FreeBSD.org/security/</xsl:variable>

    <title><xsl:value-of select="$title" /></title>
    <link><xsl:value-of select="$link" /></link>
    <description>Errata notices published from the FreeBSD Project</description>
    <language>en-us</language>
    <webMaster>secteam@FreeBSD.org (FreeBSD Security Team)</webMaster>
    <managingEditor>secteam@FreeBSD.org (FreeBSD Security Team)</managingEditor>
    <docs>http://blogs.law.harvard.edu/tech/rss</docs>
    <ttl>120</ttl>
    <image>
      <url>https://www.FreeBSD.org/logo/logo-full.png</url>
      <title><xsl:value-of select="$title" /></title>
      <link><xsl:value-of select="$link" /></link>
    </image>
    <atom:link type="application/rss+xml">
      <xsl:attribute name="href">
        <xsl:value-of select="$link" /><xsl:text>rss.xml</xsl:text>
      </xsl:attribute>
    </atom:link>
  </xsl:template>

  <!-- template: "rss-errata-notices-items"
       pulls in the 10 most recent errata notices -->

  <xsl:template name="rss-errata-notices-items"
                xmlns:atom="http://www.w3.org/2005/Atom">
    <xsl:param name="notices.xml" select="''" />

    <xsl:for-each select="document($notices.xml)/descendant::notice[position() &lt;= 10]">
      <item>
	<title><xsl:value-of select="name"/></title>
	<xsl:choose>
	  <xsl:when test="@omithref = 'yes'">
	    <link>https://www.FreeBSD.org/security</link>
	  </xsl:when>
	  <xsl:otherwise>
	    <link><xsl:value-of select="concat('https:', '&ftpbase;', name, '.asc')" /></link>
	  </xsl:otherwise>
	</xsl:choose>
        <guid><xsl:value-of select="concat('https:', '&ftpbase;', name, '.asc')" /></guid>
        <pubDate>
          <xsl:call-template name="misc-format-date-string">
            <xsl:with-param name="year" select="../../../name" />
            <xsl:with-param name="month" select="../../name" />
            <xsl:with-param name="day" select="../name" />
            <xsl:with-param name="date-format" select="$param-l10n-date-format-rfc822" />
          </xsl:call-template>
        </pubDate>
      </item>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-index-news-project-items"
       pulls in the 6 most recent project items -->

  <xsl:template name="html-index-news-project-items">
    <xsl:param name="news.project.xml-master" select="'none'" />
    <xsl:param name="news.project.xml" select="'none'" />

    <xsl:for-each select="document($news.project.xml-master)/descendant::day[position() &lt;= 6]">
      <xsl:variable name="year" select="ancestor::year/name" />
      <xsl:variable name="month" select="ancestor::month/name" />
      <xsl:variable name="day" select="name" />

      <!-- search localized items per day basis -->
      <xsl:variable name="localizeditems"
	select="document($news.project.xml)
	//descendant::year[name = $year]
	/month[name = $month]
	/day[name = $day]" />

      <xsl:choose>
	<xsl:when test="$localizeditems/event">
	  <xsl:for-each select="$localizeditems/event">
	    <xsl:variable name="anchor-position" select="position()" />

	    <p>
	    <span class="txtdate">
		<xsl:value-of select='
		  concat(format-number($year, "####"), "-",
		  format-number($month, "00"), "-",
		  format-number($day, "00"))' />
	    </span><br />
	    <a>
	      <xsl:attribute name="href">
		<xsl:choose>
		  <xsl:when test="$news.project.xml = $news.project.xml-master">&enbase;/</xsl:when>
		  <xsl:otherwise>&base;/</xsl:otherwise>
		</xsl:choose>
		<xsl:text>news/newsflash.html#</xsl:text>
		<xsl:call-template name="html-news-generate-anchor">
		  <xsl:with-param name="label" select="'event'" />
		  <xsl:with-param name="year" select="$year" />
		  <xsl:with-param name="month" select="$month" />
		  <xsl:with-param name="day" select="$day" />
		  <xsl:with-param name="pos" select="$anchor-position" />
		</xsl:call-template>
	      </xsl:attribute>

	      <xsl:choose>
		<xsl:when test="count(child::title)">
		  <xsl:value-of select="title"/><br/>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="p"/><br/>
		</xsl:otherwise>
	      </xsl:choose>
	    </a>
	    </p>
	  </xsl:for-each>
	</xsl:when>

	<xsl:otherwise>
	  <xsl:for-each select="event">
	    <xsl:variable name="anchor-position" select="position()" />

	    <p>
	    <span class="txtdate">
	      <xsl:value-of select='
		  concat(format-number($year, "####"), "-",
		  format-number($month, "00"), "-",
		  format-number($day, "00"))' />
	    </span><br />
	    <a>
	      <xsl:attribute name="href">
		<xsl:text>news/newsflash.html#</xsl:text>
		<xsl:call-template name="html-news-generate-anchor">
		  <xsl:with-param name="label" select="'event'" />
		  <xsl:with-param name="year" select="$year" />
		  <xsl:with-param name="month" select="$month" />
		  <xsl:with-param name="day" select="$day" />
		  <xsl:with-param name="pos" select="$anchor-position" />
		</xsl:call-template>
	      </xsl:attribute>

	      <xsl:choose>
		<xsl:when test="count(child::title)">
		  <xsl:value-of select="title"/><br/>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="p"/><br/>
		</xsl:otherwise>
	      </xsl:choose>
	    </a>
	    </p>
	  </xsl:for-each>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-index-news-project-items-lastmodified" -->

  <xsl:template name="html-index-news-project-items-lastmodified">
    <xsl:param name="news.project.xml-master" select="''" />

    <xsl:call-template name="misc-format-date-string">
      <xsl:with-param name="year"
	select="document($news.project.xml-master)/descendant::year[position() = 1]/name" />
      <xsl:with-param name="month"
	select="document($news.project.xml-master)/descendant::month[position() = 1]/name" />
      <xsl:with-param name="day"
	select="document($news.project.xml-master)/descendant::day[position() = 1]/name" />
    </xsl:call-template>
  </xsl:template>

  <!-- template: "html-index-news-press-items"
       pulls in the 6 most recent press items -->

  <xsl:template name="html-index-news-press-items">
    <xsl:param name="news.press.xml-master" select="'none'" />
    <xsl:param name="news.press.xml" select="''" />

    <xsl:for-each select="document($news.press.xml-master)/descendant::story[position() &lt;= 6]">
      <xsl:variable name="year" select="../../name" />
      <xsl:variable name="month" select="../name" />
      <xsl:variable name="day" select="../name" />
      <xsl:variable name="url" select="url" />
      <xsl:variable name="site-url" select="site-url" />

      <xsl:variable name="pos">
	<xsl:for-each select="../story">
	  <xsl:if test="url = $url">
	    <xsl:value-of select="position()" />
	  </xsl:if>
	</xsl:for-each>
      </xsl:variable>

      <!-- search localized items per story(URL) basis -->
      <xsl:variable name="localizeditems"
	select="document($news.press.xml)
	//descendant::year[name = $year]
	/month[name = $month]
	/story[url = $url]" />

      <p>
      <span class="txtdate">
	<xsl:value-of select='
	    concat(format-number($year, "####"), "-",
	    format-number($month, "00"))' />
      </span><br />
      <a>
	<xsl:attribute name="href">
	  <xsl:choose>
	    <xsl:when test="$news.press.xml = $news.press.xml-master">&enbase;/</xsl:when>
	    <xsl:otherwise>&base;/</xsl:otherwise>
	  </xsl:choose>
	  <xsl:text>news/press.html#</xsl:text>
	  <xsl:call-template name="html-news-generate-anchor">
	    <xsl:with-param name="label" select="'story'" />
	    <xsl:with-param name="year" select="$year" />
	    <xsl:with-param name="month" select="$month" />
	    <xsl:with-param name="pos" select="$pos" />
	  </xsl:call-template>
	</xsl:attribute>

	<xsl:choose>
	  <xsl:when test="$localizeditems">
	    <xsl:value-of select="$localizeditems/name"/>
	  </xsl:when>

	  <xsl:otherwise>
	    <xsl:value-of select="name"/>
	  </xsl:otherwise>
	</xsl:choose>
      </a></p>

    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-index-news-press-items-lastmodified" -->

  <xsl:template name="html-index-news-press-items-lastmodified">
    <xsl:param name="news.press.xml-master" select="''" />

    <xsl:call-template name="misc-format-date-string">
      <xsl:with-param name="year"
	select="document($news.press.xml-master)/descendant::year[position() = 1]/name" />
      <xsl:with-param name="month"
	select="document($news.press.xml-master)/descendant::month[position() = 1]/name" />
      <xsl:with-param name="date-format"
	select="$param-l10n-date-format-YM" />
    </xsl:call-template>
  </xsl:template>

  <!-- template: "html-index-navigation-link-list"
       generates navigation bar in index.html -->

  <xsl:template name="html-index-navigation-link-list">
    <xsl:param name="navigation.xml" select="''" />
    <xsl:for-each select="document($navigation.xml)/navigation/category">
      <p>
	<xsl:choose>
	  <xsl:when test="boolean(@src)">
	  <a>
	    <xsl:attribute name="href">
	      <xsl:choose>
		<xsl:when test="@path = 'base'">&base;/</xsl:when>
		<xsl:when test="@path = 'enbase'">&enbase;/</xsl:when>
	      </xsl:choose>
	      <xsl:value-of select="@src"/>
	    </xsl:attribute>
	    <font size="+1" color="#990000"><b><xsl:value-of select="@name"/></b></font>
	  </a>
	  </xsl:when>

	  <xsl:otherwise>
	    <font size="+1" color="#990000"><b><xsl:value-of select="@name"/></b></font>
	  </xsl:otherwise>
	</xsl:choose>
	<br/>
	<small>
	  <xsl:apply-templates select="link"/>
	</small>
      </p>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "link" generates links inside of category -->
  <xsl:template match="link">
    &leadingmark;
    <a>
      <xsl:attribute name="href">
	<xsl:choose>
	  <xsl:when test="@path = 'base'">&base;/</xsl:when>
	  <xsl:when test="@path = 'enbase'">&enbase;/</xsl:when>
	</xsl:choose>
	<xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:value-of select="@name"/></a><br/>
  </xsl:template>

 <!-- template: "html-index-events-items"
       pulls in the 5 most recent events items -->

  <xsl:template name="html-index-events-items">
    <xsl:param name="events.xml-master" select="'none'" />
    <xsl:param name="events.xml" select="''" />

    <xsl:for-each select="document($events.xml-master)/descendant::event[
									   ((number(enddate/year) &gt; number($curdate.year)) or
								            (number(enddate/year) = number($curdate.year) and
								             number(enddate/month) &gt; number($curdate.month)) or
						          		    (number(enddate/year) = number($curdate.year) and
								             number(enddate/month) = number($curdate.month) and
						   	            	     enddate/day &gt;= $curdate.day))]">
      <xsl:sort select="startdate/year" order="ascending"/>
      <xsl:sort select="format-number(startdate/month, '00')" order="ascending"/>
      <xsl:sort select="format-number(startdate/day, '00')" order="ascending"/>

      <xsl:if test="position() &lt;= 5">

      <p>
      <span class="txtdate">
         <xsl:value-of select='
	    concat(format-number(startdate/year, "####"), "-",
	    format-number(startdate/month, "00"), "-",
	    format-number(startdate/day, "00"), " -  ",
	    format-number(enddate/year, "####"), "-",
	    format-number(enddate/month, "00"), "-",
	    format-number(enddate/day, "00"))' />
      </span><br />
      <a>
        <xsl:attribute name="href">
	  <xsl:choose>
	    <xsl:when test="$events.xml = $events.xml-master">&enbase;/</xsl:when>
	    <xsl:otherwise>&base;/</xsl:otherwise>
	  </xsl:choose>
	  <xsl:text>events/#</xsl:text>
	  <xsl:call-template name="generate-event-anchor"/>
        </xsl:attribute>

        <xsl:value-of select="name"/>

	<br />
	<xsl:if test="location/city!='' and location/country!=''">
	  (<xsl:value-of select='location/city' />, <xsl:value-of select='location/country' />)
	</xsl:if>
      </a></p>
    </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-index-mirrors-options-list"
       generates mirror sites list in index.html -->

  <xsl:template name="html-index-mirrors-options-list">
    <xsl:param name="mirrors.xml" select="''" />

    <xsl:choose>
      <xsl:when test="$mirrors.xml = ''">
	<option value="NONE">
	  **No Data**
	</option>
      </xsl:when>

      <xsl:otherwise>
	<xsl:for-each select="document($mirrors.xml)/mirrors/entry[
                              (not(country/@role) or country/@role != 'primary') and
                              host[@type = 'www']/url[@proto = 'httpv6']]">
	  <xsl:sort select="country/@sortkey" data-type="number" />
	  <xsl:sort select="country" />

	  <xsl:for-each select="host[@type = 'www']/url[@proto = 'httpv6']">
	    <option><xsl:attribute name="value"><xsl:value-of select="." /></xsl:attribute>
	      <xsl:choose>
		<xsl:when test="last() = 1">
		  <xsl:value-of select="concat('IPv6 ', ../../country)" />
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="concat('IPv6 ', ../../country, '/', position())" />
		</xsl:otherwise>
	      </xsl:choose>
	    </option>
	  </xsl:for-each>
	</xsl:for-each>

	<xsl:for-each select="document($mirrors.xml)/mirrors/entry[
                              (not(country/@role) or country/@role != 'primary') and
                              host[@type = 'www']/url[@proto = 'http']]">
	  <xsl:sort select="country/@sortkey" data-type="number" />
	  <xsl:sort select="country" />

	  <xsl:for-each select="host[@type = 'www']/url[@proto = 'http']">
	    <option><xsl:attribute name="value"><xsl:value-of select="." /></xsl:attribute>
	      <xsl:choose>
		<xsl:when test="last() = 1">
		  <xsl:value-of select="../../country" />
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="concat(../../country, '/', position())" />
		</xsl:otherwise>
	      </xsl:choose>
	    </option>
	  </xsl:for-each>
	</xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Generate a unique anchor for this event. -->
  <xsl:template name="generate-event-anchor">
    <xsl:text>event</xsl:text>
    <xsl:value-of select="ancestor::year/name"/>
    <xsl:value-of select="ancestor::month/name"/>
    <xsl:value-of select="ancestor::day/name"/>:<xsl:value-of select="count(preceding-sibling::event)"/>
  </xsl:template>

  <!-- Generate a unique anchor for this story -->
  <xsl:template name="generate-story-anchor">
    <xsl:text>story</xsl:text>
    <xsl:value-of select="ancestor::year/name"/>
    <xsl:value-of select="ancestor::month/name"/>:<xsl:text/>
    <xsl:value-of select="count(following-sibling::story)"/>
  </xsl:template>

  <!-- Convert a month number to the corresponding long English name. -->
  <xsl:template name="gen-long-en-month">
    <xsl:param name="nummonth"/>
    <xsl:variable name="month" select="number($nummonth)"/>
    <xsl:choose>
      <xsl:when test="$month=1">January</xsl:when>
      <xsl:when test="$month=2">February</xsl:when>
      <xsl:when test="$month=3">March</xsl:when>
      <xsl:when test="$month=4">April</xsl:when>
      <xsl:when test="$month=5">May</xsl:when>
      <xsl:when test="$month=6">June</xsl:when>
      <xsl:when test="$month=7">July</xsl:when>
      <xsl:when test="$month=8">August</xsl:when>
      <xsl:when test="$month=9">September</xsl:when>
      <xsl:when test="$month=10">October</xsl:when>
      <xsl:when test="$month=11">November</xsl:when>
      <xsl:when test="$month=12">December</xsl:when>
      <xsl:otherwise>Invalid month</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Convert a month number to the corresponding short English name. -->
  <xsl:template name="gen-short-en-month">
    <xsl:param name="nummonth"/>
    <xsl:variable name="month" select="number($nummonth)"/>
    <xsl:choose>
      <xsl:when test="$month=1">Jan</xsl:when>
      <xsl:when test="$month=2">Feb</xsl:when>
      <xsl:when test="$month=3">Mar</xsl:when>
      <xsl:when test="$month=4">Apr</xsl:when>
      <xsl:when test="$month=5">May</xsl:when>
      <xsl:when test="$month=6">Jun</xsl:when>
      <xsl:when test="$month=7">Jul</xsl:when>
      <xsl:when test="$month=8">Aug</xsl:when>
      <xsl:when test="$month=9">Sep</xsl:when>
      <xsl:when test="$month=10">Oct</xsl:when>
      <xsl:when test="$month=11">Nov</xsl:when>
      <xsl:when test="$month=12">Dec</xsl:when>
      <xsl:otherwise>Invalid month</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Generate a date interval. -->
  <!-- Sample: 27 November, 2002 - 29 December, 2003 -->
  <xsl:template name="gen-date-interval">
    <xsl:param name="startdate"/>
    <xsl:param name="enddate"/>

    <xsl:value-of select="startdate/day"/>

    <xsl:if test="number(startdate/month) != number(enddate/month) or
		  number(startdate/day) != number(enddate/day) or
		  number(startdate/year) != number(enddate/year)">

      <xsl:if test="number(startdate/month) != number(enddate/month) or
		    number(startdate/year) != number(enddate/year)">
	<xsl:text> </xsl:text>
	<xsl:call-template name="gen-long-en-month">
	  <xsl:with-param name="nummonth" select="startdate/month"/>
	</xsl:call-template>
      </xsl:if>

      <xsl:if test="number(startdate/year) != number(enddate/year)">
	<xsl:text>, </xsl:text>
	<xsl:value-of select="startdate/year"/>
      </xsl:if>
      <xsl:text> - </xsl:text>

      <xsl:if test="number(startdate/day) != number(enddate/day) or
		    number(startdate/month) != number(enddate/month) or
		    number(startdate/year) != number(enddate/year)">
	<xsl:value-of select="enddate/day"/>
      </xsl:if>
    </xsl:if>

    <xsl:text> </xsl:text>
    <xsl:call-template name="gen-long-en-month">
      <xsl:with-param name="nummonth" select="enddate/month"/>
    </xsl:call-template>

    <xsl:text>, </xsl:text>
    <xsl:value-of select="enddate/year"/>
  </xsl:template>

  <!-- Generate sitemap -->
  <xsl:template name="html-sitemap">
    <!--
          We iterate over all categories and list all the sitemap
          items that are enumerated for that category.
          Listing is not done in alphabetical order but in
          document order so that items can be arranged in a
          logical order.
    -->

    <dl>
      <xsl:for-each select="/sitemap/category">
        <dt><strong><xsl:value-of select="@name"/></strong></dt>

        <dd>
          <xsl:for-each select="item">
            <a>
              <xsl:attribute name="href">
                <xsl:value-of select="destination"/>
              </xsl:attribute>

              <xsl:value-of select="text"/>
            </a>
          </xsl:for-each>
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>

  <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

  <!-- Generate index toc -->
  <xsl:template name="html-index-toc">
    <!--
          First we make a toc by iterating over the index terms.
          We need one entry per initial letter so this is done
          by using a key and only processing the first term for
          each initial letter.  For each initial letter, we emit
          a link that will point to entries beginning with that letter.
    -->

    <a name="toc"></a>

    <table border="4">
      <tr>
        <xsl:for-each select="/sitemap/term">
          <xsl:sort select="text"/>

          <xsl:variable name="firstLetter" select="translate(substring(text, 1, 1), $lowercase, $uppercase)"/>

          <xsl:if test="generate-id(.) = generate-id(key('indexLetter', $firstLetter)[1])">
            <td><a>
              <xsl:attribute name="href">
                <xsl:value-of select="concat('#', $firstLetter)"/>
              </xsl:attribute>

              <xsl:value-of select="$firstLetter"/>
            </a></td>
          </xsl:if>
        </xsl:for-each>
      </tr>
    </table>
  </xsl:template>

  <!-- Generate index -->
  <xsl:template name="html-index">
    <!--
          Then we need to generate the actual entries but grouped by their
          initial letter.  The same method is used here as above:
          take the first entry of each initial letter; it gives us the
          letter.  And then, we do another iteration but only process
          those terms that begin with the current letter and emit
          an unordered list of them.
    -->

    <xsl:for-each select="/sitemap/term">
      <xsl:sort select="text"/>

      <xsl:variable name="firstLetter" select="translate(substring(text, 1, 1), $lowercase, $uppercase)"/>

      <xsl:if test="generate-id(.) = generate-id(key('indexLetter', $firstLetter)[1])">
        <h2><a href="#toc" name="{$firstLetter}">
          <xsl:value-of select="$firstLetter"/>
        </a></h2>

        <ul>
          <xsl:for-each select="/sitemap/term[translate(substring(text, 1, 1), $lowercase, $uppercase) = $firstLetter]">
            <xsl:sort select="text"/>

            <li><a>
              <xsl:attribute name="href">
                <xsl:value-of select="destination"/>
              </xsl:attribute>

              <xsl:value-of select="text"/>
            </a></li>
          </xsl:for-each>
        </ul>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
