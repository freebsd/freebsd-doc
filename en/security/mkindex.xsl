<?xml version="1.0"?>

<!-- $FreeBSD: www/en/security/mkindex.xsl,v 1.2 2003/10/11 07:12:58 hrs Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/en/security/mkindex.xsl,v 1.2 2003/10/11 07:12:58 hrs Exp $'"/>
  <xsl:variable name="title" select="'untitled'"/>

  <xsl:param name="ftpbase" select="''" />
  <xsl:param name="ftpbaseold" select="''" />

  <xsl:output type="xml" encoding="iso-8859-1"
              omit-xml-declaration="yes" />

  <xsl:template match="/">
    <xsl:for-each select="descendant::release">

      <xsl:param name="relname" select="string(name)" />
      <xsl:param name="items" select="//advisory[$relname = string(following::release/name[1])]" />

      <xsl:call-template name="putitems">
	<xsl:with-param name="items" select="$items" />
      </xsl:call-template>

      <p><xsl:value-of select="name" /> released.</p>
    </xsl:for-each>

    <xsl:call-template name="putitems">
      <xsl:with-param name="items" select="//advisory[not(following::release/name[1])]" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="putitems">
    <xsl:param name="items" select="''" />

    <xsl:if test="$items">
      <ul>
	<xsl:for-each select="$items">
	  <li>
	    <xsl:choose>
	      <xsl:when test="name/@role='old'">
		<a><xsl:attribute name="href">
		    <xsl:value-of select="concat($ftpbaseold, name, '.asc')" />
		  </xsl:attribute>
		  <xsl:value-of select="concat(name, '.asc')" /></a>
	      </xsl:when>
	      <xsl:otherwise>
		<a><xsl:attribute name="href">
		    <xsl:value-of select="concat($ftpbase, name, '.asc')" />
		  </xsl:attribute>
		  <xsl:value-of select="concat(name, '.asc')" /></a>
	      </xsl:otherwise>
	    </xsl:choose>
	  </li>
	</xsl:for-each>
      </ul>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
