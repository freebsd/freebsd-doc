<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "&os; h&iacute;rek">
<!ENTITY email "freebsd-www">
<!ENTITY rsslink "rss.xml">
<!ENTITY rsstitle "&title;">
<!ENTITY % navinclude.about "INCLUDE">
<!ENTITY % header.rss "INCLUDE">
]>

<!-- $FreeBSD: www/share/sgml/templates.newsflash.xsl,v 1.4 2008/01/16 02:57:37 murray Exp $ -->

<!-- The FreeBSD Hungarian Documentation Project
     Translated by: PALI, Gabor <pgj@FreeBSD.org>
     %SOURCE%	share/sgml/templates.newsflash.xsl
     %SRCID%	1.4
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:param name="news.project.xml-master" select="'none'" />
  <xsl:param name="news.project.xml" select="'none'" />

  <xsl:output type="html" encoding="&xml.encoding;"/>

  <xsl:template match="news">
    <html>
      &header1;
      <body>

	<div id="CONTAINERWRAP">
	  <div id="CONTAINER">
	    &header2;

	    <div id="CONTENT">
              <div id="SIDEWRAP">
                &nav;
                <div id="FEEDLINKS">
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

	      <div id="CONTENTWRAP">
		&header3;

		<xsl:call-template name="html-news-list-newsflash-preface" />

		<xsl:call-template name="html-news-list-newsflash">
		  <xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
		  <xsl:with-param name="news.project.xml" select="$news.project.xml" />
		</xsl:call-template>

		<xsl:call-template name="html-news-make-olditems-list" />

		<xsl:call-template name="html-news-list-newsflash-homelink" />

	      </div> <!-- CONTENTWRAP -->
	      <br class="clearboth" />
	    </div> <!-- CONTENT -->

            <div id="FOOTER">
               &copyright;<br />
               &date;
            </div> <!-- FOOTER -->
        </div> <!-- CONTAINER -->
   </div> <!-- CONTAINERWRAP -->

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
