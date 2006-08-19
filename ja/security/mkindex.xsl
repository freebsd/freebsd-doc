<?xml version="1.0" encoding="EUC-JP" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base ".">
<!ENTITY title "">
]>

<!-- $FreeBSD: www/ja/security/mkindex.xsl,v 1.2 2004/01/19 17:19:34 hrs Exp $ -->
<!-- Original revision: 1.4 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>
  
  <xsl:variable name="date" select="'$FreeBSD: www/ja/security/mkindex.xsl,v 1.2 2004/01/19 17:19:34 hrs Exp $'"/>

  <xsl:output type="xml" encoding="&xml.encoding;"
              omit-xml-declaration="yes" />

  <xsl:template match="/">
    <xsl:call-template name="html-list-advisories">
       <xsl:with-param name="advisories.xml" select="$advisories.xml" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="html-list-advisories-release-label">
    <xsl:param name="relname" select="'none'" />

    <p><xsl:value-of select="$relname" /> の公開。</p>
  </xsl:template>
</xsl:stylesheet>
