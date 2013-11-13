<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<!--
  The FreeBSD French Documentation Project
  Original revision: 1.4

  Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		version="1.0">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>

  <xsl:variable name="svnKeyword" select="'$FreeBSD$'"/>

  <xsl:output type="xml" />

  <xsl:template match="/">
    <rdf:RDF
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns="http://my.netscape.com/rdf/simple/0.9/">

      <channel>
        <title>Nouvelles du Projet GNOME pour FreeBSD</title>
	<link>http://www.FreeBSD.org/gnome</link>
	<description>Système de nouvelles pour GNOME sous FreeBSD</description>
      </channel>

      <xsl:for-each select="descendant::event[position() &lt;= 10]">
      <item>
	<title>
        <xsl:choose>
	  <xsl:when test="count(child::title)">
            <xsl:value-of select="title"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="p"/>
	  </xsl:otherwise>
	</xsl:choose>
	</title>
	<link>http://www.FreeBSD.org/gnome/newsflash#<xsl:call-template name="generate-event-anchor"/></link>
      </item>
      </xsl:for-each>
   </rdf:RDF>
</xsl:template>
</xsl:stylesheet>
