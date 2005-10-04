<?xml version="1.0" encoding="ISO-8859-1" ?>

<!--
     $FreeBSD: www/de/news/newsflash.xsl,v 1.8 2005/04/17 21:04:49 jkois Exp $
     $FreeBSDde: de-www/news/newsflash.xsl,v 1.14 2005/04/07 21:25:38 jkois Exp $
     basiert auf: 1.13
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>
  <xsl:variable name="section" select="'about'"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="enbase" select="'../..'"/>
  <xsl:variable name="title" select="'FreeBSD Ank&#252;ndigungen'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:param name="news.project.xml-master" select="'none'" />
  <xsl:param name="news.project.xml" select="'none'" />

  <xsl:output type="html" encoding="iso-8859-1"/>

  <xsl:template match="news">
    <html>

      <xsl:copy-of select="$header1"/>
      
            <body xsl:use-attribute-sets="att.body">
      
        <div id="containerwrap">
          <div id="container">
      
      	<xsl:copy-of select="$header2"/>
      
      	<div id="content">
      
      	      <xsl:copy-of select="$sidenav"/>
      
      	      <div id="contentwrap">
      	      
	      <xsl:copy-of select="$header3"/>

	<!-- Notice how entity references in SGML become variable references
	     in the stylesheet, and that the syntax for referring to variables
	     inside an attribute is "{$variable}".

	     This is just dis-similar enough to Perl and the shell that you
	     end up writing ${variable} all the time, and then scratch your
	     head wondering why the stylesheet isn't working.-->

	<!-- Also notice that because this is now XML and not SGML, empty
             elements, like IMG, must have a trailing "/" just inside the
             closing angle bracket, like this " ... />" -->
	<img src="{$enbase}/gifs/news.jpg" align="right" border="0" width="193"
	     height="144" alt="FreeBSD News"/>

	<p>Manchmal ist es m&#252;hsam, mit der schnellen Entwicklung
	  des FreeBSD Betriebssystems Schritt zu halten.  Besuchen
	  Sie diese Seite &#246;fter, um informiert zu bleiben.
	  Weiterhin k&#246;nnen Sie die
	  <a href="{$base}/../doc/de_DE.ISO8859-1/books/handbook/eresources.html#ERESOURCES-MAIL">Mailingliste
	  freebsd-announce</a> abonnieren oder den <a href="news.rdf">RSS
	  Ticker</a> benutzen.</p>

	<p>Die nachstehenden Projekte besitzen eigene Seiten,
	  auf denen Sie projektbezogene Ank&#252;ndigungen finden:</p>

        <ul>
          <li><a href="{$enbase}/java/newsflash.html"><xsl:value-of select="$java"/> unter FreeBSD</a></li>
          <li><a href="http://freebsd.kde.org/">KDE unter FreeBSD</a></li>
          <li><a href="{$enbase}/gnome/newsflash.html">GNOME unter FreeBSD</a></li>
        </ul>

	<p>Informationen &#252;ber fr&#252;here, aktuelle und k&#252;nftige
	  Releases finden Sie auf der Seite
	  <strong><a href="{$base}/releases/index.html">Release
	    Information</a></strong>.</p>

	<p>Die FreeBSD Sicherheitshinweise finden Sie auf der Seite
	  <a href="{$enbase}/security/#adv">Security Information</a>.</p>

	<xsl:call-template name="html-news-list-newsflash">
	  <xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
	  <xsl:with-param name="news.project.xml" select="$news.project.xml" />
	</xsl:call-template>

	<xsl:call-template name="html-news-make-olditems-list" />

	<xsl:copy-of select="$newshome"/>
	
		</div> <!-- contentwrap -->
		<br class="clearboth" />

	</div> <!-- content -->

	<xsl:copy-of select="$footer"/>

	</div> <!-- container -->
   </div> <!-- containerwrap -->
	
      </body>
    </html>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>&#196;ltere Ank&#252;ndigungen:
      <a href="2002/index.html">2002</a>,
      <a href="{$enbase}/news/2001/index.html">2001</a>,
      <a href="{$enbase}/news/2000/index.html">2000</a>,
      <a href="{$enbase}/news/1999/index.html">1999</a>,
      <a href="{$enbase}/news/1998/index.html">1998</a>,
      <a href="{$enbase}/news/1997/index.html">1997</a>,
      <a href="{$enbase}/news/1996/index.html">1996</a></p>
  </xsl:template>

  <!-- When the href attribute contains a '$base' or '$enbase', expand it to the current
       value of the $base or '$enbase' variable. -->

  <!-- All your $base or $enbase are belong to us.  Ho ho ho -->
  <xsl:template match="a">
    <a><xsl:attribute name="href">
	<xsl:choose>
	  <xsl:when test="contains(@href, '$base')">
	    <xsl:value-of select="concat(substring-before(@href, '$base'), $base, substring-after(@href, '$base'))"/>
	  </xsl:when>
	    <xsl:when test="contains(@href, '$enbase')">
	      <xsl:value-of select="concat(substring-before(@href, '$enbase'), $enbase, substring-after(@href, '$enbase'))"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@href"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
</xsl:stylesheet>
