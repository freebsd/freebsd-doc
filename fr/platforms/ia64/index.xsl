<!--
   The FreeBSD Documentation Project
   The FreeBSD French Documentation Project

   Original revision: 1.3
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../../includes.xsl"/>
  <xsl:import href="includes.xsl"/>
  <xsl:variable name="date" select="'$FreeBSD: www/fr/platforms/ia64/index.xsl,v 1.1 2005/10/15 08:37:59 blackend Exp $'"/>
  <xsl:variable name="section" select="'developers'"/>
  <xsl:output doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    encoding="iso-8859-1" method="html"/>
  <xsl:template match="/">
    <html>
      <xsl:copy-of select="$header1"/>

      <body xsl:use-attribute-sets="att.body">

	<div id="CONTAINERWRAP">
	  <div id="CONTAINER">
	    <xsl:copy-of select="$header2"/>

	    <div id="CONTENT">

	      <xsl:copy-of select="$sidenav"/>

	      <div id="CONTENTWRAP">
		<xsl:copy-of select="$header3"/>

		<img align="right" alt="McKinley die" src="{$enbase}/platforms/ia64/mckinley-die.png"/>

		<p>Rechercher dans les archives de la liste de diffusion
		  freebsd-ia64:</p>

		<form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
		  <input name="words" size="50" type="text"/>
		  <input name="max" type="hidden" value="25"/>
		  <input name="source" type="hidden" value="freebsd-ia64"/>
		  <input type="submit" value="Go"/>
		</form>

		<h3><a name="toc">Table des mati&#232;res</a></h3>

		<ul>
		  <li>
		    <a href="#intro">Introduction</a>
		  </li>
		  <li>
		    <a href="#status">Statut actuel</a>
		  </li>
		  <li>
		    <a href="todo.html">Ce qu'il reste &#224; faire</a>
		  </li>
		  <li>
		    <a href="machines.html">Liste mat&#233;riels</a>
		  </li>
		  <li>
		    <a href="refs.html">R&#233;f&#233;rences</a>
		  </li>
		</ul>

		<h3><a name="intro">Introduction</a></h3>

		<p>Les pages du projet FreeBSD/ia64 contiennent des
		  informations au sujet du port FreeBSD sur l'architecture
		  IA-64 de Intel; connue sous le nom de "Famille de
		  Processeurs Intel Itanium&#174;" (IPF).  Tout comme le
		  port lui-m&#234;me, ces pages sont en constante
		  &#233;volution.</p>

		<h3><a name="status">Statut actuel</a></h3>

		<p>Le port ia64 est encore consid&#233;r&#233; comme
		  plateforme de niveau 2.  En r&#233;sum&#233;, cela veut
		  dire qu'elle n'est pas enti&#232;rement support&#233;e
		  par notre officier de s&#233;curit&#233;, par les
		  ing&#233;nieurs de versions ni par les mainteneurs de
		  l'ensemble des outils de compilation.  Dans la pratique,
		  toutefois, la distinction entre une plateforme de niveau
		  1 (enti&#232;rement support&#233;e) et une plateforme de
		  niveau 2 n'est pas aussi stricte qu'il n'y para&#238;t.
		  En bien des aspects, le port ia64 est une plateforme de
		  niveau 1.
		  <br/>
		  Du point de vue d'un d&#233;veloppeur, il y a un
		  avantage dans le fait que le port ia64 soit une
		  plateforme de niveau 2 pendant encore quelque temps.
		  Nous pr&#233;voyons toujours plusieurs changements
		  importants au niveau de l'ABI et devoir maintenir une
		  compatibilit&#233; aussi t&#244;t dans la vie du port
		  ne serait pas tr&#232;s pratique.</p>
	      </div> <!-- CONTENTWRAP -->

	      <br class="clearboth" />
	    </div> <!-- CONTENT -->
	    <xsl:copy-of select="$footer"/>
	  </div> <!-- CONTAINER -->
	</div> <!-- CONTAINERWRAP -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
