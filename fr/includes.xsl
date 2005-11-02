<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/fr/includes.xsl,v 1.17 2005/10/15 08:42:14 blackend Exp $ -->

<!-- 
   The FreeBSD French Documentation Project
   Original revision: 1.20
   
   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../share/sgml/includes.xsl" />

  <xsl:variable name="url.doc.langcode" select="'fr_FR.ISO8859-1'" />

  <xsl:variable name="i.daemon">
    <img src="{$enbase}/gifs/daemon.gif" alt="Demon" align="left" width="80" height="76"/>
  </xsl:variable>

  <xsl:variable name="i.new">
    <img src="{$enbase}/gifs/new.gif" alt="[Nouveau !]" width="28" height="11"/>
  </xsl:variable>

  <xsl:variable name="copyright">
    <a href="{$base}/copyright/index.html">Copyright</a> &#169; 1995-2005 Le Projet FreeBSD. Tous droits r&#233;serv&#233;s.
  </xsl:variable>

  <xsl:variable name="home">
    <a href="{$base}/index.html"><img src="{$enbase}/gifs/home.gif" alt="Page accueil FreeBSD" border="0" align="right" width="101" height="33"/></a>
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
      	      <h2 class="blockhide">Header And Logo</h2>
                <div id="headerlogoleft">
                  <a href="{$base}" title="FreeBSD"><img src="{$enbase}/layout/images/logo.png" width="360" height="40" alt="FreeBSD" /></a>
                </div> <!-- headerlogoleft -->
                <div id="headerlogoright">
      			<h2 class="blockhide">Peripheral Links</h2>
      			  <div id="searchnav">
      				<ul id="searchnavlist">
      				  <li>
      					Text Size: <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Normal Text'); return false;" title="Normal Text Size">Normal</a> / <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Large Text'); return false;" title="Large Text Size">Large</a>
      				  </li>
      				  <li>
      					<a href="{$base}/donations/" title="Donate">Donations</a>
      				  </li>
      				  <li class="last-child">
      					<a href="{$base}/mailto.html" title="Contact">Contact</a>
      				  </li>
      				</ul>
      			  </div> <!-- searchnav -->
      			<div id="search">
      			  <form action="{$enbase}/cgi/search.cgi" method="get">
      				<div>
      			      <h2 class="blockhide"><label for="words">Rechercher</label></h2>
      				  <input type="hidden" name="max" value="25" /> <input type="hidden" name="source" value="www" /><input id="words" name="words" type="text" size="20" maxlength="255" onfocus="if( this.value==this.defaultValue ) this.value='';" value="Rechercher" />&#160;<input id="submit" name="submit" type="submit" value="Rechercher" />
      				</div>
      			  </form>
      			</div> <!-- search -->
                </div> <!-- headerlogoright -->
      
              </div> <!-- header -->
      
        	<h2 class="blockhide">Site Navigation</h2>
              <div id="topnav">
                <ul id="topnavlist">
		  <li>
			<a href="{$base}/" title="Home">Accueil</a>
		  </li>
		  <li>
			<a href="{$base}/about.html" title="About">A propos</a>
		  </li>
		  <li>
			<a href="{$base}/where.html" title="Obtenir FreeBSD">Obtenir FreeBSD</a>
		  </li>
		  <li>
			<a href="{$base}/docs.html" title="Documentation">Documentation</a>
		  </li>
		  <li>
			<a href="{$base}/community.html" title="Community">Communaut&#233;</a>
		  </li>
		  <li>
			<a href="{$base}/projects/index.html" title="D&#233;veloppement">D&#233;veloppement</a>
		  </li>
		  <li>
			<a href="{$base}/support.html" title="Support">Support</a>
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
		<li><a href="{$base}/about.html">A propos</a></li>
		<li><a href="{$base}/features.html">Fonctionnalit&#233;s</a></li>
		<li><a href="{$base}/applications.html">Applications</a></li>
		<li><a href="{$base}/internet.html">Internet</a></li>
		<li><a href="{$base}/advocacy/">Pros&#233;lytisme</a></li>
		<li><a href="{$enbase}/marketing/">Marketing</a></li>
		<li><a href="{$base}/news/newsflash.html">Nouvelles du projet</a></li>
		<li><a href="{$base}/events/events.html">Ev&#233;nements</a></li>
		<li><a href="{$base}/news/press.html">Dans la presse</a></li>
		<li><a href="{$base}/art.html">Ressources artistiques</a></li>
		<li><a href="{$base}/donations/">Donations</a></li>
		<li><a href="{$base}/copyright/">Informations l&#233;gales</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'community'" >
		<ul>
		<li><a href="{$base}/community.html">Communauté</a></li>
		<li><a href="{$base}/community/mailinglists.html">Listes de diffusion</a></li>
		<li><a href="{$base}/community/irc.html">IRC</a></li>
		<li><a href="{$base}/community/newsgroups.html">Forums de discussion</a></li>
		<li><a href="{$enbase}/usergroups.html">Groupes d&#39;utilisateurs</a></li>
		<li><a href="{$base}/community/webresources.html">Ressources Web</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'developers'" >
		<ul>
		<li><a href="{$base}/projects/index.html">D&#233;veloppement</a></li>
		<li><a href="{$enbase}/doc/{$url.doc.langcode}/books/developers-handbook">Manuel du d&#233;veloppeur</a></li>
		<li><a href="{$enbase}/doc/en_US.ISO8859-1/books/porters-handbook">Manuel du porteur d&#39;application</a></li>
		<li><a href="{$base}/developers/cvs.html">D&#233;p&#244;t CVS</a></li>
		<li><a href="{$base}/releng/index.html">Production des versions</a></li>
		<li><a href="{$base}/platforms/">Plates-formes</a>
			<ul>
				<li><a href="{$base}/platforms/alpha.html">alpha</a></li>
				<li><a href="{$base}/platforms/amd64.html">amd64</a></li>
				<li><a href="{$base}/platforms/i386.html">i386</a></li>
				<li><a href="{$base}/platforms/ia64/index.html">ia64</a></li>
				<li><a href="{$base}/platforms/pc98.html">pc98</a></li>
				<li><a href="{$base}/platforms/ppc.html">pc98</a></li>
				<li><a href="{$base}/platforms/sparc.html">sparc64</a></li>
			</ul>
		</li>
		<li><a href="{$enbase}/doc/{$url.doc.langcode}/articles/contributing/index.html">Contribuer</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'docs'" >
		<ul>
		<li><a href="{$base}/docs.html">Documentation</a></li>
		<li><a href="{$enbase}/doc/{$url.doc.langcode}/books/faq/">FAQ</a></li>
		<li><a href="{$enbase}/doc/{$url.doc.langcode}/books/handbook/">Manuel de R&#233;f&#233;rence</a></li>
		<li><a href="{$base}/docs.html#man">Pages de manuel</a>
			<ul>
				<li><a href="{$enbase}/cgi/man.cgi">Pages de manuel en ligne</a></li>
			</ul>
		</li>
		<li><a href="{$base}/docs.html#books">Livres et articles en ligne</a></li>
		<li><a href="{$base}/publish.html">Publications</a></li>
		<li><a href="{$base}/docs.html#links">Ressources Web</a></li>
		<li><a href="{$base}/projects/newbies.html">Pour les d&#233;butants</a></li>
		<li><a href="{$base}/docproj/">Projet de Documentation</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'download'" >
		<ul>
		<li><a href="{$base}/where.html">Obtenir FreeBSD</a></li>
		<li><a href="{$base}/releases/">Information sur les versions</a>
			<ul>
				<li><a href="{$u.rel.announce}">Version de production: <xsl:value-of select="$rel.current"/></a></li>
				<li><a href="{$u.rel2.announce}">Version (ancienne) de production: <xsl:value-of select="$rel2.current"/></a></li>
				<li><a href="{$enbase}/snapshots/">Instantannés</a></li>
			</ul>
		</li>
		<li><a href="{$enbase}/ports/">Applications disponibles</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'support'" >
		<ul>
		<li><a href="{$base}/support.html">Support</a></li>
		<li><a href="{$base}/commercial/">Revendeurs</a>
			<ul>
				<li><a href="{$enbase}/commercial/software_bycat.html">Logiciels</a></li>
				<li><a href="{$enbase}/commercial/hardware.html">Mat&#233;riels</a></li>
				<li><a href="{$enbase}/commercial/consult_bycat.html">Consultants</a></li>
				<li><a href="{$enbase}/commercial/isp.html">Fournisseurs d&#39;Acc&#232;s &#224; Internet</a></li>
				<li><a href="{$enbase}/commercial/misc.html">Divers</a></li>
			</ul>
		</li>
		<li><a href="{$base}/security/">S&#233;curit&#233;</a></li>
		<li><a href="{$base}/support.html#gnats">Rapports de Bugs</a>
			<ul>
				<li><a href="{$base}/send-pr.html">Envoyer un rapport de bug</a></li>
			</ul>
		</li>
		<li><a href="{$base}/support.html#general">Ressources Web</a></li>
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
  
  <!-- Les "notes de version" ne sont pas forcement traduites => utilisation des versions anglaises -->
  <!-- voir le fichier share/sgml/includes.release.xsl -->
  <!-- on remplace $base par $enbase -->
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
  <xsl:variable name="u.rel.readme">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/readme.html</xsl:variable>
  <xsl:variable name="u.rel.early">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/early-adopter.html</xsl:variable>
  <xsl:variable name="u.rel.migration">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/migration-guide.html</xsl:variable>

  <xsl:variable name="u.rel2.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/relnotes.html</xsl:variable>
  <xsl:variable name="u.rel2.announce">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel2.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel2.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel2.installation">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/installation.html</xsl:variable>
  <xsl:variable name="u.rel2.readme">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/readme.html</xsl:variable>

</xsl:stylesheet>
