<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/share/sgml/includes.misc.xsl,v 1.21 2005/04/19 21:20:55 brueffer Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:param name="leadingmark" select="'&#183; '"/>

  <!-- Often used trademarks -->
  <xsl:variable name="unix" select="'UNIX&#174;'"/>
  <xsl:variable name="java" select="'Java&#8482;'"/>
  <xsl:variable name="jdk" select="'JDK&#8482;'"/>
  <xsl:variable name="posix" select="'POSIX&#174;'"/>

  <!-- for security advisories -->
  <xsl:variable name="ftpbase"
                select="'ftp://ftp.FreeBSD.org/pub/FreeBSD/CERT/advisories/'"/>
  <xsl:variable name="ftpbaseold"
                select="'ftp://ftp.FreeBSD.org/pub/FreeBSD/CERT/advisories/old/'"/>

  <!-- for errata notices -->
  <xsl:variable name="ftpbaseerrata"
                select="'ftp://ftp.FreeBSD.org/pub/FreeBSD/ERRATA/notices/'"/>

  <!-- default format for date string -->
  <xsl:param name="param-l10n-date-format-YMD"
             select="'%D %M, %Y'" />
  <xsl:param name="param-l10n-date-format-YM"
             select="'%M %Y'" />
  <xsl:param name="param-l10n-date-format-MD"
             select="'%D %M'" />

  <!--
     template name                               used in

     html-usergroups-list-regions                templates.usergroups.xsl
     html-usergroups-list-entries                templates.usergroups.xsl
     html-usergroups-list-header                 templates.usergroups.xsl (for l10n)

     html-news-list-newsflash                    news/newsflash.xsl
     html-news-list-press                        news/press.xsl
     html-news-list-datelabel                    news/newsflash.xsl
     html-news-generate-anchor                   news/newsflash.xsl
     html-news-make-olditems-list                news/newsflash.xsl (for l10n)

     html-list-advisories                        security/mkindex.xsl
     html-list-advisories-putitems               security/mkindex.xsl
     html-list-advisories-release-label          security/mkindex.xsl (for l10n)
     rdf-security-advisories                     security/security-rdf.xsl
     rdf-security-advisories-title               security/security-rdf.xsl (for l10n)
     rdf-security-advisories-items               security/security-rdf.xsl

     html-index-advisories-items                 index.xsl
     html-index-advisories-items-lastmodified    index.xsl (for i10n)
     html-index-news-project-items               index.xsl
     html-index-news-project-items-lastmodified  index.xsl (for i10n)
     html-index-news-press-items                 index.xsl
     html-index-news-press-items-lastmodified    index.xsl (for i10n)
     html-index-mirrors-options-list             index.xsl

     misc-format-date-string                     generic
  -->

  <!-- template: "html-usergroups-list-regions"
       list all regions in a usergroup database -->

  <xsl:key name="html-usergroups-regions-key" match="entry" use="@continent" />

  <xsl:template name="html-usergroups-list-regions">
    <xsl:param name="usergroups.xml" select="'usergroups.xml'" />

    <ul>
      <xsl:for-each select="document($usergroups.xml)//entry[
	generate-id() =
	generate-id(key('html-usergroups-regions-key', @continent)[1])]">

	<xsl:param name="id" select="
	  translate(@continent,
	  ' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	  '--abcdefghijklmnopqrstuvwxyz')" />

	<li>
	  <p><xsl:element name="a">
	      <xsl:attribute name="href">
		<xsl:value-of select="concat('#', $id)" />
	      </xsl:attribute>

	      <xsl:call-template name="transtable-lookup">
		<xsl:with-param name="word-group" select="'continents'" />
		<xsl:with-param name="word" select="@continent" />
	      </xsl:call-template>
	    </xsl:element></p>
	</li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- template: "html-usergroups-list-entries"
       list all entries in a usergroup database -->

  <xsl:template name="html-usergroups-list-entries">
    <xsl:param name="usergroups.xml" select="'usergroups.xml'" />

    <xsl:for-each select="document($usergroups.xml)//entry[
      generate-id() =
      generate-id(key('html-usergroups-regions-key', @continent)[1])]">

      <xsl:param name="id" select="
	translate(@continent,
	' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	'--abcdefghijklmnopqrstuvwxyz')" />

      <h3><a name="{$id}" id="{$id}"><xsl:call-template name="transtable-lookup">
	    <xsl:with-param name="word-group" select="'continents'" />
	    <xsl:with-param name="word" select="@continent" />
	  </xsl:call-template></a></h3>

      <dl>
	<xsl:for-each select="key('html-usergroups-regions-key', @continent)">
	  <xsl:sort select="name" order="ascending"/>

	  <dt><a name="{$id}-{@id}" href="{url}"><xsl:value-of select="name" /></a></dt>

	  <dd><p><xsl:value-of select="description" /></p></dd>
	</xsl:for-each>
      </dl>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-usergroups-list-header"
       print header part of usergroup listing (l10n) -->

  <xsl:template name="html-usergroups-list-header">
    <p>FreeBSD's widespread popularity has spawned a number of user groups
      around the world.  If you know of a FreeBSD user group not listed here,
      please fill out a <a href="http://www.freebsd.org/send-pr.html">
	problem report</a> for category www.  Submissions should be in HTML
      and must offer a short description.</p>

    <h3>Regions:</h3>

    <xsl:call-template name="html-usergroups-list-regions" />
  </xsl:template>

  <!-- template: "misc-format-date-string"
       format date string with localization if needed -->

  <xsl:template name="misc-format-date-string">
    <xsl:param name="year" select="'none'" />
    <xsl:param name="month" select="'none'" />
    <xsl:param name="day" select="'none'" />
    <xsl:param name="date-format" select="$param-l10n-date-format-YMD" />

    <xsl:param name="lmonth">
      <xsl:call-template name="transtable-lookup">
	<xsl:with-param name="word-group" select="'number-month'" />
	<xsl:with-param name="word" select="$month" />
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

    <xsl:call-template name="misc-format-date-string-replace">
      <xsl:with-param name="target" select="$tmp-replace-day" />
      <xsl:with-param name="before" select="'%M'" />
      <xsl:with-param name="after" select="$lmonth" />
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
      <a href="2003/index.html">2003</a>,
      <a href="2002/index.html">2002</a>,
      <a href="2001/index.html">2001</a>,
      <a href="2000/index.html">2000</a>,
      <a href="1999/index.html">1999</a>,
      <a href="1998/index.html">1998</a>,
      <a href="1997/index.html">1997</a>,
      <a href="1996/index.html">1996</a></p>
  </xsl:template>

  <!-- template: "html-news-list-newsflash" -->
  <xsl:template name="html-news-list-newsflash">
    <xsl:param name="news.project.xml-master" select="'none'" />
    <xsl:param name="news.project.xml" select="'none'" />

    <xsl:for-each select="document($news.project.xml-master)//descendant::year">
      <xsl:param name="year" select="name" />

      <xsl:for-each select="month">
	<xsl:param name="month" select="name" />

	<h1>
	  <xsl:call-template name="misc-format-date-string">
	    <xsl:with-param name="year" select="$year" />
	    <xsl:with-param name="month" select="$month" />
	    <xsl:with-param name="date-format" select="$param-l10n-date-format-YM" />
	  </xsl:call-template>
	</h1>

	<ul>
	  <xsl:for-each select="day">
	    <xsl:param name="day" select="name" />
	    <xsl:param name="index" select="position()" />

	    <!-- search localized items per day basis -->
	    <xsl:param name="localizeditems"
	      select="document($news.project.xml)
	              //descendant::year[name = $year]
	              /month[name = $month]
	              /day[name = $day and position() = $index]" />

	    <xsl:choose>
	      <xsl:when test="$localizeditems">
		<!-- when localized item exists -->
		<xsl:for-each select="$localizeditems/event">
		  <xsl:param name="anchor-position" select="position()" />

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
		      <xsl:apply-templates select="p" />
		    </p>
		  </li>
		</xsl:for-each>
	      </xsl:when>

	      <xsl:otherwise>
		<!-- when localized item does not exist -->
		<xsl:for-each select="event">
		  <xsl:param name="anchor-position" select="position()" />

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
		      <xsl:apply-templates select="p" />
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
      <xsl:param name="year" select="name" />

      <xsl:for-each select="month">
	<xsl:param name="month" select="name" />

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
	    <xsl:param name="localizeditems"
	      select="document($news.press.xml)
	              //descendant::year[name = $year]
	              /month[name = $month]
	              /story[url = $url]" />

	    <xsl:param name="anchor-position" select="position()" />

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
		      <xsl:copy-of select="p/child::node()"/>
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
		      <xsl:copy-of select="p/child::node()"/>
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
	<xsl:for-each select="document($advisories.xml)
	  /descendant::release">

	  <xsl:param name="relname" select="string(name)" />

	  <xsl:call-template name="html-list-advisories-putitems">
	    <xsl:with-param name="items" select="document($advisories.xml)
	      //advisory[$relname = string(following::release/name[1])]" />
	    <xsl:with-param name="prefix" select="$ftpbase" />
	    <xsl:with-param name="prefixold" select="$ftpbaseold" />
	  </xsl:call-template>

	  <xsl:call-template name="html-list-advisories-release-label">
	    <xsl:with-param name="relname" select="name" />
	  </xsl:call-template>
	</xsl:for-each>

	<xsl:call-template name="html-list-advisories-putitems">
	  <xsl:with-param name="items" select="document($advisories.xml)
	    //advisory[not(following::release/name[1])]" />
	  <xsl:with-param name="prefix" select="$ftpbase" />
	  <xsl:with-param name="prefixold" select="$ftpbaseold" />
	</xsl:call-template>
      </xsl:when>

      <xsl:when test="$type = 'notice'">
	<xsl:for-each select="document($advisories.xml)
	  /descendant::release">

	  <xsl:param name="relname" select="string(name)" />

	  <xsl:call-template name="html-list-advisories-putitems">
	    <xsl:with-param name="items" select="document($advisories.xml)
	      //notice[$relname = string(following::release/name[1])]" />
	    <xsl:with-param name="prefix" select="$ftpbaseerrata" />
	    <xsl:with-param name="prefixold" select="$ftpbaseerrata" />
	  </xsl:call-template>

	  <xsl:call-template name="html-list-advisories-release-label">
	    <xsl:with-param name="relname" select="name" />
	  </xsl:call-template>
	</xsl:for-each>

	<xsl:call-template name="html-list-advisories-putitems">
	  <xsl:with-param name="items" select="document($advisories.xml)
	    //notice[not(following::release/name[1])]" />
	  <xsl:with-param name="prefix" select="$ftpbaseerrata" />
	  <xsl:with-param name="prefixold" select="$ftpbaseerrata" />
	</xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- template: "html-list-advisories-putitems"
       sub-routine to generate a list -->

  <xsl:template name="html-list-advisories-putitems">
    <xsl:param name="items" select="''" />
    <xsl:param name="prefix" select="''" />
    <xsl:param name="prefixold" select="''" />

    <xsl:if test="$items">
      <ul>
	<xsl:for-each select="$items">
	  <li>
	    <xsl:choose>
	      <xsl:when test="@omithref='yes'">
		<xsl:value-of select="name" />
	      </xsl:when>
	      <xsl:when test="name/@role='old'">
		<a><xsl:attribute name="href">
		    <xsl:value-of select="concat($prefixold, name, '.asc')" />
		  </xsl:attribute>
		  <xsl:value-of select="concat(name, '.asc')" /></a>
	      </xsl:when>
	      <xsl:otherwise>
		<a><xsl:attribute name="href">
		    <xsl:value-of select="concat($prefix, name, '.asc')" />
		  </xsl:attribute>
		  <xsl:value-of select="concat(name, '.asc')" /></a>
	      </xsl:otherwise>
	    </xsl:choose>
	  </li>
	</xsl:for-each>
      </ul>
    </xsl:if>
  </xsl:template>

  <!-- template: "html-list-advisories-release-label"
       put label for release -->

  <xsl:template name="html-list-advisories-release-label">
    <xsl:param name="relname" select="'none'" />

    <p><xsl:value-of select="$relname" /> released.</p>
  </xsl:template>

  <!-- template: "html-index-advisories-items"
       pulls in the 10 most recent security advisories -->

  <xsl:template name="html-index-advisories-items">
    <xsl:param name="advisories.xml" select="''" />
    <xsl:param name="type" select="'advisory'" />

    <xsl:choose>
      <xsl:when test="$type = 'advisory'">
	<xsl:for-each select="document($advisories.xml)/descendant::advisory[position() &lt;= 10]">
	  <xsl:value-of select="$leadingmark" />
	  <xsl:choose>
	    <xsl:when test="@omithref = 'yes'">
	      <xsl:value-of select="name"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <a><xsl:attribute name="href">
		  <xsl:value-of select="concat($ftpbase, name, '.asc')"/>
		</xsl:attribute>
		<xsl:value-of select="name"/></a>
	    </xsl:otherwise>
	  </xsl:choose>
	  <br/>
	</xsl:for-each>
      </xsl:when>
      <xsl:when test="$type = 'notice'">
	<xsl:for-each select="document($advisories.xml)/descendant::notice[position() &lt;= 10]">
	  <xsl:value-of select="$leadingmark" />
	  <xsl:choose>
	    <xsl:when test="@omithref = 'yes'">
	      <xsl:value-of select="name"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <a><xsl:attribute name="href">
		  <xsl:value-of select="concat($ftpbaseerrata, name, '.asc')"/>
		</xsl:attribute>
		<xsl:value-of select="name"/></a>
	    </xsl:otherwise>
	  </xsl:choose>
	  <br/>
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
      <link>http://www.FreeBSD.org/security/</link>
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
	    <link><xsl:value-of select="concat($ftpbase, name, '.asc')" /></link>
	  </xsl:otherwise>
	</xsl:choose>
      </item>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-index-news-project-items"
       pulls in the 5 most recent project items -->

  <xsl:template name="html-index-news-project-items">
    <xsl:param name="news.project.xml-master" select="'none'" />
    <xsl:param name="news.project.xml" select="'none'" />

    <xsl:for-each select="document($news.project.xml-master)/descendant::day[position() &lt;= 5]">
      <xsl:param name="year" select="ancestor::year/name" />
      <xsl:param name="month" select="ancestor::month/name" />
      <xsl:param name="day" select="name" />

      <!-- search localized items per day basis -->
      <xsl:param name="localizeditems"
	select="document($news.project.xml)
	//descendant::year[name = $year]
	/month[name = $month]
	/day[name = $day]" />

      <xsl:choose>
	<xsl:when test="$localizeditems/event">
	  <xsl:for-each select="$localizeditems/event">
	    <xsl:param name="anchor-position" select="position()" />

	    <xsl:value-of select="$leadingmark" /><a>
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
	  </xsl:for-each>
	</xsl:when>

	<xsl:otherwise>
	  <xsl:for-each select="event">
	    <xsl:param name="anchor-position" select="position()" />

	    <xsl:value-of select="$leadingmark" /><a>
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
       pulls in the 5 most recent press items -->

  <xsl:template name="html-index-news-press-items">
    <xsl:param name="news.press.xml-master" select="'none'" />
    <xsl:param name="news.press.xml" select="''" />

    <xsl:for-each select="document($news.press.xml-master)/descendant::story[position() &lt;= 5]">
      <xsl:param name="year" select="../../name" />
      <xsl:param name="month" select="../name" />
      <xsl:param name="url" select="url" />
      <xsl:param name="site-url" select="site-url" />

      <xsl:param name="pos">
	<xsl:for-each select="../story">
	  <xsl:if test="url = $url">
	    <xsl:value-of select="position()" />
	  </xsl:if>
	</xsl:for-each>
      </xsl:param>

      <!-- search localized items per story(URL) basis -->
      <xsl:param name="localizeditems"
	select="document($news.press.xml)
	//descendant::year[name = $year]
	/month[name = $month]
	/story[url = $url]" />

      <xsl:value-of select="$leadingmark" />
      <a>
	<xsl:attribute name="href">
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
      </a>

      <br/>
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
		<xsl:when test="@path = 'base'"><xsl:value-of select="$base"/>/</xsl:when>
		<xsl:when test="@path = 'enbase'"><xsl:value-of select="$enbase"/>/</xsl:when>
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
    <xsl:value-of select="$leadingmark" />
    <a>
      <xsl:attribute name="href">
	<xsl:choose>
	  <xsl:when test="@path = 'base'"><xsl:value-of select="$base"/>/</xsl:when>
	  <xsl:when test="@path = 'enbase'"><xsl:value-of select="$enbase"/>/</xsl:when>
	</xsl:choose>
	<xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:value-of select="@name"/></a><br/>
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
</xsl:stylesheet>
