<?xml version="1.0" encoding="iso-8859-1"?>
<!-- $FreeBSD$ -->

<!--
     The FreeBSD French Documentation Project
     Original revision: 1.2

     Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/sgml/mirrors-master.xsl -->
  <xsl:import href="../../../share/sgml/mirrors-master.xsl" />

  <xsl:output type="xml" encoding="iso-8859-1"
	      omit-xml-declaration="yes"
	      indent="yes"/>

  <!-- template: "mirrors-docbook-contact" -->

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" select="'someone@somewhere'"/>

    <para>En cas de probl&#232;mes, merci de contacter le hostmaster
      <email><xsl:value-of select="$email" /></email> pour ce domaine.</para>
  </xsl:template>

  <!-- template: "mirrors-lastmodified" -->

  <xsl:template name="mirrors-lastmodified">
    <xsl:text>mis &#224; jour le </xsl:text>
    <xsl:call-template name="mirrors-lastmodified-utc" />
  </xsl:template>

</xsl:stylesheet>
