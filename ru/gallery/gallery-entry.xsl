<?xml version="1.0" encoding="KOI8-R" ?>

<!-- The FreeBSD Russian Documentation Project -->
<!-- $FreeBSDru: frdp/www/ru/gallery/gallery-entry.xsl,v 1.2 2001/12/05 19:08:36 phantom Exp $ -->
<!-- Original revision: 1.1 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>

  <!-- Should be set on the command line, specifies the type of entries to
       include in the output.  One of "commercial", "nonprofit", or 
       "personal" -->
  <xsl:param name="type"/>

  <xsl:variable name="base" select="'..'"/>
  
  <xsl:variable name="date" select="'$FreeBSD$'"/>

  <xsl:output type="html" encoding="koi8-r"/>

  <xsl:variable name="title">
    <xsl:choose>
      <xsl:when test="$type = 'commercial'">Галерея - Коммерческие компании</xsl:when>
      <xsl:when test="$type = 'nonprofit'">Галерея - Некоммерческие организации</xsl:when>
      <xsl:when test="$type = 'personal'">Галерея - Частные лица</xsl:when>
      <xsl:otherwise>
	Unknown value for $type: <xsl:value-of select="$type"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="commercial-intro">
    <p>Во всём мире FreeBSD используется для обеспечения работы самых
      современных приложений и служб Internet.  В этой галерее представлены
      коммерческие компании, которые выбрали FreeBSD.  Посмотрите и выберите,
      что ещё может сделать FreeBSD для <b>вас</b>!</p>
  </xsl:variable>

  <xsl:variable name="nonprofit-intro">
    <p>Во всём мире FreeBSD используется для обеспечения работы самых
      современных приложений и служб Internet. В этой галерее представлены
      некоммерческие организации, которые выбрали FreeBSD. Посмотрите и
      может быть, вы увидите, что ещё может сделать FreeBSD для <b>вас</b>!</p>
  </xsl:variable>

  <xsl:variable name="personal-intro">
    <p>Во всём мире FreeBSD используется для обеспечения работы самых
      современных приложений и служб Internet. В этой галерее представлены
      частные лица, выбравшие FreeBSD. Посмотрите и может быть, вы увидите,
      что ещё может сделать FreeBSD для <b>вас</b>!</p>
  </xsl:variable>

  <xsl:template match="gallery">
    <html>
      <xsl:copy-of select="$header1"/>
      <body xsl:use-attribute-sets="att.body">
	<xsl:copy-of select="$header2"/>

	<xsl:choose>
	  <xsl:when test="$type = 'commercial'">
	    <xsl:copy-of select="$commercial-intro"/>
	  </xsl:when>
	  <xsl:when test="$type = 'nonprofit'">
	    <xsl:copy-of select="$nonprofit-intro"/>
	  </xsl:when>
	  <xsl:when test="$type = 'personal'">
	    <xsl:copy-of select="personal-intro"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <p>No clue what to put here for $type = 
	      <xsl:value-of select="$type">.</xsl:value-of></p>
	  </xsl:otherwise>
	</xsl:choose>

	<ul>
	  <!-- Select all entries of the correct type, doing a case
               insensitive sort -->
	  <xsl:apply-templates select="entry[@type = $type]">
	    <xsl:sort select="translate(string(./name),
		      'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 
		      'abcdefghijklmnopqrstuvwxyz')"/>
	  </xsl:apply-templates>
	</ul>

	<xsl:copy-of select="$footer"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="entry">
    <xsl:variable name="url"><xsl:value-of select="url"/></xsl:variable>
    <li><a href="{$url}"><b><xsl:value-of select="name"/></b></a> --
      <xsl:value-of select="descr"/></li>
  </xsl:template>
</xsl:stylesheet>
