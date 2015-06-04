<?xml version='1.0' encoding='iso-8859-1'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

  <xsl:template name="user.footer.navigation">
    <p align="center"><small>Wenn Sie Fragen zu FreeBSD haben, schicken Sie eine E-Mail an
    &lt;<a href="mailto:de-bsd-questions@de.FreeBSD.org">de-bsd-questions@de.FreeBSD.org</a>&gt;.<br/>
    Wenn Sie Fragen zu dieser Dokumentation haben, schicken Sie eine E-Mail an
    &lt;<a href="mailto:de-bsd-translators@de.FreeBSD.org">de-bsd-translators@de.FreeBSD.org</a>&gt;.</small></p>
  </xsl:template>

  <xsl:param name="local.l10n.xml" select="document('')"/>
  <i18n xmlns="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0" language="de">
      <l:gentext key="Lastmodified" text="Zuletzt bearbeitet"/>
      <l:gentext key="on" text="am"/>
    </l:l10n>
  </i18n>
  
</xsl:stylesheet>
