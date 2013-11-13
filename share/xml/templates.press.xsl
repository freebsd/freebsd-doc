<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD in the Press">
<!ENTITY rsslink "press-rss.xml">
<!ENTITY rsstitle "&title;">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:param name="news.press.xml-master" select="'none'" />
  <xsl:param name="news.press.xml" select="'none'" />

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:variable name="rsstitle">&rsstitle;</xsl:variable>

  <xsl:variable name="rsslink">&rsslink;</xsl:variable>

  <xsl:template name="process.content">
              <div id="sidewrap">
                &nav.about;
                <div id="feedlinks">
                  <ul>
                    <li>
                      <a href="&rsslink;" title="FreeBSD in the Press RSS 2.0 Feed">
                        RSS 2.0 Feed
                      </a>
                    </li>
                  </ul>
                </div> <!-- FEEDLINKS -->
              </div> <!-- SIDEWRAP -->

	      <div id="contentwrap">

	      <h1>&title;</h1>

		<xsl:for-each select="/press">
		<xsl:call-template name="html-news-list-press-preface" />

	<xsl:call-template name="html-news-list-press">
          <xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
          <xsl:with-param name="news.press.xml" select="$news.press.xml" />
	</xsl:call-template>

		<xsl:call-template name="html-press-make-olditems-list" />

		<xsl:call-template name="html-news-list-newsflash-homelink" />
		</xsl:for-each>

	  	</div> <!-- CONTENTWRAP -->
		<br class="clearboth" />
  </xsl:template>
</xsl:stylesheet>
