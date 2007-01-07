<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY enbase "../../..">
<!ENTITY email "freebsd-ia64">
<!ENTITY title "FreeBSD/ia64 Projekt">
<!ENTITY % navinclude.developers "INCLUDE">
]>

<!-- FreeBSD Hungarian Documentation Project
     Translated by: Gabor Kovesdan <gabor@FreeBSD.org>
     Original Revision: r1.6				-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD$'"/>

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

		<p>Az ia64 levelez&eacute;si lista arch&iacute;vumok keres&eacute;se:</p>

		<form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
		  <input name="words" size="50" type="text"/>
		  <input name="max" type="hidden" value="25"/>
		  <input name="source" type="hidden" value="freebsd-ia64"/>
		  <input type="submit" value="Go"/>
		</form>

		<h3><a name="toc">Tartalom</a></h3>

		<ul>
		  <li>
		    <a href="#intro">Bevezet&eacute;s</a>
		  </li>
		  <li>
		    <a href="#status">Jelenlegi &aacute;llapot</a>
		  </li>
		  <li>
		    <a href="todo.html">Ami m&eacute;g h&aacute;tra van</a>
		  </li>
		  <li>
		    <a href="machines.html">Hardverlista</a>
		  </li>
		  <li>
		    <a href="refs.html">Referenci&aacute;k</a>
		  </li>
		</ul>

		<h3><a name="intro">Bevezet&eacute;s</a></h3>

		<p>Ez az oldal az Intel IA-64 architekt&uacut;r&aacute;n -
		  hivatalosan Intel Itanium&reg; Processor Family (IPF) -
		  fut&oacute; FreeBSD portr&oacute;l tartalmaz
		  inform&aacute;ci&oacute;kat.  Ahogyan a port
		  is, ezek az oldalak is fejleszt&eacute;s alatt
		  &aacute;llnak.</p>

		<h3><a name="status">Jelenlegi &aacute;llapot</a></h3>

		<p>Az ia64 port m&eacute;g egy Tier 2 platformnak
		  min&#245;s&uuml;l.  Ez azt jelenti, hogy nem teljesen
		  t&aacute;mogatott a Security Officer, Release Engineer
		  csapatok &eacute; a toolchain karbantart&oacute;k
		  &aacute;ltal.  A gyakorlatban azonban a  Tier 1
		  (teljesen t&aacute;mogatott) &eacute;s Tier 2 platformok
		  k&ouml;zt nem olyan nagy a k&uuml;l&ouml;nbs&eacute;g,
		  amekkor&aacute;nak t&#251;nik.  Sok szempontb&oacute;l az
		  ia64 port egy Tier 1 platform.
		  <br/>
		  A fejleszt&#245;k szemsz&ouml;g&eacute;b&#245;l azonban
		  el&#245;ny&ouml;s, hogy az ia64 port hosszabb ideig marad
		  Tier 2 platform.  Sok, az ABI-t &eacute;rint&#245;
		  v&aacute;ltoztat&aacute;s van folyamatban, &eacute;s a
		  kompatibilit&aacute;s megtart&aacute;sa nem ide&aacute;lis
		  ebben a kezdeti szakaszban.</p>
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
