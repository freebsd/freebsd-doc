<?xml version="1.0" encoding="koi8-r"?>
<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/doc/ru_RU.KOI8-R/share/sgml/mirrors-local.xsl,v 1.1 2003/11/27 14:01:07 den Exp $
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/sgml/mirrors-master.xsl -->
  <xsl:import href="../../../share/sgml/mirrors-master.xsl" />

  <xsl:output type="xml" encoding="koi8-r"
	      omit-xml-declaration="yes"
	      indent="yes"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="proto" select="''" />
  <xsl:param name="target" select="''" />

  <!-- template: "mirrors-docbook-contact" -->

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" select="'someone@somewhere'"/>

    <para>В случае проблем пожалуйста свяжитесь с администратором
      <email><xsl:value-of select="$email" /></email> этого домена.</para>
  </xsl:template>

</xsl:stylesheet>
