<?xml version="1.0" encoding="iso-8859-2"?>
<!-- $FreeBSD$ -->

<!-- The FreeBSD Hungarian Documentation Project
     Translated by: PALI, Gabor <pgj@FreeBSD.org>
     %SOURCE%	share/xml/mirrors-master.xsl
     %SRCID%	1.6
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs"
  extension-element-prefixes="str">

  <!-- must point to master copy, doc/share/xml/mirrors-master.xsl -->
  <xsl:import href="../../../share/xml/mirrors-master.xsl" />

  <xsl:variable name="svnKeyword">
    <xsl:value-of select="normalize-space(//cvs:keyword[1])"/>
  </xsl:variable>

  <xsl:variable name="date">
    <xsl:value-of select="str:split($svnKeyword, ' ')[4]"/>
  </xsl:variable>

  <xsl:output type="xml" encoding="iso-8859-2"
	      indent="yes"/>

  <xsl:param name="mirrors-docbook-country-anchor-id" select="translate($target, '/.', '--')" />

  <!--
     templates available:

        * "mirrors-lastmodified"
        * "mirrors-docbook-contact"
  -->

  <!-- template: "mirrors-docbook-contact" -->

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" select="'someone@somewhere'"/>

    <para>Bármilyen gond esetén a következő címet kell értesíteni:
      <email><xsl:value-of select="$email" /></email>.</para>
  </xsl:template>

  <!-- template: "mirrors-lastmodified" -->

  <xsl:template name="mirrors-lastmodified">
    <xsl:text>Dátum: </xsl:text>
    <xsl:call-template name="mirrors-lastmodified-utc" />
  </xsl:template>
</xsl:stylesheet>
