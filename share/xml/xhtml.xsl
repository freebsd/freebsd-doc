<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:str="http://exslt.org/strings"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="cvs xhtml"
  extension-element-prefixes="str">

  <xsl:variable name="rsslink" select="''"/>

  <xsl:variable name="rsstitle" select="''"/>

  <xsl:variable name="svnKeyword">
    <xsl:value-of select="normalize-space(//cvs:keyword[1])"/>
  </xsl:variable>

  <xsl:variable name="date">
    <xsl:value-of select="str:split($svnKeyword, ' ')[4]"/>
  </xsl:variable>

  <xsl:variable name="title">
    <xsl:value-of select="/xhtml:html/xhtml:head/xhtml:title"/>
  </xsl:variable>

  <xsl:output type="xml" encoding="&xml.encoding;"
    indent="yes"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
	<title><xsl:value-of select="$title" /></title>
	<xsl:copy-of select="/xhtml:html/xhtml:head/xhtml:base" />
	<meta http-equiv="Content-Type" content="text/html; charset=&xml.encoding;" />
	<xsl:copy-of select="/xhtml:html/xhtml:head/xhtml:meta"/>
	<link rel="shortcut icon" href="&enbase;/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" media="screen,print" href="&stylesheet;" type="text/css"/>
	<xsl:copy-of select="/xhtml:html/xhtml:head/xhtml:link"/>
	<xsl:call-template name="process.rss.link"/>
	&header1.googlejs;
      </head>

      <body>
	<div id="containerwrap">
	  <div id="container">
	    &header2;

	    <div id="content">
	      <xsl:call-template name="process.content"/>
	    </div> <!-- CONTENT -->

	    <div id="footer">
	      <xsl:call-template name="process.footer"/>
	    </div> <!-- FOOTER -->
	  </div> <!-- CONTAINER -->
	</div> <!-- CONTAINERWRAP -->
      </body>
    </html>
  </xsl:template>

  <xsl:template name="process.rss.link">
    <xsl:if test="$rsslink != ''">
      <link rel="alternate" type="application/rss+xml"
	title="{$rsstitle}" href="{$rsslink}" />
    </xsl:if>
  </xsl:template>

  <xsl:template name="process.sidewrap">
              <xsl:choose xmlns:xhtml="http://www.w3.org/1999/xhtml">
                <xsl:when test="xhtml:html/xhtml:body/@class = 'navinclude.about'">
                  &nav.about;
                </xsl:when>

                <xsl:when test="xhtml:html/xhtml:body/@class = 'navinclude.community'">
                  &nav.community;
                </xsl:when>

                <xsl:when test="xhtml:html/xhtml:body/@class = 'navinclude.developers'">
                  &nav.developers;
                </xsl:when>

                <xsl:when test="xhtml:html/xhtml:body/@class = 'navinclude.docs'">
                  &nav.docs;
                </xsl:when>

                <xsl:when test="xhtml:html/xhtml:body/@class = 'navinclude.download'">
                  &nav.download;
                </xsl:when>

                <xsl:when test="xhtml:html/xhtml:body/@class = 'navinclude.gnome'">
                  &nav.gnome;
                </xsl:when>

                <xsl:when test="xhtml:html/xhtml:body/@class = 'navinclude.ports'">
                  &nav.ports;
                </xsl:when>

                <xsl:when test="xhtml:html/xhtml:body/@class = 'navinclude.support'">
                  &nav.support;
                </xsl:when>
              </xsl:choose>
  </xsl:template>

  <xsl:template name="process.content">
	    <div id="sidewrap">
      <xsl:call-template name="process.sidewrap"/>
	    </div> <!-- SIDEWRAP -->

	    <div id="contentwrap">
      <xsl:call-template name="process.contentwrap"/>
	    </div> <!-- CONTENTWRAP -->

	    <br class="clearboth" />
  </xsl:template>

  <xsl:template name="process.contentwrap">
    <h1><xsl:value-of select="$title" /></h1>

    <xsl:for-each select="xhtml:html/xhtml:body">
      <xsl:apply-templates />
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="db:email">
    <xsl:text>&lt;</xsl:text>
    <xsl:choose>
      <xsl:when test="@role='nolink'">
	<xsl:apply-templates />
      </xsl:when>
      <xsl:otherwise>
	<a>
	  <xsl:attribute name="href">
	    <xsl:text>mailto:</xsl:text>
	    <xsl:value-of select="." />
	  </xsl:attribute>
	  <xsl:apply-templates />
	</a>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&gt;</xsl:text>
  </xsl:template>

  <xsl:template match="xhtml:*">
    <xsl:copy xmlns:xhtml="http://www.w3.org/1999/xhtml">
      <xsl:for-each select="@*">
        <xsl:copy />
      </xsl:for-each>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <xsl:template name="process.footer">
    &copyright;<br/>
    <xsl:if test="$date != ''">
      &lastmod; <xsl:value-of select="$date"/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
