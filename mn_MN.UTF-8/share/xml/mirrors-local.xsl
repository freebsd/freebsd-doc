<?xml version="1.0" encoding="utf-8"?>
<!--
     The FreeBSD Mongolian Documentation Project

     $FreeBSD$

     Original revision 1.3
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/xml/mirrors-master.xsl -->
  <xsl:import href="../../../share/xml/mirrors-master.xsl" />

  <xsl:output type="xml" encoding="utf-8"
	      indent="yes"/>

  <!-- template: "mirrors-docbook-contact" -->

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" select="'someone@somewhere'"/>

    <para>Асуудлууд гарвал энэ домэйны администратор
      <email><xsl:value-of select="$email" /></email>-т хандана уу.</para>
  </xsl:template>

</xsl:stylesheet>
