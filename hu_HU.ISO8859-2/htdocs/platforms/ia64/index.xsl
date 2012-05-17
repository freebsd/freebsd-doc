<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY enbase "../../..">
<!ENTITY email "freebsd-ia64">
<!ENTITY title "A &os;/ia64 projekt">
<!ENTITY % navinclude.developers "INCLUDE">
]>

<!-- FreeBSD Hungarian Documentation Project
     Translated by: Gabor Kovesdan <gabor@FreeBSD.org>
     %SOURCE%	en/platforms/ia64/index.xsl
     %SRCID%	1.7
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD: www/hu/platforms/ia64/index.xsl,v 1.3 2008/06/25 11:31:18 gabor Exp $'"/>

  <xsl:output doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    encoding="iso-8859-2" method="html"/>
  <xsl:template match="/">
    <html>
      &header1;
      <body>

	<div id="CONTAINERWRAP">
	  <div id="CONTAINER">
	    &header2;

	    <div id="CONTENT">
	      <div id="SIDEWRAP">
                &nav;
              </div> <!-- SIDEWRAP -->

	      <div id="CONTENTWRAP">
		&header3;

		<img align="right" alt="McKinley die" src="&enbase;/platforms/ia64/mckinley-die.png"/>

		<p>Keres&eacute;s az ia64 levelez&eacute;si lista
		  arch&iacute;vum&aacute;ban:</p>

		<form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
		  <input name="words" size="50" type="text"/>
		  <input name="max" type="hidden" value="25"/>
		  <input name="source" type="hidden" value="freebsd-ia64"/>
		  <input type="submit" value="Go"/>
		</form>

		<h3><a name="toc">Tartalomjegyz&eacute;k</a></h3>

		<ul>
		  <li>
		    <a href="#intro">Bevezet&eacute;s</a>
		  </li>
		  <li>
		    <a href="#status">Helyzet</a>
		  </li>
		  <li>
		    <a href="todo.html">Tov&aacute;bbi teend&#245;k</a>
		  </li>
		  <li>
		    <a href="machines.html">Hardverlista</a>
		  </li>
		  <li>
		    <a href="refs.html">Hivatkoz&aacute;sok</a>
		  </li>
		</ul>

		<h3><a name="intro">Bevezet&eacute;s</a></h3>

		<p>Ez az oldal az Intel IA-64
		  architekt&uacute;r&aacute;n &mdash; hivatalosan Intel
		  Itanium&reg; Processor Family (IPF) &mdash;
		  fut&oacute; &os; portr&oacute;l tartalmaz
		  inform&aacute;ci&oacute;kat.  Ahogyan a port is,
		  &uacute;gy ez az oldal is folyamatos fejleszt&eacute;s
		  alatt &aacute;ll.</p>

		<h3><a name="status">Helyzet</a></h3>

		<p>Az ia64 port jelenleg m&eacute;g Tier 2 platformnak
		  min&#245;s&uuml;l.  Ez azt jelenti, hogy m&eacute;g
		  nem t&aacute;mogatj&aacute;k teljes
		  m&eacute;rt&eacute;kben a Security Officer, Release
		  Engineer csapatok &eacute;s a toolchainek
		  karbantart&oacute;i sem.  A gyakorlatban azonban a
		  Tier 1 (teljesen t&aacute;mogatott) &eacute;s Tier 2
		  szint&#251; platformok k&ouml;zt nem olyan nagy a
		  k&uuml;l&ouml;nbs&eacute;g, mint amekkor&aacute;nak
		  els&#245;re t&#251;nik.  Sok szempontb&oacute;l az
		  ia64 port l&eacute;nyeg&eacute;ben egy Tier 1
		  szint&#251; platform.  <br/>
		  A fejleszt&#245;k szemsz&ouml;g&eacute;b&#245;l
		  azonban el&#245;ny&ouml;s, hogy az ia64 port hosszabb
		  ideig marad Tier 2 platform.  Sok, az ABI-t
		  &eacute;rint&#245; v&aacute;ltoztat&aacute;s van
		  folyamatban, &eacute;s a kompatibilit&aacute;s
		  felt&eacute;tlen megtart&aacute;sa m&eacute;g nem
		  c&eacute;lszer&#251; ebben a kezdeti szakaszban.</p>
	      </div> <!-- CONTENTWRAP -->

	      <br class="clearboth" />
	    </div> <!-- CONTENT -->

            <div id="FOOTER">
               &copyright;<br />
               &date;
            </div> <!-- FOOTER -->
	  </div> <!-- CONTAINER -->
	</div> <!-- CONTAINERWRAP -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
