<?xml version="1.0" encoding="koi8-r"?>
<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/doc/ru_RU.KOI8-R/share/sgml/mirrors-local.xsl,v 1.2 2004/01/22 15:09:41 den Exp $

     Original revision 1.3
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/sgml/mirrors-master.xsl -->
  <xsl:import href="../../../share/sgml/mirrors-master.xsl" />

  <xsl:output type="xml" encoding="koi8-r"
	      omit-xml-declaration="yes"
	      indent="yes"/>

  <!-- template: "mirrors-docbook-contact" -->

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" select="'someone@somewhere'"/>

    <para>В случае проблем пожалуйста свяжитесь с администратором
      <email><xsl:value-of select="$email" /></email> этого домена.</para>
  </xsl:template>

</xsl:stylesheet>
