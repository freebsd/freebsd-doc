<?xml version="1.0" encoding="iso-8859-1"?>

<!--
     The FreeBSD Italian Documentation Project

     $FreeBSD$
     Original revision: 1.2
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/xml/mirrors-master.xsl -->
  <xsl:import href="../../../share/xml/mirrors-master.xsl" />

  <xsl:output type="xml" encoding="iso-8859-1"
	      omit-xml-declaration="yes"
	      indent="yes"/>

  <!-- template: "mirrors-docbook-contact" -->

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" value="'someone@somewhere'"/>

    <!-- for Italian version -->
    <para>In caso di problemi, contatta l'hostmaster
      <email><xsl:value-of select="$email" /></email> di questo
      dominio.</para>
  </xsl:template>

  <!-- template: "mirrors-lastmodified" -->

  <xsl:template name="mirrors-lastmodified">
    <xsl:text>aggiornato al </xsl:text>
    <xsl:call-template name="mirrors-lastmodified-utc" />
  </xsl:template>

</xsl:stylesheet>
