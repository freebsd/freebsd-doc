<?xml version="1.0" encoding="GB2312"?>
<!-- Original Revision: 1.3 -->
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/sgml/mirrors-master.xsl -->
  <xsl:import href="../../../share/sgml/mirrors-master.xsl" />

  <xsl:output type="xml" encoding="GB2312"
	      omit-xml-declaration="yes"
	      indent="yes"/>

  <!-- template: "mirrors-docbook-contact" -->

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" value="'someone@somewhere'"/>

    <para>�������⣬��͸����������������Ĺ���Ա
        <email><xsl:value-of select="$email" /></email>��ϵ��</para>
  </xsl:template>

  <!-- template: "mirrors-lastmodified" -->

  <xsl:template name="mirrors-lastmodified">
    <xsl:call-template name="mirrors-lastmodified-utc" />
    <xsl:text> ����</xsl:text>
  </xsl:template>

</xsl:stylesheet>
