<?xml version="1.0" encoding="iso-8859-2"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "&os; hírek">
<!ENTITY rsslink "rss.xml">
<!ENTITY rsstitle "&title;">
]>

<!-- $FreeBSD$ -->

<!-- The FreeBSD Hungarian Documentation Project
     Translated by: PALI, Gabor <pgj@FreeBSD.org>
     %SOURCE%	share/xml/templates.newsflash.xsl
     %SRCID%	1.4
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:param name="news.project.xml-master" select="'none'" />
  <xsl:param name="news.project.xml" select="'none'" />

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:variable name="rsstitle">&rsstitle;</xsl:variable>

  <xsl:variable name="rsslink">&rsslink;</xsl:variable>

  <xsl:template name="process.content">
              <div id="sidewrap">
                &nav.about;
                <div id="feedlinks">
                  <ul>
                    <li>
                      <a href="rss.xml" title="RSS 2.0 Feed">
                        RSS 2.0 Feed
                      </a>
                    </li>
                    <li>
                      <a href="news.rdf" title="RDF/RSS 0.9 Feed">
                        RSS 0.9 Feed
                      </a>
                    </li>
                  </ul>
                </div> <!-- FEEDLINKS -->
              </div> <!-- SIDEWRAP -->

	      <div id="contentwrap">
		<h1>&title;</h1>

		<xsl:for-each select="/news">
		<xsl:call-template name="html-news-list-newsflash-preface" />

		<xsl:call-template name="html-news-list-newsflash">
		  <xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
		  <xsl:with-param name="news.project.xml" select="$news.project.xml" />
		</xsl:call-template>

		<xsl:call-template name="html-news-make-olditems-list" />

		<xsl:call-template name="html-news-list-newsflash-homelink" />
		</xsl:for-each>

	      </div> <!-- CONTENTWRAP -->
  </xsl:template>
</xsl:stylesheet>
