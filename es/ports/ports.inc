<!-- $Id: ports.inc,v 1.7 1999-07-01 21:14:25 jesusr Exp $ -->
<p>La colecci&oacute;n de Ports y Packages de FreeBSD ofrece una manera
sencilla de instalci&oacute;n de aplicaciones para los usuarios y
administradores. La colecci&oacute;n de ports ha estado creciendo en los
&uacute;ltimos tiempos a un <a
href="http://www.freebsd.org/%7Easami/papers/growth.gif"> ritmo
increible</a>.

<p>Cada "port" listado aqu&iacute; contiene los parches
necesarios para hacer que la aplicaci&oacute;n original compile y
se ejecute en FreeBSD. Instalar una aplicaci&oacute;n es t&aacute;n
sencillo como obtener el ports, descomprimirlo y teclear <tt>make</tt>
dentro del directorio del port. Para mayor facilidad, puedes, simplemente, instalar la <a href="ftp://ftp.freebsd.org/pub/FreeBSD/branches/-current/ports.tar.gz">colecci&oacute;n completa de ports</a> en el momento de la instalaci&oacute;n
del sistema (o usar <a href="../handbook/synching.html#CVSUP">CVSup</a> 
para mantener la colecci&oacute;n actualizada) y tener miles de aplicaciones 
disponibles en la punta de tus dedos.

El <tt>Makefile</tt> automaticamente se encarga de obtener el c&oacute;digo 
fuente de la aplicaci&oacute;n ya sea del disco local, CDROM o v&iacute;a FTP, 
descomprimirla, aplicar los parches necesarios y compilarla. Si todo fue 
bi&eacute;n, un simple <tt>make install</tt> instalar&aacute; y 
registrar&aacute; la aplicaci&oacute;n en el sistema.</p>

<p>Para muchos ports, existe un <tt>package</tt> precompilado, ahorrando
al usuario el trabajo de tener que compilar cada una de ellas. Cada port
contiene un link a su correspondiente package, con lo que solo tienes que
bajarte el fichero y ejecutar el comando <strong>pkg_add</strong>. Este
comando acepta tanto nombres de ficheros como URL's FTP.</p>

<p>Para m&aacute;s informaci&oacute;n sobre el uso de los ports mira en <a
href="../../handbook/ports.html">La colecci&oacute;n de Ports</a>. Para
informaci&oacute;n sobre crear nuevos ports, mira en <a
href="../../handbook/porting.html">Porting applications</a>. Ambos son parte
del <a href="../../handbook/">Handbook</a>.</p>

<p>Los ports listados en estas p&aacute;ginas web son continuamente 
actualizados. Consecuentemente, necesitar&aacute;s actualizar algunos ficheros
en tu sistema FreeBSD para usar los ports desarrollados posteriormente a tu
sistema. Por favor, instala uno de los packages siguientes dependiendo de la
versi&oacute;n que est&eacute;s usando. Incluso, si est&aacute;s usando 
FreeBSD-stable o FreeBSD-current con algunos d&iacute;s de antiguedad, 
tambi&eacute;n te recomendamos instalar el kit de actualizaci&oacute;n
apropiado; el sistema de ports a veces cambia muy r&aacute;pidamente.

<dl>
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/221upgrade.tgz">Kit actualizaci&oacute;n de 2.2.1 a 2.2-stable</a>
<dd>Para usuarios de 2.2.1-release o 2.2-stable entre 2.2.1-release y 
2.2.2-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/222upgrade.tgz">Kit actualizaci&oacute;n de 2.2.2 a 2.2-stable</a>
<dd>Para usuarios de 2.2.2-release o 2.2-stable entre 2.2.2-release y
2.2.5-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/225upgrade.tgz">Kit actualizaci&oacute;n de 2.2.5 a 2.2-stable</a>
<dd>Para usuarios de 2.2.5-release o 2.2-stable entre 2.2.5-release y
2.2.6-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/227upgrade.tgz">Kit actualizaci&oacute;n de 2.2.7 a 2.2-stable</a>
<dd>Para usuarios de 2.2.6-release, 2.2.7-release, 2.2.8-release o
2.2-stable despu&eacute;s de 2.2.6-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-3-stable/Latest/30upgrade.tgz">Kit actualizaci&oacute;n de 3.0 a 3.1-stable</a>
<dd>Para usuarios de 3.0-release o 3.0-stable despu&eacute;s de 3.0-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-3-stable/Latest/31upgrade.tgz">Kit actualizaci&oacute;n de 3.1 a 3.1-stable</a>
<dd>Para usuarios de 3.1-release o 3.1-stable despu&eacute;s de 3.1-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-3-stable/Latest/32upgrade.tgz">Kit actualizaci&oacute;n de 3.2 a 3.2-stable</a>
<dd>Para usuarios de 3.2-release o 3.2-stable despu&eacute;s de 3.2-release
</dl>

<p>Estos son packages de FreeBSD; por favor usa pkg_add para instalarlos. Esto
deber&iacute;a hacer que puedas usar todos los ports listados aqu&iacute;, ten
en cuenta que solo se modificar&aacute;n algunos ficheros para permitir
que los ports/packages puedan ser usados; para una actualizaci&oacute;n
completa a 3.2-stable, por favor, mira en la secci&oacute;n <a
href="../../handbook/synching.html">sincronizando el c&oacute;digo fuente</a>
del handbook. Recomendamos una actualizaci&oacute;n completa, especialmente
si todav&iacute;a est&aacute;s usando cualquier versi&oacute;n anterior a 
2.2.7-release. Comentar tambi&eacute;n que toda la rama 2.2.X ya no es
oficialmente soportada por ports-current; est&aacute;s en "tu opci&oacute;n"
si quieres usar los ports aqu&iacute; listados.</p>

<p>Muchos de los ports requieren el sistema X Window para compilar y 
ejecutarse. Nosotros compilamos y testeamos nuestros ports con <a
href="http://www.xfree86.org/">XFree86</a>. Su versi&oacute;n actual es
3.3.3.1 Algunos ports no trabajar&aacute;n con releases m&aacute;s
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

