<?xml version="1.0" encoding="iso-8859-1"?>
<!-- The FreeBSD Dutch Documentation Project
     $FreeBSD$
     %SOURCE%	share/xml/mirrors-local.xsl
     %SRCID%	41645
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/xml/mirrors-master.xsl -->
  <xsl:import href="../../../share/xml/mirrors-master.xsl" />

  <xsl:output type="xml" encoding="iso-8859-1"
	      indent="yes"/>

  <!-- these params should be externally bound.  The values
       here are not used actually -->
  <xsl:param name="proto" select="''" />
  <xsl:param name="target" select="''" />

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" value="'iemand@ergens'" />

    <para>Begeeft u zich bij problemen alstublieft naar de beheerder
      <email><xsl:value-of select="$email" /></email> van dit domein.</para>
  </xsl:template>

  <xsl:template name="mirrors-lastmodified">
    <xsl:text>bijgewerkt op: </xsl:text>
    <xsl:call-template name="mirrors-lastmodified-utc" />
  </xsl:template>

</xsl:stylesheet>
