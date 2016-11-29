<?xml version='1.0' encoding='iso-8859-7'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

  <xsl:param name="local.l10n.xml" select="document('')"/>
  <i18n xmlns="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0" language="el">
      <l:gentext key="Lastmodified" text="Τελευταία τροποποίηση"/>
      <l:gentext key="on" text="στις"/>
    </l:l10n>
  </i18n>

  <xsl:template name="user.footer.navigation">
    <p align="center"><small>Αυτό το κείμενο, και άλλα κείμενα, μπορεί να βρεθεί στο
    <a href="ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/">ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/</a></small></p>

    <p align="center"><small>Για ερωτήσεις σχετικά με το FreeBSD, διαβάστε την
    <a href="http://www.FreeBSD.org/docs.html">τεκμηρίωση</a> πριν να επικοινωνήσετε με την
    &lt;<a href="mailto:questions@FreeBSD.org">questions@FreeBSD.org</a>&gt;.<br/>
    Για ερωτήσεις σχετικά με αυτή την τεκμηρίωση, στείλτε e-mail στην
    &lt;<a href="mailto:doc@FreeBSD.org">doc@FreeBSD.org</a>&gt;.</small></p>
  </xsl:template>
</xsl:stylesheet>
