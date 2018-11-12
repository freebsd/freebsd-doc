<?xml version="1.0" encoding="euc-jp"?>
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/sgml/mirrors-master.xsl -->
  <xsl:import href="../../../share/sgml/mirrors-master.xsl" />

  <xsl:output type="xml" encoding="euc-jp"
	      omit-xml-declaration="yes"
	      indent="yes"/>

  <!-- template: "mirrors-docbook-contact" -->

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" value="'someone@somewhere'"/>

    <!-- for Japanese version -->
    <para>���꤬������ϡ����Υɥᥤ��Υۥ��ȥޥ���
        <email><xsl:value-of select="$email" /></email> ���ˤ��䤤��碌����������</para>
  </xsl:template>

  <!-- template: "mirrors-lastmodified" -->

  <xsl:template name="mirrors-lastmodified">
    <xsl:call-template name="mirrors-lastmodified-utc" />
    <xsl:text> ����</xsl:text>
  </xsl:template>

</xsl:stylesheet>
