<?xml version="1.0" encoding="utf-8"?>
<!-- Original Revision: 48c0df24d2 (r41645) -->
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/xml/mirrors-master.xsl -->
  <xsl:import href="../../../share/xml/mirrors-master.xsl" />

  <xsl:output type="xml" encoding="utf-8"
	      indent="yes"/>

  <!-- template: "mirrors-docbook-contact" -->

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" value="'someone@somewhere'"/>

    <para>如有问题， 请和负责相关子域服务器的管理员
        <email><xsl:value-of select="$email" /></email> 联系。</para>
  </xsl:template>

  <!-- template: "mirrors-lastmodified" -->

  <xsl:template name="mirrors-lastmodified">
    <xsl:call-template name="mirrors-lastmodified-utc" />
    <xsl:text> 更新</xsl:text>
  </xsl:template>

</xsl:stylesheet>
