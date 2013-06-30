<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	$FreeBSD$
	$FreeBSDde: de-docproj/share/xml/mirrors-local.xsl,v 1.2 2003/12/22 23:53:27 mheinen Exp $
	basiert auf: 1.2
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/xml/mirrors-master.xsl -->
  <xsl:import href="../../../share/xml/mirrors-master.xsl" />

  <xsl:output type="xml" encoding="iso-8859-1"
	      indent="yes"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="proto" select="''" />
  <xsl:param name="target" select="''" />

  <!-- template: "mirrors-docbook-contact" -->

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" value="'someone@somewhere'"/>

    <para>Bei Problemen wenden Sie sich bitte an den Betreuer
      <email><xsl:value-of select="$email" /></email> dieser Domain.</para>
  </xsl:template>

  <!-- template: "mirrors-lastmodified" -->

  <xsl:template name="mirrors-lastmodified">
    <xsl:text>aktualisiert am: </xsl:text>
    <xsl:call-template name="mirrors-lastmodified-utc" />
  </xsl:template>
</xsl:stylesheet>
