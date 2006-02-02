<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/es/includes.xsl,v 1.10 2005/11/03 21:17:45 jcamou Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../share/sgml/includes.xsl" />

  <xsl:variable name="url.doc.langcode" select="'es_ES.ISO8859-1'" />

  <xsl:variable name="i.daemon">
    <img src="{$enbase}/gifs/daemon.gif" alt="" align="left" width="80" height="76"/>
  </xsl:variable>

  <xsl:variable name="i.new">
    <img src="{$enbase}/gifs/new.gif" alt="[New!]" width="28" height="11"/>
  </xsl:variable>

  <xsl:variable name="copyright">
    <a href="{$enbase}/copyright/index.html">Copyright</a> &#169; 1995-2006 The FreeBSD Project.  Todos los derechos reservados.
  </xsl:variable>

  <xsl:variable name="email" select="'freebsd-questions'"/>
  <xsl:variable name="author">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="concat($base, '/mailto.html')"/>
      </xsl:attribute>
      <xsl:value-of select="$email"/>@FreeBSD.org</a><br/><xsl:value-of select="$copyright"/>
  </xsl:variable>

  <xsl:variable name="home">
    <a href="{$base}/index.html"><img src="{$enbase}/gifs/home.gif" alt="FreeBSD Home Page" border="0" align="right" width="101" height="33"/></a>
  </xsl:variable>

  <xsl:variable name="section" select="''"/>

  <xsl:variable name="header1">
    <head><title><xsl:value-of select="$title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <meta name="MSSmartTagsPreventParsing" content="TRUE" />
    <link rel="shortcut icon" href="{$enbase}/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="{$enbase}/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" media="screen" href="{$enbase}/layout/css/fixed.css" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="{$enbase}/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="{$enbase}/layout/js/styleswitcher.js"></script>
    </head>    
  </xsl:variable>
  
  <xsl:variable name="header2">
            <span class="txtoffscreen"><a href="#content" title="Skip site navigation" accesskey="1">Skip site navigation</a> (1)</span>
            <span class="txtoffscreen"><a href="#contentwrap" title="Skip section navigation" accesskey="2">Skip section navigation</a> (2)</span>
            <div id="headercontainer">
      
              <div id="header">
      	      <h2 class="blockhide">Cabecera y logo</h2>
                <div id="headerlogoleft">
                  <a href="{$base}" title="FreeBSD"><img src="{$enbase}/layout/images/logo.png" width="360" height="40" alt="FreeBSD" /></a>
                </div> <!-- headerlogoleft -->
                <div id="headerlogoright">
      			<h2 class="blockhide">Enlaces perifericos</h2>
      			  <div id="searchnav">
      				<ul id="searchnavlist">
      				  <li>
      					Tama&#241;o de Texto: <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Normal Text'); return false;" title="Normal Text Size">Normal</a> / <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Large Text'); return false;" title="Large Text Size">Large</a>
      				  </li>
      				  <li>
      					<a href="{$enbase}/donations/" title="Donaciones">Donaciones</a>
      				  </li>
      				  <li class="last-child">
      					<a href="{$base}/mailto.html" title="Contactar">Contactar</a>
      				  </li>
      				</ul>
      			  </div> <!-- searchnav -->
      			<div id="search">
      			  <form action="{$enbase}/cgi/search.cgi" method="get">
      				<div>
      			      <h2 class="blockhide"><label for="words">Buscar</label></h2>
      				  <input type="hidden" name="max" value="25" /> <input type="hidden" name="source" value="www" /><input id="words" name="words" type="text" size="20" maxlength="255" onfocus="if( this.value==this.defaultValue ) this.value='';" value="Buscar" />&#160;<input id="submit" name="submit" type="submit" value="Buscar" />
      				</div>
      			  </form>
      			</div> <!-- search -->
                </div> <!-- headerlogoright -->
      
              </div> <!-- header -->
      
        	<h2 class="blockhide">Navegaci&#243;n</h2>
              <div id="topnav">
                <ul id="topnavlist">
		  <li>
			<a href="{$base}/" title="Inicio">Inicio</a>
		  </li>
		  <li>
			<a href="{$base}/about.html" title="Acerca de">Acerca de</a>
		  </li>
		  <li>
			<a href="{$base}/where.html" title="Obtener FreeBSD">Obtener FreeBSD</a>
		  </li>
		  <li>
			<a href="{$base}/docs.html" title="Documentaci&#243;n">Documentaci&#243;n</a>
		  </li>
		  <li>
			<a href="{$enbase}/community.html" title="Community">Comunidad</a>
		  </li>
		  <li>
			<a href="{$base}/projects/index.html" title="Desarrollo">Desarrollo</a>
		  </li>
		  <li>
			<a href="{$base}/support.html" title="Soporte">Soporte</a>
		  </li>
		</ul>
              </div> <!-- topnav -->
            </div> <!-- headercontainer -->
  </xsl:variable>
  
  <xsl:variable name="header3">
  	<h1><xsl:value-of select="$title"/></h1>
  </xsl:variable>
  
  <xsl:variable name="sidenav">
	<div id="sidewrap">
	
	<div id="sidenav">
	<h2 class="blockhide">Section Navigation</h2>
	
	<xsl:if test="$section = 'about'" >
		<ul>
		<li><a href="{$base}/about.html">Acerca de</a></li>
		<li><a href="{$base}/features.html">Caracter&#237;sticas</a></li>
		<li><a href="{$base}/applications.html">Aplicaciones</a></li>
		<li><a href="{$base}/internet.html">Redes</a></li>
		<li><a href="{$enbase}/advocacy/">Promoci&#243;n</a></li>
		<li><a href="{$enbase}/marketing/">Marketing</a></li>
		<li><a href="{$base}/news/newsflash.html">Noticias</a></li>
		<li><a href="{$enbase}/events/events.html">Eventos</a></li>
		<li><a href="{$base}/news/press.html">Prensa</a></li>
		<li><a href="{$enbase}/art.html">Artwork</a></li>
		<li><a href="{$enbase}/donations/">Donaciones</a></li>
		<li><a href="{$base}/copyright/">Notas Legales</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'community'" >
		<ul>
		<li><a href="{$enbase}/community.html">Comunidad</a></li>
		<!--li><a href="{$base}/community/mailinglists.html">Listas de distribuci&#243;n</a></li>
		<li><a href="{$base}/community/irc.html">IRC</a></li>
		<li><a href="{$base}/community/newsgroups.html">Listas de news</a></li>
		<li><a href="{$base}/usergroups.html">Grupos de usuarios</a></li>
		<li><a href="{$base}/community/webresources.html">Recursos Web</a></li-->
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'developers'" >
		<ul>
		<li><a href="{$base}/projects/index.html">Desarrollo</a></li>
		<li><a href="{$enbase}/doc/en_US.ISO8859-1/books/developers-handbook">Manual del desarrollador</a></li>
		<li><a href="{$enbase}/doc/en_US.ISO8859-1/books/porters-handbook">Manual del Porter</a></li>
		<li><a href="{$base}/support.html#cvs">Repositorio CVS</a></li>
		<li><a
		    href="{$enbase}/releng/index.html">Ingenier&#237;a
		de Release</a></li>
		<li><a href="{$enbase}/platforms/">Arquitecturas</a>
			<ul>
				<li><a href="{$enbase}/platforms/alpha.html">alpha</a></li>
				<li><a href="{$enbase}/platforms/amd64.html">amd64</a></li>
				<li><a href="{$enbase}/platforms/i386.html">i386</a></li>
				<li><a href="{$enbase}/platforms/ia64.html">ia64</a></li>
				<li><a href="{$enbase}/platforms/pc98.html">pc98</a></li>
				<li><a href="{$enbase}/platforms/sparc.html">sparc64</a></li>
			</ul>
		</li>
		<li><a href="{$enbase}/doc/en_US.ISO8859-1/articles/contributing/index.html">Contribuir a FreeBSD</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'docs'" >
		<ul>
		<li><a href="{$base}/docs.html">Documentaci&#243;n</a></li>
		<li><a href="{$enbase}/doc/es_ES.ISO8859-1/books/faq/">FAQ</a></li>
		<li><a href="{$enbase}/doc/es_ES.ISO8859-1/books/handbook/">Handbook</a></li>
		<li><a href="{$base}/docs.html#man">Manuales</a>
			<ul>
				<li><a href="{$enbase}/cgi/man.cgi">P&#225;ginas Man Online</a></li>
			</ul>
		</li>
		<li><a href="{$base}/docs.html#books">Libros y art&#237;iculos Online</a></li>
		<li><a href="{$base}/publish.html">Publicaciones</a></li>
		<li><a href="{$base}/docs.html#links">Recursos Web</a></li>
		<li><a href="{$base}/projects/newbies.html">Para principiantes</a></li>
		<li><a href="{$base}/docproj/">Proyecto de Documentaci&#243;n</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'download'" >
		<ul>
		<li><a href="{$base}/where.html">Obtener FreeBSD</a></li>
		<li><a href="{$base}/releases/">Informaci&#243;n de Releases</a>
			<ul>
				<li><a href="{$u.rel.announce}">Nueva Tecnolog&#237;a: {$rel.current}</a></li>
				<li><a href="{$u.rel2.announce}">Release en Producci&#243;n: {$rel2.current}</a></li>
				<li><a href="{$enbase}/snapshots/">Snapshot Releases</a></li>
			</ul>
		</li>
		<li><a href="{$base}/ports/">Aplicaciones portadas</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'support'" >
		<ul>
		<li><a href="{$base}/support.html">Soporte</a></li>
		<li><a href="{$enbase}/commercial/">Vendors</a>
			<ul>
				<li><a href="{$enbase}/commercial/software_bycat.html">Software</a></li>
				<li><a href="{$enbase}/commercial/hardware.html">Hardware</a></li>
				<li><a href="{$enbase}/commercial/consult_bycat.html">Consultor&#237;a</a></li>
				<li><a href="{$enbase}/commercial/isp.html">Internet Service Providers</a></li>
				<li><a href="{$enbase}/commercial/misc.html">Varios</a></li>
			</ul>
		</li>
		<li><a href="{$base}/security/">Seguridad</a></li>
		<li><a href="{$base}/support.html#gnats">Informe de Bugs</a>
			<ul>
				<li><a href="{$base}/send-pr.html">Enviar un reporte</a></li>
			</ul>
		</li>
		<li><a href="{$base}/support.html#general">Recursos Web</a></li>
		</ul>
	</xsl:if>
	
	</div> <!-- sidenav -->
	
	</div> <!-- sidewrap -->
  </xsl:variable>
  
  <xsl:variable name="footer">
	<div id="footer">
	<xsl:copy-of select="$copyright"/><br />
	<xsl:copy-of select="$date"/>
	</div> <!-- footer -->
  </xsl:variable>

  <xsl:variable name="u.rel.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel.announce">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel.installation">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/installation.html</xsl:variable>
  <xsl:variable name="u.rel.migration">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/migration-guide.html</xsl:variable>
  <xsl:variable name="u.rel.early">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/early-adopter.html</xsl:variable>

  <xsl:variable name="u.rel2.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel2.announce">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel2.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel2.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/hardware.html</xsl:variable>

</xsl:stylesheet>
