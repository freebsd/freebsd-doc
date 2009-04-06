<?xml version="1.0" encoding="ISO-8859-2" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd">
<!-- $FreeBSD: www/hu/share/sgml/libcommon.xsl,v 1.3 2008/08/12 05:07:13 pgj Exp $ -->

<!-- The FreeBSD Hungarian Documentation Project
     Translated by: Gabor Kovesdan <gabor@FreeBSD.org>
     %SOURCE%	share/sgml/libcommon.xsl
     %SRCID%	1.28
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/libcommon.xsl"/>

  <xsl:param name="param-l10n-date-format-YMD"
             select="'%Y-%M-%D'" />
  <xsl:param name="param-l10n-date-format-YM"
             select="'%Y %M'" />
  <xsl:param name="param-l10n-date-format-MD"
             select="'%M %D'" />
  <xsl:param name="param-l10n-date-format-rfc822"
             select="'%Y %m %D 00:00:00 CET, %W'" />

  <xsl:template name="html-usergroups-list-header">
    <p>A &os; n&eacute;pszer&#251;s&eacute;ge nyom&aacute;n a
      vil&aacute;gban l&eacute;trej&ouml;tt sz&aacute;mos
      felhaszn&aacute;l&oacute;i csoport.</p>

    <p>Ha tudom&aacute;sunk van olyan tov&aacute;bbi &os;
      felhaszn&aacute;l&oacute;i csoportokr&oacute;l, amelyek az
      al&aacute;bbi felsorol&aacute;sban m&eacute;g nem szerepelnek,
      k&uuml;ldj&uuml;nk egy <a
	href="http://www.freebsd.org/hu/send-pr.html">hibajelent&eacute;st</a>
      a <q>www</q> kateg&oacute;ri&aacute;ban a k&ouml;vetkez&#245;
      adatok megad&aacute;s&aacute;val:</p>

    <ol>
      <li>A felhaszn&aacute;l&oacute;i csoport honlapj&aacute;nak
	c&iacute;me.</li>

      <li>Egy kapcsolattart&oacute; szem&eacute;ly e-mail c&iacute;me a
	l&aacute;togat&oacute;ink &eacute;s a honlapunk
	karbantart&oacute;inak sz&aacute;m&aacute;ra.</li>

      <li>A felhaszn&aacute;l&oacute;i csoport t&ouml;m&ouml;r (egy
	bekezd&eacute;snyi) bemutat&aacute;sa.</li>
    </ol>

    <p>Az el&#245;bb felsorolt inform&aacute;ci&oacute;kat
      k&eacute;rj&uuml;k HTML form&aacute;tumban bek&uuml;ldeni.  A &os;
      lend&uuml;let&eacute;nek meg&#245;rz&eacute;s&eacute;nek
      szellem&eacute;ben els&#245;sorban olyan
      felhaszn&aacute;l&oacute;i csoportok jelentkez&eacute;s&eacute;t
      v&aacute;rjuk, amelyek akt&iacute;vak &eacute;s
      tev&eacute;kenys&eacute;g&uuml;k nyilv&aacute;nos.  Ha m&eacute;g
      nem lenne a k&ouml;rny&eacute;k&uuml;nk&ouml;n ilyen csoport,
      akkor javasoljuk, hogy kutassunk fel &eacute;s vegy&uuml;nk fel
      kapcsolatot a k&ouml;zel&uuml;nkben &eacute;l&#245;
      &eacute;rdekl&#245;d&#245;kkel, p&eacute;ld&aacute;ul a <a
	href="http://bsd.meetup.com/"></a> oldalon kereszt&uuml;l,
      &eacute;s alap&iacute;tsunk egy saj&aacute;t
      felhaszn&aacute;l&oacute;i csoportot.</p>

    <h3>R&eacute;gi&oacute;k:</h3>
  </xsl:template>

  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="&os; h&iacute;rek"/>

    <p>A &os; oper&aacute;ci&oacute;s rendszer dinamikusan &eacute;s
      gyorsan fejl&#245;dik, ez&eacute;rt a legfrissebb
      fejleszt&eacute;sek nyomonk&ouml;vet&eacute;se nem mindig
      k&ouml;nny&#251; feladat.  Ha k&iacute;v&aacute;ncsiak vagyunk a
      rendszerrel kapcsolatos leg&uacute;jabb
      inform&aacute;ci&oacute;kra, t&eacute;rj&uuml;nk vissza erre az
      oldalra gyakran.  Emellett &eacute;rdemes lehet m&eacute;g
      feliratkoznunk a <a
	href="&base;/doc/hu/books/handbook/eresources.html#ERESOURCES-MAIL">freebsd-announce
	levelez&eacute;si list&aacute;ra</a>, vagy a
	hozz&aacute;tartoz&oacute; <a href="rss.xml">RSS feed</a>re.</p>

    <p>Tov&aacute;bb&aacute; az al&aacute;bbi projektek rendelkeznek
      saj&aacute;t k&uuml;l&ouml;n h&iacute;roldallal, amelyek figyelemmel
      k&iacute;s&eacute;r&eacute;s&eacute;vel pedig az adott projektben
      v&eacute;gzett munk&aacute;r&oacute;l tudhatunk meg
      t&ouml;bbet.</p>

    <ul>
      <li><a href="&enbase;/java/newsflash.html">&os; &java;</a></li>

      <li><a href="http://freebsd.kde.org/">&os; KDE</a></li>

      <li><a href="&enbase;/gnome/newsflash.html">&os; GNOME</a></li>
    </ul>

    <p>A kor&aacute;bbi, a jelenlegi &eacute;s a j&ouml;v&#245;beni
      kiad&aacute;sokr&oacute;l b&#245;vebben a <strong><a
	href="&enbase;/releases/index.html">kiad&aacute;sok
	inform&aacute;ci&oacute;s oldal&aacute;n</a></strong>
      olvashatunk.</p>

    <p>A &os; Projekt biztons&aacute;gi figyelmeztet&eacute;seit a <a
	href="&enbase;/security/#adv">biztons&aacute;gi
	inform&aacute;ci&oacute;s oldalon</a> tal&aacute;ljuk meg.</p>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>A kor&aacute;bbi &eacute;vek h&iacute;rei:
      <a href="&enbase;/news/2008/index.html">2008</a>,
      <a href="&enbase;/news/2007/index.html">2007</a>,
      <a href="&enbase;/news/2006/index.html">2006</a>,
      <a href="&enbase;/news/2005/index.html">2005</a>,
      <a href="&enbase;/news/2004/index.html">2004</a>,
      <a href="&enbase;/news/2003/index.html">2003</a>,
      <a href="&enbase;/news/2002/index.html">2002</a>,
      <a href="&enbase;/news/2001/index.html">2001</a>,
      <a href="&enbase;/news/2000/index.html">2000</a>,
      <a href="&enbase;/news/1999/index.html">1999</a>,
      <a href="&enbase;/news/1998/index.html">1998</a>,
      <a href="&enbase;/news/1997/index.html">1997</a>,
      <a href="&enbase;/news/1996/index.html">1996</a></p>
  </xsl:template>

  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">H&iacute;rek f&#245;oldal</a>
  </xsl:template>

  <xsl:template name="html-press-make-olditems-list">
    <p>A kor&aacute;bbi &eacute;vek sajt&oacute;kiadv&aacute;nyai:
      <a href="&enbase;/news/2007/press.html">2007</a>,
      <a href="&enbase;/news/2006/press.html">2006</a>,
      <a href="&enbase;/news/2005/press.html">2005</a>,
      <a href="&enbase;/news/2004/press.html">2004</a>,
      <a href="&enbase;/news/2003/press.html">2003</a>,
      <a href="&enbase;/news/2002/press.html">2002</a>,
      <a href="&enbase;/news/2001/press.html">2001</a>,
      <a href="&enbase;/news/2000/press.html">2000</a>,
      <a href="&enbase;/news/1999/press.html">1999</a>,
      <a href="&enbase;/news/1998/press.html">1998-1996</a></p>
  </xsl:template>

  <xsl:template name="html-news-list-press-preface">
    <p>Ha tudunk b&aacute;rmilyen olyan &os; t&eacute;m&aacute;j&uacute;
      h&iacute;rr&#245;l vagy egy&eacute;b &iacute;r&aacute;sr&oacute;l,
      amely nem szerepel az itteniek k&ouml;z&ouml;tt, &iacute;rjunk egy
      levelet a <a href="mailto:www@FreeBSD.org">www@FreeBSD.org</a>
      c&iacute;mre, hogy fel tudjuk ide is tenni.</p>
  </xsl:template>

  <xsl:template name="html-events-map">
    <xsl:param name="mapurl" select="'none'" />

    <p>A lentebb l&aacute;that&oacute; t&eacute;rk&eacute;pen
      s&ouml;t&eacute;t pirossal jel&ouml;lt&uuml;k azokat az
      orsz&aacute;gokat &eacute;s r&eacute;gi&oacute;kat, ahol a
      k&ouml;zelj&ouml;v&#245;ben valamilyen nagyobb &os;
      t&eacute;m&aacute;j&uacute; esem&eacute;ny v&aacute;rhat&oacute;.
      S&aacute;rg&aacute;val &eacute;s narancss&aacute;rg&aacute;val
      jel&ouml;lt&uuml;k azokat az orsz&aacute;gokat, ahol
      kor&aacute;bban m&aacute;r lezajlott valamilyen &os;
      t&eacute;m&aacute;j&uacute; esem&eacute;ny.  Itt a sz&iacute;nek
      az esem&eacute;nyek sz&aacute;m&aacute;val egyre
      s&ouml;t&eacute;tednek.</p>

    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="$mapurl" />
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template name="html-events-list-preface">
    <p>Ha tudunk valamilyen olyan &os; t&eacute;m&aacute;j&uacute;
      esem&eacute;nyr&#245;l vagy esem&eacute;nyekr&#245;l, amelyek a
      t&ouml;bbi &os; felhaszn&aacute;l&oacute; sz&aacute;m&aacute;ra is
      &eacute;rdekesek lehetnek, de m&eacute;g nem szerepelnek az
      oldalon tal&aacute;lhat&oacute; list&aacute;ban, &iacute;rjuk meg
      a <a href="mailto:www@FreeBSD.org">www@FreeBSD.org</a>
      c&iacute;mre, hogy fel tudjuk tenni.</p>

    <p>Az iCalendar form&aacute;tumot ismer&#245; programokkal
      dolgoz&oacute; felhaszn&aacute;l&oacute;k az oldalon szerepl&#245;
      &ouml;sszes esem&eacute;nyt el&eacute;rhetik a <a
	href="&base;/events/events.ics">kalend&aacute;riumk&eacute;nt</a>
      is.</p>
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
    <h2 id="upcoming">Aktu&aacute;lis/k&ouml;zelg&#245;
      esem&eacute;nyek:</h2>
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
    <h2 id="past">Kor&aacute;bbi esem&eacute;nyek:</h2>
  </xsl:template>

  <xsl:template name="html-list-advisories-release-label">
    <xsl:param name="relname" select="'none'" />

    <p>Megjelent a <xsl:value-of select="$relname" />.</p>
  </xsl:template>

  <xsl:template name="rdf-security-advisories-title"
                xmlns="http://my.netscape.com/rdf/simple/0.9/">
    <channel>
      <title>&os; biztons&aacute;gi figyelmeztet&eacute;sek</title>
      <link>http://www.FreeBSD.org/security/</link>
      <description>A &os; Projekt &aacute;ltal megjelentetett
	biztons&aacute;gi figyelmeztet&eacute;sek</description>
    </channel>
  </xsl:template>

  <xsl:template name="rss-security-advisories-title"
                xmlns:atom="http://www.w3.org/2005/Atom">
    <xsl:param name="advisories.xml" select="''" />

    <xsl:variable name="title">&os; biztons&aacute;gi figyelmeztet&eacute;sek</xsl:variable>
    <xsl:variable name="link">http://www.FreeBSD.org/security/</xsl:variable>

    <title><xsl:value-of select="$title" /></title>
    <link><xsl:value-of select="$link" /></link>
    <description>A &os; Projekt &aacute;ltal megjelentetett
      biztons&aacute;gi figyelmeztet&eacute;sek</description>
    <language>en-us</language>
    <webMaster>secteam@FreeBSD.org (&os; Security Team)</webMaster>
    <managingEditor>secteam@FreeBSD.org (&os; Security Team)</managingEditor>
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
  </xsl:template>

  <xsl:template name="rss-errata-notices-title"
                xmlns:atom="http://www.w3.org/2005/Atom">
    <xsl:param name="notices.xml" select="''" />

    <xsl:variable name="title">&os; sajt&oacute;hib&aacute;k</xsl:variable>
    <xsl:variable name="link">http://www.FreeBSD.org/security/</xsl:variable>

    <title><xsl:value-of select="$title" /></title>
    <link><xsl:value-of select="$link" /></link>
    <description>A &os; Projekt &aacute;ltal megjelentetett
      sajt&oacute;hib&aacute;k</description>
    <language>en-us</language>
    <webMaster>secteam@FreeBSD.org (FreeBSD Security Team)</webMaster>
    <managingEditor>secteam@FreeBSD.org (FreeBSD Security Team)</managingEditor>
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
  </xsl:template>

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

  <!-- Convert a month number to the corresponding long English name. -->
  <xsl:template name="gen-long-en-month">
    <xsl:param name="nummonth"/>
    <xsl:variable name="month" select="number($nummonth)"/>
    <xsl:choose>
      <xsl:when test="$month=1">janu&aacute;r</xsl:when>
      <xsl:when test="$month=2">febru&aacute;r</xsl:when>
      <xsl:when test="$month=3">m&aacute;rcius</xsl:when>
      <xsl:when test="$month=4">&aacute;prilis</xsl:when>
      <xsl:when test="$month=5">m&aacute;jus</xsl:when>
      <xsl:when test="$month=6">j&uacute;nius</xsl:when>
      <xsl:when test="$month=7">j&uacute;lius</xsl:when>
      <xsl:when test="$month=8">augusztus</xsl:when>
      <xsl:when test="$month=9">szeptember</xsl:when>
      <xsl:when test="$month=10">okt&oacute;ber</xsl:when>
      <xsl:when test="$month=11">november</xsl:when>
      <xsl:when test="$month=12">december</xsl:when>
      <xsl:otherwise>&eacute;rv&eacute;nytelen h&oacute;nap</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Convert a month number to the corresponding short English name. -->
  <xsl:template name="gen-short-en-month">
    <xsl:param name="nummonth"/>
    <xsl:variable name="month" select="number($nummonth)"/>
    <xsl:choose>
      <xsl:when test="$month=1">jan</xsl:when>
      <xsl:when test="$month=2">feb</xsl:when>
      <xsl:when test="$month=3">m&aacute;r</xsl:when>
      <xsl:when test="$month=4">&aacute;pr</xsl:when>
      <xsl:when test="$month=5">m&aacute;j</xsl:when>
      <xsl:when test="$month=6">j&uacute;n</xsl:when>
      <xsl:when test="$month=7">j&uacute;l</xsl:when>
      <xsl:when test="$month=8">aug</xsl:when>
      <xsl:when test="$month=9">szep</xsl:when>
      <xsl:when test="$month=10">okt</xsl:when>
      <xsl:when test="$month=11">nov</xsl:when>
      <xsl:when test="$month=12">dec</xsl:when>
      <xsl:otherwise>&eacute;rv&eacute;nytelen h&oacute;nap</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Generate a date interval. -->
  <!-- Sample: 2002. november 27 - 2003. december 29. -->
  <xsl:template name="gen-date-interval">
    <xsl:param name="startdate"/>
    <xsl:param name="enddate"/>

    <xsl:value-of select="startdate/year"/>

    <xsl:text>. </xsl:text>
    <xsl:call-template name="gen-long-en-month">
      <xsl:with-param name="nummonth" select="startdate/month"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>

    <xsl:if test="number(startdate/month) != number(enddate/month) or
		  number(startdate/day) != number(enddate/day) or
		  number(startdate/year) != number(enddate/year)">

      <xsl:value-of select="startdate/day"/>

      <xsl:text> - </xsl:text>
    </xsl:if>

    <xsl:if test="number(startdate/year) != number(enddate/year)">
      <xsl:value-of select="enddate/year"/>
      <xsl:text>.</xsl:text>
    </xsl:if>

      <xsl:if test="number(startdate/month) != number(enddate/month) or
		    number(startdate/year) != number(enddate/year)">
	<xsl:text> </xsl:text>
	<xsl:call-template name="gen-long-en-month">
	  <xsl:with-param name="nummonth" select="enddate/month"/>
	</xsl:call-template>
        <xsl:text> </xsl:text>
      </xsl:if>

     <xsl:value-of select="enddate/day"/>
     <xsl:text>.</xsl:text>
  </xsl:template>

 <!-- template: "html-index-events-items"
       pulls in the 5 most recent events items -->

  <xsl:template name="html-index-events-items">
    <xsl:param name="events.xml-master" select="'none'" />
    <xsl:param name="events.xml" select="''" />

    <xsl:for-each select="document($events.xml)/descendant::event[
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
	    <xsl:when test="$events.xml-master = 'none'">&enbase;/</xsl:when>
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
</xsl:stylesheet>
