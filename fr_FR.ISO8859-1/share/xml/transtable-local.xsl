<?xml version="1.0" encoding="iso-8859-1"?>
<!-- $FreeBSD$ -->

<!--
     The FreeBSD French Documentation Project
     Original revision: 1.2

     Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- must point to master copy, doc/share/xml/transtable-master.xsl -->
  <xsl:import href="../../../share/xml/transtable-master.xsl" />

  <xsl:output type="xml"
	      indent="yes"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="transtable.xml" select="'./transtable.xml'" />
  <xsl:param name="transtable-sortkey.xml" select="'./transtable-sortkey.xml'" />

  <xsl:param name="transtable-target-element" select="''" />
  <xsl:param name="transtable-word-group" select="''" />
  <xsl:param name="transtable-mode" select="''" />

</xsl:stylesheet>
