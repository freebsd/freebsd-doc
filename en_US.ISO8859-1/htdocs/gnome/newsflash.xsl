<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY base "..">
<!ENTITY title "FreeBSD GNOME News Flash">
<!ENTITY rsslink "&base;/gnome/rss.xml">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:variable name="rsstitle">&title;</xsl:variable>

  <xsl:variable name="rsslink">&rsslink;</xsl:variable>

  <xsl:template name="process.content">
              <div id="sidewrap">
                &nav.gnome;
                <div id="feedlinks">
                  <ul>
                    <li>
                      <a href="&rsslink;" title="GNOME RSS 2.0 Feed">
                        RSS 2.0 Feed
                      </a>
                    </li>
                    <li>
                      <a href="news.rdf" title="GNOME RDF/RSS 0.9 Feed">
                        RSS 0.9 Feed
                      </a>
                    </li>
                  </ul>
                </div> <!-- FEEDLINKS -->

              </div> <!-- SIDEWRAP -->

	      <div id="contentwrap">
		<h1>&title;</h1>

		<img src="&base;/gifs/news.jpg" align="right" border="0" width="193"
		  height="144" alt="FreeBSD GNOME News"/>

		<xsl:apply-templates select="/news/descendant::month"/>

		<xsl:for-each select="/news">
	        <xsl:call-template
		  name="html-news-list-newsflash-homelink" />
		</xsl:for-each>

	      </div> <!-- contentwrap -->

	      <br class="clearboth" />
  </xsl:template>

  <!-- Everything that follows are templates for the rest of the content -->

  <xsl:template match="month">
    <h1><xsl:value-of select="name"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="ancestor::year/name"/></h1>

    <ul>
      <xsl:apply-templates select="descendant::day"/>
    </ul>
  </xsl:template>

  <xsl:template match="day">
    <xsl:apply-templates select="event"/>
  </xsl:template>

  <xsl:template match="event">
    <li><p><a>
	  <xsl:attribute name="name">
	    <xsl:call-template name="generate-event-anchor"/>
	  </xsl:attribute>
	</a>

	<b><xsl:value-of select="ancestor::day/name"/>
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="ancestor::month/name"/>,
	  <xsl:value-of select="ancestor::year/name"/>:</b><xsl:text> </xsl:text>
	<xsl:apply-templates select="p" mode="copy.html"/>
	</p>

    </li>
  </xsl:template>

  <xsl:template match="date"/>    <!-- Deliberately left blank -->
</xsl:stylesheet>
