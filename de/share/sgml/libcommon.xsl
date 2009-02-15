<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd">
<!-- $FreeBSD$
     $FreeBSDde: de-www/share/sgml/libcommon.xsl,v 1.16 2009/02/15 09:09:49 jkois Exp $
     basiert auf: 1.27
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/libcommon.xsl"/>

  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="Nouvelles FreeBSD"/>

    <p>Manchmal ist es m&#252;hsam, mit der schnellen Entwicklung
      des FreeBSD Betriebssystems Schritt zu halten.  Besuchen
      Sie diese Seite &#246;fter, um informiert zu bleiben.
      Weiterhin k&#246;nnen Sie die
      <a href="&enbase;/doc/de_DE.ISO8859-1/books/handbook/eresources.html#ERESOURCES-MAIL">Mailingliste
	freebsd-announce</a> abonnieren oder den <a href="&enbase;/news/news.rdf">RSS
	Ticker</a> benutzen.</p>

    <p>Die nachstehenden Projekte besitzen eigene Seiten,
      auf denen Sie projektbezogene Ank&#252;ndigungen finden:</p>

    <ul>
      <li><a href="&base;/java/">&java; unter FreeBSD</a></li>
      <li><a href="http://freebsd.kde.org/">KDE unter FreeBSD</a></li>
      <li><a href="&enbase;/gnome/newsflash.html">GNOME unter FreeBSD</a></li>
    </ul>

    <p>Informationen &#252;ber fr&#252;here, aktuelle und k&#252;nftige
      Releases finden Sie auf der Seite
      <strong><a href="&base;/releases/index.html">Release
	  Information</a></strong>.</p>

    <p>Die FreeBSD Sicherheitshinweise finden Sie auf der Seite
      <a href="&enbase;/security/advisories.html">FreeBSD Security
      Advisories</a>.</p>
  </xsl:template>

  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">FreeBSD Neuigkeiten</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>&#196;ltere Ank&#252;ndigungen:
      <a href="2008/index.html">2008</a>,
      <a href="2007/index.html">2007</a>,
      <a href="2006/index.html">2006</a>,
      <a href="2005/index.html">2005</a>,
      <a href="2004/index.html">2004</a>,
      <a href="2003/index.html">2003</a>,
      <a href="2002/index.html">2002</a>,
      <a href="&enbase;/news/2001/index.html">2001</a>,
      <a href="&enbase;/news/2000/index.html">2000</a>,
      <a href="&enbase;/news/1999/index.html">1999</a>,
      <a href="&enbase;/news/1998/index.html">1998</a>,
      <a href="&enbase;/news/1997/index.html">1997</a>,
      <a href="&enbase;/news/1996/index.html">1996</a></p>
  </xsl:template>

  <xsl:variable name="html-news-list-press-homelink">
    <a href="&base;/news/press.html">FreeBSD Pressemeldungen</a>
  </xsl:variable>

  <xsl:template name="html-press-make-olditems-list">
    <p>&#196;ltere Presseberichte:
      <a href="2008/press.html">2008</a>,
      <a href="2007/press.html">2007</a>,
      <a href="2006/press.html">2006</a>,
      <a href="2005/press.html">2005</a>,
      <a href="2004/press.html">2004</a>,
      <a href="&enbase;/news/2003/press.html">2003</a>,
      <a href="&enbase;/news/2002/press.html">2002</a>,
      <a href="&enbase;/news/2001/press.html">2001</a>,
      <a href="&enbase;/news/2000/press.html">2000</a>,
      <a href="&enbase;/news/1999/press.html">1999</a>,
      <a href="&enbase;/news/1998/press.html">1998-1996</a></p>
  </xsl:template>

  <xsl:template name="html-news-list-press-preface">
    <p>Kennen Sie einen hier nicht aufgef&#252;hrten Artikel?
      Senden Sie bitte die Einzelheiten an
      <a href="mailto:www@FreeBSD.org">www@FreeBSD.org</a> und
      wir nehmen den Artikel auf.</p>
  </xsl:template>

<!-- Temporaerer Fix der Event-Liste - jkois - 2007-02-14 -->

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
	  </xsl:choose>
          <xsl:text>events/#</xsl:text>
          <xsl:call-template name="generate-event-anchor"/>
        </xsl:attribute>

        <xsl:value-of select="name"/>

	<br />
	  <xsl:if test="location/city!='' and location/country!=''">
	    (<xsl:value-of select='location/city' />, <xsl:value-of select='location/country' />)
 	  </xsl:if>
	  <xsl:if test="location/city='' and location/country=''">
 	  </xsl:if>
      </a></p>
    </xsl:if>
    </xsl:for-each>
  </xsl:template>
<!-- Ende des temporaeren Fixes der Event-Liste - jkois - 2007-02-14 -->
</xsl:stylesheet>
