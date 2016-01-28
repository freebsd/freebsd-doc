<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$
     %SOURCE%	share/xml/libcommon.xsl
     %SRCID%	39632
 -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>

  <xsl:param name="param-l10n-date-format-YMD"
	     select="'%Y-%M-%D'" />
  <xsl:param name="param-l10n-date-format-YM"
	     select="'%Y %M'" />
  <xsl:param name="param-l10n-date-format-MD"
	     select="'%D %M'" />
  <xsl:param name="param-l10n-date-format-rfc822"
	     select="'%W, %D %m %Y 00:00:00 CET'" />

  <xsl:template name="html-usergroups-list-header">
    <p>De wijdverbreide populariteit van &os; heeft tot een aantal
      gebruikersgroepen over de wereld geleidt.</p>

    <p>Als u een gebruikersgroep van &os; kent die hier niet is genoemd,
      vul dan alstublieft een <a
	href="http://www.freebsd.org/nl/send-pr.html">probleemrapport</a>
      in voor de categorie www met de volgende informatie:</p>

    <ol>
      <li>Een URL voor de website van de gebruikersgroep.</li>
      <li>Een emailadres voor contact met het leidende persoon, te
	gebruiken voor uw bezoekers en websitebeheerders.</li>
      <li>Een korte (één paragraaf) beschrijving van de
	gebruikersgroep.</li>
    </ol>

    <p>Inzendingen dienen in HTML te zijn.  Om recht te doen aan de geest
      van &os; verkiezen we gebruikersgroepen die actief zijn en die hun
      zaak publiekelijk bedrijven.  Als u geen groep in uw buurt kunt
      vinden, overweeg dan alstublieft om andere geïnteresseerde
      individuën bij u in de buurt te vinden via <a
	href="http://bsd.meetup.com/">http://bsd.meetup.com/</a> en uw
      eigen gebruikersgroep te vormen.</p>

    <h3>Regio's:</h3>
  </xsl:template>

  <!-- template: "html-news-make-olditems-list" -->
  <xsl:template name="html-news-make-olditems-list">
    <p>Oude aankondigingen:
      <a href="&enbase;/news/2009/index.html">2009</a>,
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
      <a href="&enbase;/news/1996/index.html">1996</a>,
      <a href="&enbase;/news/1993/index.html">1993</a></p>
  </xsl:template>

  <!-- template: "html-press-make-olditems-list" -->
  <xsl:template name="html-press-make-olditems-list">
    <p>Oude persberichten:
      <a href="&enbase;/news/2009/press.html">2009</a>,
      <a href="&enbase;/news/2008/press.html">2008</a>,
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

  <!-- template: "html-news-list-newsflash-preface" -->
  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="&os; nieuws"/>

    <p>&os; is een besturingssysteem dat zich snel ontwikkelt.  Het
      bijhouden van de nieuwste ontwikkelingen kan een klus zijn!  Zorg
      ervoor dat u periodiek deze pagina bekijkt om bovenop de dingen te
      blijven.  U kunt zich ook op de <a
	href="http://lists.freebsd.org/mailman/listinfo/freebsd-announce">freebsd-announce
	mailinglijst</a> of de <a href="rss.xml">RSS-stroom</a>
      abonneren.</p>

    <p>De volgende projecten hebben hun eigen specifieke nieuwspagina's,
      welke bekeken dienen te worden voor updates die specifiek voor het
      project zijn.</p>

    <ul>
      <li><a href="&enbase;/java/newsflash.html">&java; op &os;</a></li>
      <li><a href="http://freebsd.kde.org/">KDE op &os;</a></li>
      <li><a href="&enbase;/gnome/newsflash.html">GNOME op &os;</a></li>
    </ul>

    <p>Een gedetailleerde beschrijving van vroegere, huidige en toekomstige
      uitgaven staat op de pagina <a
	href="&enbase;/releases/index.html">Uitgave-informatie</a>.</p>

    <p>Bekijk alstublieft de pagina <a
      href="&enbase;/security/">Beveiligingsinformatie</a> voor
      beveiligingsinformatie voor &os; en een lijst van beschikbare
      Beveiligingsadviezen.</p>
  </xsl:template>

  <!-- template: "html-news-list-newsflash-homelink" -->
  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&enbase;/news/news.html">Beginpagina nieuws</a>
  </xsl:template>

  <!-- template: "html-news-list-press-preface" -->
  <xsl:template name="html-news-list-press-preface">
    <p>Als u een nieuwsartikel kent dat &os; noemt dat we hier niet
      vermeldt hebben, stuur dan alstublieft de details naar <a
	href="mailto:www@FreeBSD.org">www@FreeBSD.org</a> zodat we ze
      kunnen opnemen.</p>
  </xsl:template>

  <xsl:template name="html-events-list-preface">
    <p>Als u enig &os;-gerelateerd evenement, of evenementen die
      interessant zijn voor &os;-gebruikers kent, die hier niet vermeldt
      zijn, stuur dan alstublieft de details naar <a
	href="mailto:www@FreeBSD.org">www@FreeBSD.org</a> zodat ze
      kunnen worden opgenomen.</p>

    <p>Gebruikers met organisatiesoftware dat het iCalendar-formaat
      begrijpt kunnen zich abonneren op de <a
	href="&enbase;/events/events.ics">&os; evenementenkalender</a>
      dat alle evenementen bevat die hier genoemd zijn.</p>
  </xsl:template>

  <xsl:template name="html-events-map">
    <xsl:param name="mapurl" select="'none'" />

    <p>Landen en regio's die in donkerrood op de onderstaande kaart zijn
      afgebeeld organiseren aankomende &os;-gerelateerde evenementen.
      Landen die in het verleden &os;-gerelateerde evenementen hebben
      georganiseerd zijn geel of oranje, waarbij donkerdere kleuren een
      groter aantal voorgaande evenementen aangeeft.</p>

    <img>
      <xsl:attribute name="src">
	<xsl:value-of select="$mapurl" />
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
    <h2 id="upcoming">Huidige/komende evenementen:</h2>
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
    <h2 id="past">Voorbije evenementen:</h2>
  </xsl:template>

  <!-- template: "generate-month-num" -->
  <xsl:template name="generate-month-num">
    <xsl:param name="month" />

    <xsl:choose>
      <xsl:when test="$month='januari'">1</xsl:when>
      <xsl:when test="$month='februari'">2</xsl:when>
      <xsl:when test="$month='maart'">3</xsl:when>
      <xsl:when test="$month='april'">4</xsl:when>
      <xsl:when test="$month='mei'">5</xsl:when>
      <xsl:when test="$month='juni'">6</xsl:when>
      <xsl:when test="$month='juli'">7</xsl:when>
      <xsl:when test="$month='augustus'">8</xsl:when>
      <xsl:when test="$month='september'">9</xsl:when>
      <xsl:when test="$month='oktober'">10</xsl:when>
      <xsl:when test="$month='november'">11</xsl:when>
      <xsl:when test="$month='december'">12</xsl:when>
      <xsl:otherwise>???</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- template: "html-list-advisories-putitems"
       sub-routine to generate a list -->

  <xsl:template name="html-list-advisories-putitems">
    <xsl:param name="items" select="''" />
    <xsl:param name="itemtype" select="''" />
    <xsl:param name="itemtype" select="''" />
    <xsl:param name="prefix" select="''" />

    <xsl:if test="$items">
      <table>
	<tr><th>Datum</th><th><xsl:value-of select='$itemtype' /> naam</th></tr>
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

    <p><xsl:value-of select="$relname" /> vrijgegeven.</p>
  </xsl:template>

  <!-- template: "rdf-security-advisories-title"
       generate title for the security advisories rdf -->

  <xsl:template name="rdf-security-advisories-title"
		xmlns="http://my.netscape.com/rdf/simple/0.9/">
    <channel>
      <title>&os; beveiligingsadviezen</title>
      <link>http://www.FreeBSD.org/security/</link>
      <description>Beveiligingsadviezen gepubliceerd door het &os; Project</description>
    </channel>
  </xsl:template>

  <!-- template: "rss-security-advisories-title"
       pulls in the 10 most recent security advisories -->

  <xsl:template name="rss-security-advisories-title"
		xmlns:atom="http://www.w3.org/2005/Atom">
    <xsl:param name="advisories.xml" select="''" />

    <xsl:variable name="title">&os; beveiligingsadviezen</xsl:variable>
    <xsl:variable name="link">http://www.FreeBSD.org/security/</xsl:variable>

    <title><xsl:value-of select="$title" /></title>
    <link><xsl:value-of select="$link" /></link>
    <description>Beveiligingsadviezen gepubliceerd door het &os; Project</description>
    <language>en-us</language>
    <webMaster>secteam@FreeBSD.org (&os; Beveiligingsteam)</webMaster>
    <managingEditor>secteam@FreeBSD.org (&os; Beveiligingsteam)</managingEditor>
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

  <!-- template: "rss-errata-notices-title"
       pulls in the 10 most recent errata notices -->

  <xsl:template name="rss-errata-notices-title"
		xmlns:atom="http://www.w3.org/2005/Atom">
    <xsl:param name="notices.xml" select="''" />

    <xsl:variable name="title">&os; erratamededelingen</xsl:variable>
    <xsl:variable name="link">http://www.FreeBSD.org/security/</xsl:variable>

    <title><xsl:value-of select="$title" /></title>
    <link><xsl:value-of select="$link" /></link>
    <description>Erratamededelingen gepubliceerd door het &os; Project</description>
    <language>en-us</language>
    <webMaster>secteam@FreeBSD.org (&os; beveiligingsteam)</webMaster>
    <managingEditor>secteam@FreeBSD.org (&os; beveiligingsteam)</managingEditor>
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

  <!-- template: "html-index-mirrors-options-list"
       generates mirror sites list in index.html -->

  <xsl:template name="html-index-mirrors-options-list">
    <xsl:param name="mirrors.xml" select="''" />

    <xsl:choose>
      <xsl:when test="$mirrors.xml = ''">
	<option value="NONE">
	  **Geen gegevens**
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

  <!-- Convert a month number to the corresponding long Dutch name. -->
  <xsl:template name="gen-long-en-month">
    <xsl:param name="nummonth"/>
    <xsl:variable name="month" select="number($nummonth)"/>
    <xsl:choose>
      <xsl:when test="$month=1">januari</xsl:when>
      <xsl:when test="$month=2">februari</xsl:when>
      <xsl:when test="$month=3">maart</xsl:when>
      <xsl:when test="$month=4">april</xsl:when>
      <xsl:when test="$month=5">mei</xsl:when>
      <xsl:when test="$month=6">juni</xsl:when>
      <xsl:when test="$month=7">juli</xsl:when>
      <xsl:when test="$month=8">augustus</xsl:when>
      <xsl:when test="$month=9">september</xsl:when>
      <xsl:when test="$month=10">oktober</xsl:when>
      <xsl:when test="$month=11">november</xsl:when>
      <xsl:when test="$month=12">december</xsl:when>
      <xsl:otherwise>Ongeldige maand</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Convert a month number to the corresponding short Dutch name. -->
  <xsl:template name="gen-short-en-month">
    <xsl:param name="nummonth"/>
    <xsl:variable name="month" select="number($nummonth)"/>
    <xsl:choose>
      <xsl:when test="$month=1">jan</xsl:when>
      <xsl:when test="$month=2">feb</xsl:when>
      <xsl:when test="$month=3">mrt</xsl:when>
      <xsl:when test="$month=4">apr</xsl:when>
      <xsl:when test="$month=5">mei</xsl:when>
      <xsl:when test="$month=6">jun</xsl:when>
      <xsl:when test="$month=7">jul</xsl:when>
      <xsl:when test="$month=8">aug</xsl:when>
      <xsl:when test="$month=9">sep</xsl:when>
      <xsl:when test="$month=10">okt</xsl:when>
      <xsl:when test="$month=11">nov</xsl:when>
      <xsl:when test="$month=12">dec</xsl:when>
      <xsl:otherwise>Ongeldige maand</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
