<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

  <!-- Include the common customizations -->
  <xsl:include href="freebsd-common.xsl"/>

  <!-- Redefine variables, and replace templates as necessary here -->
  <xsl:param name="freebsd.output.html" select="'0'"/>
  <xsl:param name="freebsd.output.html.images" select="'0'"/>

  <!-- HTML specific customisation goes here -->

  <xsl:param name="html.stylesheet" select="'docbook.css'"/>
  <xsl:param name="user.id.as.filename" select="'1'"/>
  <xsl:param name="link.mailto.url" select="'doc@FreeBSD.org'"/>
  <xsl:param name="callout.graphics.path" select="'./imagelib/callouts/'"/>

  <xsl:template name="user.footer.content">
    <p align="center"><small>This, and other documents, can be downloaded
    from <a href="ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/">ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/</a></small></p>

    <p align="center"><small>For questions about FreeBSD, read the
    <a href="http://www.FreeBSD.org/docs.html">documentation</a> before
    contacting &lt;<a href="mailto:questions@FreeBSD.org">questions@FreeBSD.org</a>&gt;.<br/>
    For questions about this documentation, e-mail &lt;<a href="mailto:doc@FreeBSD.org">doc@FreeBSD.org</a>&gt;.</small></p>
  </xsl:template>

  <xsl:template match="hostid|username|groupname|devicename|maketarget|makevar">
    <xsl:call-template name="inline.monoseq"/>
  </xsl:template>
</xsl:stylesheet>
