<?xml version="1.0" encoding="koi8-r"?>
<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/doc/ru_RU.KOI8-R/share/sgml/transtable-local.xsl,v 1.1 2003/11/27 14:01:07 den Exp $
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/sgml/transtable-master.xsl -->
  <xsl:import href="../../../share/sgml/transtable-master.xsl" />

  <xsl:output type="xml" encoding="koi8-r"
	      indent="yes"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="transtable.xml" select="'./transtable.xml'" />
  <xsl:param name="transtable-conv-element" select="''" />
</xsl:stylesheet>
