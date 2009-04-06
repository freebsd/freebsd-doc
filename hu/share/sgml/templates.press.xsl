<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "&os; a sajt&oacute;ban">
<!ENTITY email "freebsd-www">
<!ENTITY rsslink "press-rss.xml">
<!ENTITY rsstitle "&title;">
<!ENTITY % navinclude.about "INCLUDE">
<!ENTITY % header.rss "INCLUDE">
]>

<!-- $FreeBSD: www/share/sgml/templates.press.xsl,v 1.5 2008/01/18 03:06:05 murray Exp $ -->

<!-- The FreeBSD Hungarian Documentation Project
     Translated by: PALI, Gabor <pgj@FreeBSD.org>
     %SOURCE%	share/sgml/templates.press.xsl
     %SRCID%	1.5
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">

  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:param name="news.press.xml-master" select="'none'" />
  <xsl:param name="news.press.xml" select="'none'" />

  <xsl:output type="html" encoding="&xml.encoding;"/>

  <xsl:template match="press">
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
                      <a href="&rsslink;" title="RSS 2.0 Feed">
                        RSS 2.0 Feed
                      </a>
                    </li>
                  </ul>
                </div> <!-- FEEDLINKS -->
              </div> <!-- SIDEWRAP -->

	      <div id="CONTENTWRAP">

	      &header3;

		<xsl:call-template name="html-news-list-press-preface" />

	<xsl:call-template name="html-news-list-press">
          <xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
          <xsl:with-param name="news.press.xml" select="$news.press.xml" />
	</xsl:call-template>

		<xsl:call-template name="html-press-make-olditems-list" />

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
