<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "The &os; list of projects and ideas for volunteers">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.developers "INCLUDE">
<!ENTITY % developers PUBLIC "-//FreeBSD//ENTITIES FreeBSD Developers Entities//EN" "http://www.FreeBSD.org/XML/www/share/sgml/developers.ent"> %developers;
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/xhtml.xsl"/>

  <xsl:template name="process.content">
              <div id="SIDEWRAP">
                &nav;
              </div> <!-- SIDEWRAP -->

	      <div id="CONTENTWRAP">
		&header3;
<h2>Introduction</h2>

<p>The ideas page has moved to the <a
  href="http://wiki.freebsd.org/IdeasPage">FreeBSD wiki</a>.</p>

	      </div> <!-- CONTENTWRAP -->
	      <br class="clearboth" />
  </xsl:template>
</xsl:stylesheet>
