<!-- $Id: ports.inc,v 1.1.1.1 1999-02-08 19:26:11 wosch Exp $ -->
<p>La colecci&oacute;n de Ports y Packages de FreeBSD ofrece una manera
sencilla de instalci&oacute;n de aplicaciones para los usuarios y
administradores. Cada "port" listado aqu&iacute; contiene los parches
necesarios para hacer que la aplicaci&oacute;n original compile y
se ejecute en FreeBSD. Instalar una aplicaci&oacute;n es t&aacute;n
sencillo como obtener el ports, descomprimirlo y teclear <tt>make</tt>
dentro del directorio del port. El <tt>Makefile</tt> automaticamente
se encarga de obtener el c&oacute;digo fuente de la aplicaci&oacute;n ya sea
del disco local, CDROM o v&iacute;a FTP, descomprimirla, aplicar los
parches necesarios y compilarla. Si todo fue bi&eacute;n, un simple
<tt>make install</tt> instalar&aacute; y registrar&aacute; la aplicaci&oacute;n
en el sistema.</p>

<p>Para muchos ports, existe un <tt>package</tt> precompilado, ahorrando
al usuario el trabajo de tener que compilar cada una de ellas. Cada port
contiene un link a su correspondiente package, con lo que solo tienes que
bajarte el fichero y ejecutar el comando <strong>pkg_add</strong>. Este
comando acepta tanto nombres de ficheros como URL's FTP.</p>

<p>Para m&aacute;s informaci&oacute;n sobre el uso de los ports mira en <a
href="../handbook/ports.html">La colecci&oacute;n de Ports</a>. Para
informaci&oacute;n sobre crear nuevos ports, mira en <a
href="../handbook/porting.html">Porting applications</a>. Ambos son parte
del <a href="../handbook">Handbook</a>.</p>

<p>Los ports listados en estas p&aacute;ginas son continuamente actualizados.
Consecuentemente, quiz&aacute;s necesites actualizar algunos ficheros en tu
sistema FreeBSD para poder usar los ports desarrollados posteriormente a la
fecha en la que tu versi&oacute; fue lanzada.
Si eres usuario de 2.2.1-release por favor instala el <a
href="ftp://ftp.freebsd.org/pub/FreeBSD/packages-stable/Latest/221upgrade.tgz">
kit de actualizaci&oacute;n de ports de 2.2.1 a 2.2-stable</a>; si eres usuario
de 2.2.2-release, por favor instala el <a
href="ftp://ftp.freebsd.org/pub/FreeBSD/packages-stable/Latest/222upgrade.tgz">
kit de actualizaci&oacute;n de ports a 2.2-stable</a>; si eres usuario de 
2.2.5-release, por favor, instala el <a
href="ftp://ftp.freebsd.org/pub/FreeBSD/packages-stable/Latest/225upgrade.tgz">
kit de actualizaci&oacute;n a 2.2-stable</a>; si eres usuario de 2.2.6, 2.2.7 
o 3.0-release, por favor, instala el <a
href="ftp://ftp.freebsd.org/pub/FreeBSD/packages-stable/Latest/227upgrade.tgz">
kit de actualizaci&oacute;n a 2.2-stable</a>.  
Estos son packaes de FreeBSD; por favor usa pkg_add para instalarlos. Esto
deber&iacute;a hacer que puedas usar todos los ports listados aqu&iacute;, ten
en cuenta que solo se modificar&aacute;n algunos ficheros para permitir
que los ports/packages puedan ser usados; para una actualizaci&oacute;n
completa a 2.2-stable, por favor, mira en la secci&oacute;n <a
href="../handbook/synching.html">sincronizando el c&oacute;digo fuente</a>
del handbook. Recomendamos una actualizaci&oacute;n completa, especialmente
si todav&iacute;a est&aacute;s usando 2.2.1-release o 2.2.2-release.</p>

<p>Muchos de los ports requieren el sistema X Window para compilar y 
ejecutarse. Nosotros compilamos y testeamos nuestros ports con <a
href="http://www.xfree86.org/">XFree86</a>. Su versi&oacute;n actual es
3.3.3. Algunos ports no trabajar&aacute;n con releases m&aacute;s
antiguas.</p>

<p>Para m&aacute;s informaci&oacute;n sobre ports/packages nuevos, modificados
o borrados, o si quieres buscar una aplicaci&oacute;n espec&iacute;fica, por
favor, mira en la p&aacute;gina de
<a href="http://www.freebsd.org/cgi/ports.cgi">Mantenimiento de Ports</a></p> 

<FORM METHOD="GET" ACTION="http://www.freebsd.org/cgi/ports.cgi">
Buscar:
<INPUT NAME="query" VALUE="">
<SELECT NAME="stype">
<OPTION VALUE="all">Todo</OPTION>
<OPTION VALUE="name">Nombre Package</OPTION>
<OPTION VALUE="text">Descripci&oacute;n</OPTION>
</SELECT>
<INPUT TYPE="submit" VALUE="Enviar">
</FORM>

