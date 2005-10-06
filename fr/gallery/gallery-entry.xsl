<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- 
   The FreeBSD French Documentation Project
   Original revision: 1.2

   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>
  <xsl:variable name="section" select="'about'"/>

  <!-- Should be set on the command line, specifies the type of entries to
       include in the output.  One of "commercial", "nonprofit", or 
       "personal" -->
  <xsl:param name="type"/>

  <xsl:variable name="base" select="'..'"/>
  
  <xsl:variable name="date" select="'$FreeBSD: www/fr/gallery/gallery-entry.xsl,v 1.1 2003/08/17 12:22:28 stephane Exp $'"/>

  <xsl:output type="html" encoding="iso-8859-1"/>

  <xsl:variable name="title">
    <xsl:choose>
      <xsl:when test="$type = 'commercial'">Galerie - Commercial</xsl:when>
      <xsl:when test="$type = 'nonprofit'">Galerie - Organisations &#224; but non-lucratif</xsl:when>
      <xsl:when test="$type = 'personal'">Galerie - Pages personnelles</xsl:when>
      <xsl:otherwise>
	Unknown value for $type: <xsl:value-of select="$type"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="commercial-intro">
    <p>A travers le monde entier, FreeBSD fait fonctionner des applications et 
      des services Internet innovants. Cette galerie expose les organisations 
      commerciales qui ont utilis&#233; FreeBSD pour r&#233;aliser leurs travaux. Regardez 
      et d&#233;couvrez tout ce que FreeBSD peut faire pour <b>vous</b>.</p>
  </xsl:variable>

  <xsl:variable name="nonprofit-intro">
    <p>A travers le monde entier, FreeBSD fait fonctionner des applications et 
      des services Internet innovants. Cette galerie expose les organisations 
      &#224; but non-lucratif qui ont utilis&#233; FreeBSD pour r&#233;aliser leurs travaux. Regardez
      et d&#233;couvrez tout ce que FreeBSD peut faire pour <b>vous</b>.</p>
  </xsl:variable>

  <xsl:variable name="personal-intro">
    <p>A travers le monde entier, FreeBSD fait fonctionner des applications et 
      des services Internet innovants. Cette galerie expose les sites 
      personnels qui ont utilis&#233; FreeBSD pour r&#233;aliser leurs travaux. Regardez
      et d&#233;couvrez tout ce que FreeBSD peut faire pour <b>vous</b>.</p>
  </xsl:variable>

  <xsl:template match="gallery">
    <html>
      <xsl:copy-of select="$header1"/>
      
            <body xsl:use-attribute-sets="att.body">
      
        <div id="containerwrap">
          <div id="container">
      
      	<xsl:copy-of select="$header2"/>
      
      	<div id="content">
      
      	      <xsl:copy-of select="$sidenav"/>
      
      	      <div id="contentwrap">
      	      
	      <xsl:copy-of select="$header3"/>

	<xsl:choose>
	  <xsl:when test="$type = 'commercial'">
	    <xsl:copy-of select="$commercial-intro"/>
	  </xsl:when>
	  <xsl:when test="$type = 'nonprofit'">
	    <xsl:copy-of select="$nonprofit-intro"/>
	  </xsl:when>
	  <xsl:when test="$type = 'personal'">
	    <xsl:copy-of select="$personal-intro"/>
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

	  	</div> <!-- contentwrap -->
		<br class="clearboth" />
	
	</div> <!-- content -->
	
	<xsl:copy-of select="$footer"/>
	
        </div> <!-- container -->
   </div> <!-- containerwrap -->

      </body>
    </html>
  </xsl:template>

  <xsl:template match="entry">
    <xsl:variable name="url"><xsl:value-of select="url"/></xsl:variable>
    <li><a href="{$url}"><b><xsl:value-of select="name"/></b></a> --
      <xsl:value-of select="descr"/></li>
  </xsl:template>
</xsl:stylesheet>
