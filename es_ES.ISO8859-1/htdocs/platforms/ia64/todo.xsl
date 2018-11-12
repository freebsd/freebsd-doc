<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY email "freebsd-ia64">
<!ENTITY title "Proyecto FreeBSD/ia64">
<!ENTITY % navinclude.developers "INCLUDE">
]>

<!-- The FreeBSD Spanish Documentation Project
     Original Revision: r1.9			-->

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

		<img align="right" alt="Montecito die" src="montecito-die.png"/>

		<p>B&uacute;squedas en la base de datos de PR de FreeBSD/ia64:</p>

	<form action="http://www.FreeBSD.org/cgi/query-pr-summary.cgi"
	      method="get">
	    <input type="hidden" name="category" value="ia64"/>
	    <input type="hidden" name="sort" value="none"/>
	    <input type="text" name="text"/>
	    <input type="submit" value="Go"/>
		</form>

	<h3>
	  Tareas pendientes
	</h3>
	<p>
	  Esta p&aacute;gina intenta ser un punto de partida para quienes
          est&aacute;n buscando alguna tarea pendiente en la que puedan
          ayudar.  El orden de la lista que se muestra no implica
          necesariamente un orden de prioridad, aunque puede ayudar.  Hay
	  una gran cantidad de tareas que no se mencionan aqu&iacute; pero
	  que habr&aacute; que cumplir de todas maneras.  Un ejemplo de
	  esto es el mantenimiento de las p&aacute;ginas web del port
	  ia64... para nuestro bochorno.
	</p>

	<h4>
	  Convertir ia64 en una plataforma ia64
	</h4>
	<p>
	  Con dos releases como plataforma Tier 2 a nuestras espaldas va
	  llegando la hora de dirigir nuestros esfuerzos a convertirla en
	  plataforma Tier 1.  Esto implica tareas tan diversas como estas:
	</p>
	<ul>
	  <li>
	    Mejorar el proceso de instalaci&oacute;n para que tenga en
	    cuenta que haya un GPT con una partici&oacute;n EFI, por ejemplo
	    cuando hay otros sistemas operativos.  El poder a&ntilde;adir
	    una entrada para FreeBSD al men&uacute; de arranque EFI
	    tambi&eacute;n estar&iacute;a muy bien.
	  </li>
	  <li>
	    Portar el debugger GNU.  Se echa mucho a faltar en una
	    m&aacute;quina de desarrollo y es un requisito imprescindible
	    en plataformas Tier 1.
	  </li>
	  <li>
	    Portar el servidor X (ports/x11/XFree86-4-Server).  Lo cierto
	    es que no es imprescindible para alcanzar el est&aacute;tus
	    de Tier 1, pero no ser&iacute;a muy razonable esperar llegar
	    a &eacute;l si es imposible usar ia64 como sistema de
	    escritorio.
	  </li>
	</ul>

	<h4>
	  Ports y "packages"
	</h4>
	<p>
	  Un factor muy importante para garantizar el &eacute;xito de &os;
	  en ia64 es el poder garantizar que los usuarios podr&aacute;n
	  ejecutar algo m&aacute;s que ls(1) en sus sistemas.  Nuestra
	  gigantesca colecci&oacute;n de ports ha estado enfocada
	  principalmente en ia32, por lo que no es sorprendente que haya
	  muchos ports que no compilan o no funcionan en ia64.  En
	  <a href="http://pointyhat.FreeBSD.org/errorlogs/ia64-6-latest/">esta web</a>
	  ver&aacute; la lista m&aacute;s actualizada de ports que no
	  llegan a compilar por una raz&oacute;n o por otra.  Tenga en
	  cuenta que si un port depende de uno o m&aacute;s ports que
	  fallan esos ports no compilan y no se cuentan.  Trabajar en
	  esos ports que tienen muchos otros ports dependiendo de ellos es
	  una excelente elecci&oacute;n si quiere ayudar de verdad (Consulte
	  la columna "Aff.").
	</p>

	<h4>
	  Limpiar y dar esplendor
	</h4>
	<p>
	  Hay una gran cantidad de funciones (especialmente rutinas en
	  ensamblador) que se han ido escribiendo para agregar funcionalidades
	  que no estaban antes sin tener en cuenta la velocidad, la
	  robustez o ambas.  La revisi&oacute;n de dichas funciones
	  y su sustituci&oacute;n si fuera necesario es una tarea muy
	  necesaria que puede hacerse de forma concurrente e independiente
	  de otras actividades y que adem&aacute;s no implica necesariamente
	  que haya que tener much&iacute;sima experiencia o conocimientos.
	</p>

	<h4>
	  Desarrollo del "core"
	</h4>
	<p>
	  Adem&aacute;s de las cosas a alto nivel que no funcionan o no
	  existen hay tambi&eacute;n pendientes trabajos de reescritura
	  en el n&uacute;cleo mismo del sistema y que podr&iacute;an incluso
	  afectar a otras plataformas.  Veamos algunos ejemplos:
	</p>
	<ul>
	  <li>
	    Mejorar la estabilidad en monoprocesador y multiprocesador
	    reescribiendo el m&oacute;dulo PMAP.  La gesti&oacute;n a
	    bajo nivel de las direcciones de memoria virtual necesita
	    mejorarse.  Esto implica optimizaci&oacute;n y rendimiento.
	  </li>
	  <li>
	    Hay controladores de dispositivos b&aacute;sicos como sio(4) y
	    syscons(4) que no funcionan en m&aacute;quinas ia64 que no
	    tengan soporte para dispositivos antiguos.  Este es un problema
	    bastante grande porque afecta a todas las plataformas y
	    es posible que requiera reescribir (una gran) parte de ciertos
	    subsistemas.  Evidentemente una tarea as&iacute; requiere
	    un consenso un&aacute;nime y mucha coordinaci&oacute;n.
	  </li>
	  <li>
	    Una mejor gesti&oacute;n de las configuraciones de memoria
	    (f&iacute;sica) evitando crear tablas de memoria virtual que
	    ocupe todo el espacio de direcciones y aprovechando la
	    memoria presente.  A causa de este problema ahora mismo
	    estamos obligados a ignorar memoria.
	  </li>
	</ul>

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
