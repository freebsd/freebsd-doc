<?xml version="1.0"?>

<!-- $FreeBSD: www/share/sgml/templates.usergroups.xsl,v 1.3 2005/10/04 17:18:41 hrs Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">

  <xsl:import href="includes.xsl" />
  <xsl:variable name="section" select="'community'"/>

  <xsl:output method="xml"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

  <xsl:variable name="base" select="'../..'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>
  <xsl:variable name="email" select="'freebsd-www'"/>
  <xsl:variable name="title" select="'User Groups'"/>

  <xsl:template match="/">
    <html>
      <xsl:copy-of select="$header1"/>

      <body xsl:use-attribute-sets="att.body">
        <div id="CONTAINERWRAP">
          <div id="CONTAINER">
	    <xsl:copy-of select="$header2"/>

	    <div id="CONTENT">
      	      <xsl:copy-of select="$sidenav"/>

      	      <div id="CONTENTWRAP">
		<xsl:copy-of select="$header3"/>

	<xsl:call-template name="html-usergroups-list-header" />

	<xsl:call-template name="html-usergroups-list-regions">
          <xsl:with-param name="usergroups.xml" select="$usergroups.xml" />
          <xsl:with-param name="usergroups-local.xml" select="$usergroups-local.xml" />
	</xsl:call-template>

	<xsl:call-template name="html-usergroups-list-entries">
          <xsl:with-param name="usergroups.xml" select="$usergroups.xml" />
          <xsl:with-param name="usergroups-local.xml" select="$usergroups-local.xml" />
	</xsl:call-template>

	      </div> <!-- CONTENTWRAP -->
	      <br class="clearboth" />
	    </div> <!-- CONTENT -->

	    <xsl:copy-of select="$footer"/>

	  </div> <!-- CONTAINER -->
	</div> <!-- CONTAINERWRAP -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
