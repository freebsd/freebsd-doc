<?xml version="1.0" encoding="iso-8859-2"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<!-- The FreeBSD Hungarian Documentation Project
     Translated by: PALI, Gabor <pgj@FreeBSD.org>
     %SOURCE%	en/security/errata-rss.xsl
     %SRCID%	1.1
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <xsl:call-template name="rss-errata-notices">
       <xsl:with-param name="notices.xml" select="$notices.xml" />
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
