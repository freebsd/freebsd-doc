<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/it/includes.xsl,v 1.6 2004/01/08 11:46:08 ale Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../share/sgml/includes.xsl" />

  <xsl:variable name="url.doc.langcode" select="'it_IT.ISO8859-15'" />

  <xsl:variable name="i.daemon">
    <img src="{$enbase}/gifs/daemon.gif" alt="" align="left" width="80" height="76"/>
  </xsl:variable>

  <xsl:variable name="i.new">
    <img src="{$enbase}/gifs/new.gif" alt="[New!]" width="28" height="11"/>
  </xsl:variable>

  <xsl:variable name="copyright">
    <a href="{$enbase}/copyright/index.html">Copyright</a> &#169; 1995-2004 the FreeBSD Project.  Tutti i diritti riservati.
  </xsl:variable>

  <xsl:variable name="home">
    <a href="{$base}/index.html"><img src="{$enbase}/gifs/home.gif" alt="FreeBSD Home Page" border="0" align="right" width="101" height="33"/></a>
  </xsl:variable>

  <xsl:variable name="header2">
    <img src="{$enbase}/gifs/bar.gif" alt="Navigation Bar" width="565"
	 height="33" border="0" usemap="#bar"/>

    <h1 align="left"><font color="#660000"><xsl:value-of select="$title"/></font></h1>

    <br clear="all"/>

    <map name="bar">
      <area shape="rect" coords="1,1,111,31"
	    href="{$base}/index.html" alt="Home"/>
      <area shape="rect" coords="112,11,196,31"
	    href="{$enbase}/ports/index.html" alt="Applicazioni"/>
      <area shape="rect" coords="196,12,257,33"
	    href="{$enbase}/support.html" alt="Supporto"/>
      <area shape="rect" coords="256,12,365,33"
	    href="{$base}/docs.html" alt="Documentazione"/>
      <area shape="rect" coords="366,13,424,32"
	    href="{$enbase}/commercial/commercial.html" alt="Fornitori"/>
      <area shape="rect" coords="425,16,475,32"
	    href="{$enbase}/search/search.html" alt="Cerca"/>
      <area shape="rect" coords="477,16,516,33"
	    href="{$enbase}/search/index-site.html" alt="Indice"/>
      <area shape="rect" coords="516,15,562,33"
	    href="{$base}/index.html" alt="Home"/>
      <area shape="rect" coords="0,0,564,32"
	    href="{$base}/index.html" alt="Home"/>
    </map>
  </xsl:variable>

  <!-- template: "html-index-advisories-items-lastmodified" -->

  <xsl:template name="html-index-advisories-items-lastmodified">
    <xsl:param name="advisories.xml" select="''" />

    <xsl:value-of select="document($advisories.xml)/descendant::day[position() = 1]/name"/>
    <xsl:text> </xsl:text>
    <xsl:call-template name="transtable-lookup">
      <xsl:with-param name="word-group" select="'number-month'" />
      <xsl:with-param name="word">
	<xsl:value-of select="document($advisories.xml)/descendant::month[position() = 1]/name"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:value-of select="document($advisories.xml)/descendant::year[position() = 1]/name"/>
  </xsl:template>

  <!-- template: "html-index-news-project-items"
       pulls in the 10 most recent project items -->

  <xsl:template name="html-index-news-project-items">
    <xsl:param name="news.project.xml" select="''" />

    <xsl:for-each select="document($news.project.xml)/descendant::event[position() &lt;= 10]">
      <xsl:value-of select="$leadingmark" /><a>
	<xsl:attribute name="href">
	  <xsl:value-of select="$enbase"/>/news/newsflash.html#<xsl:call-template name="generate-event-anchor"/>
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
  </xsl:template>

  <!-- template: "html-index-news-press-items"
       pulls in the 10 most recent press items -->

  <xsl:template name="html-index-news-press-items">
    <xsl:param name="news.press.xml" select="''" />

    <xsl:for-each select="document($news.press.xml)/descendant::story[position() &lt; 10]">
      <xsl:value-of select="$leadingmark" /><a>
	<xsl:attribute name="href">
	  <xsl:value-of select="$enbase"/>/news/press.html#<xsl:call-template name="generate-story-anchor"/>
	</xsl:attribute>
	<xsl:value-of select="name"/>
      </a><br/>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-index-news-project-items-lastmodified" -->

  <xsl:template name="html-index-news-project-items-lastmodified">
    <xsl:param name="news.project.xml" select="''" />

    <xsl:value-of select="document($news.project.xml)/descendant::day[position() = 1]/name"/>
    <xsl:text> </xsl:text>
    <xsl:call-template name="transtable-lookup">
      <xsl:with-param name="word-group" select="'number-month'" />
      <xsl:with-param name="word">
	<xsl:value-of select="document($news.project.xml)/descendant::month[position() = 1]/name"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:value-of select="document($news.project.xml)/descendant::year[position() = 1]/name"/>
  </xsl:template>

  <xsl:variable name="u.rel.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel.announce">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel.early">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/early-adopter.html</xsl:variable>

  <xsl:variable name="u.rel2.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel2.announce">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel2.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel2.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/hardware.html</xsl:variable>

</xsl:stylesheet>
