<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY email "freebsd-ia64">
<!ENTITY title "Proyecto FreeBSD/ia64">
<!ENTITY % navinclude.developers "INCLUDE">
]>

<!-- The FreeBSD Spanish Documentation Project
     Original Revision: r1.7			-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD$'"/>

  <xsl:output doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    encoding="iso-8859-1" method="html"/>
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

		<img align="right" alt="McKinley" src="&enbase;/platforms/mckinley-die.png"/>

		<p>Buscar los archivos de la lista de distribuci&oacute;n de
		  ia64:</p>

		<form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
		  <input name="words" size="50" type="text"/>
		  <input name="max" type="hidden" value="25"/>
		  <input name="source" type="hidden" value="freebsd-ia64"/>
		  <input type="submit" value="Go"/>
		</form>

		<h3><a name="toc">Contenidos</a></h3>

		<ul>
		  <li>
		    <a href="#intro">Introducci&oacute;n</a>
		  </li>
		  <li>
		    <a href="#status">Estado actual</a>
		  </li>
		  <li>
		    <a href="todo.html">Lo que hay que hacer</a>
		  </li>
		  <li>
		    <a href="machines.html">Lista de hardware</a>
		  </li>
		  <li>
		    <a href="refs.html">Referencias</a>
		  </li>
		</ul>

		<h3><a name="intro">Introducci&oacute;n</a></h3>

		<p>Las p&aacute;ginas del Proyecto FreeBSD/ia64 project
		  contienen informaciones sobre el port de FreeBSD para la
		  arquitectura IA-64 de Intel, oficialmente conocida como
		  Intel&nbsp;Itanium&reg; Processor Family (IPF).  Como el port
		  mismo, estas p&aacute;ginas est&aacute;n siendo
		  preparadas.</p>

		<h3><a name="status">Estado actual</a></h3>

		<p>El platforma ia64 todav&iacute;a se considere una platforma
		  de la categor&iacute;a Tier 2.  Esto significa no estar
		  completamente soportada por nuestro security officer,
		  ingenieros de release y mantenedores de los toolchain.
		  Pr&aacute;cticamente, la distinci&oacute;n entre una
		  platforma Tier 1 (que est&aacute; completamente soportada) y
		  una platforma Tier 2 no es tan estricta como lo parece.
		  En casi todos los apectos, el port ia64 es una platforma
		  Tier 1.<br/>
		  Del aspecto de un desarrollador, hay ventajas de que el port
		  ia64 sea una platforma Tier 2 durante un poco m&aacute;s
		  largo tiempo.  Todav&iacute;a tenemos cambios que rompen
		  la compatibilidad de ABI en el pipeline y la necesidad de
		  mantener compatibilidad con versiones anteriores tan temprano
		  en la vida del port no es ideal.</p>
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
