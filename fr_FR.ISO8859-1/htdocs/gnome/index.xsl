<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Projet GNOME pour FreeBSD">
]>
<!-- $FreeBSD$ -->

<!--
   The FreeBSD French Documentation Project
   Original revision: 1.87

   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdf1="http://my.netscape.com/rdf/simple/0.9/"
		exclude-result-prefixes="rdf rdf1" version="1.0">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:variable name="svnKeyword" select="'$FreeBSD$'"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.content">
              <div id="sidewrap">
                &nav.gnome;
              </div> <!-- SIDEWRAP -->

	      <div id="contentwrap">
		<div id="rightwrap">
		  <div class="rightnav">

		    <h2>Nouvelles de GNOME pour FreeBSD</h2>

		    <p>Dernière mise à jour :
		      <xsl:value-of
			select="descendant::month[position() = 1]/name"/>
		      <xsl:text> </xsl:text>
		      <xsl:value-of
			select="descendant::day[position() = 1]/name"/>,
		      <xsl:text> </xsl:text>
		      <xsl:value-of
			select="descendant::year[position() = 1]/name"/></p>
		    <ul>

		      <!-- Pull in the 10 most recent news items -->
		      <xsl:for-each select="descendant::event[position() &lt;= 10]">
			<li><a>
			    <xsl:attribute name="href">
			      newsflash.html#<xsl:call-template name="generate-event-anchor"/>
			    </xsl:attribute>
			    <xsl:choose>
			      <xsl:when test="count(child::title)">
				<xsl:value-of select="title"/><br/>
			      </xsl:when>
			      <xsl:otherwise>
				<xsl:value-of select="p"/><br/>
			      </xsl:otherwise>
			    </xsl:choose>
			  </a></li>
		      </xsl:for-each>
		      <li><a href="newsflash.html">Plus...</a></li>
		    </ul>
		  </div> <!-- rightnav -->

		  <br />

		  <div class="rightnav">

		    <h2>Nouvelles du Projet GNOME</h2>
<!-- XXX: (1) does not work at the moment
          (2) should we really copy over GNOME news?

		    <ul>
		      <xsl:for-each select="document('http://gnomedesktop.org/backend.php')/rss/channel/*[name() = 'item'][position() &lt; 10]">
			<li><a>
			    <xsl:attribute name="href">
			      <xsl:value-of select="link"/>
			    </xsl:attribute>
			    <xsl:value-of select="title"/><br/>
			  </a></li>
		      </xsl:for-each>
		      <li><a>
			  <xsl:for-each select="document('http://gnomedesktop.org/backend.php')/rss/*[name() = 'channel'][position() = 1]">
			    <xsl:attribute name="href">
			      <xsl:value-of select="link"/>
			    </xsl:attribute>Plus...
			  </xsl:for-each>
			</a></li>
		    </ul>
-->
                  </div> <!-- rightnav -->
                </div> <!-- rightwrap -->

		<h1>&title;</h1>

		<h2>Qu'est-ce que GNOME ?</h2>

		<img src="&enbase;/gnome/images/gnome.png" align="right"
                   border="0" alt="GNOME Logo"/>

	       		<p>GNOME est un environnement de travail complet, et une
			   suite d'applications intégrées. Avec GNOME,
			   tout devient facile à utiliser, attrayant, puissant,
			   et marche de la façon dont vous vous attendez.</p>

		       <p>Les composants principaux de GNOME sont le
			  <a href="http://www.gnome.org">bureau GNOME</a>, un
			  environnement de travail graphique simple, et la
			  <a href="http://developer.gnome.org">plateforme de développement
			  GNOME</a>, une collection d'outils de développement
		          d'applications et de bibliothèques.</p>

		       <p>Le Projet FreeBSD GNOME est une équipe de committers
			  et d'utilisateurs dévoués qui gèrent l'intégration
			  de GNOME et de FreeBSD.</p>

		<h2>Mise à jour vers GNOME 2.14 ?</h2>

		<p>Si vous mettez à jour de GNOME 2.12 à GNOME 2.14, lisez
		  <a href="&enbase;/gnome/docs/faq214.html">la FAQ de mise à jour</a> pour des instructions
		  de mise à jour.</p>

              <h2>Statut du port</h2>

	      <p>GNOME pour FreeBSD est actuellement supporté sur
		5-STABLE, 6-STABLE, 7-CURRENT, 5.4, 6.0, et 6.1.
		La plupart de GNOME a été porté sous FreeBSD, mais il reste toujours
		<a href="docs/volunteer.html">des choses à faire</a>!</p>

              <h2>Des solutions simples pour les problèmes de compilation - rapidement !</h2>

	      <p>GNOME est simple et facile à compiler en utilisant les ports FreeBSD, mais
	        parfois les choses tournent mal. Si GNOME -- ou quelque chose qui utilise
		les bibliothèques GNOME -- ne se compile pas comme il devrait, exécutez simplement l'outil
		<a href="&enbase;/gnome/gnomelogalyzer.sh">gnomelogalyzer.sh</a>
		depuis le répertoire du port récalcitrant, et laissez le gnomelogalyzer
		trouver ce qui va mal et le corriger !</p>

		<h2>Ressources</h2>
		<ul>
		  <li><a href="http://www.gnome.org/">Projet GNOME</a></li>
		  <li><a href="http://gnomedesktop.org">FootNotes</a></li>
		  <li><a href="http://www.gnomejournal.org">Journal GNOME</a></li>
		  <li><a
		      href="http://www.gnomefiles.org">GNOME
		      Files</a></li>
		  <li><a href="http://gnu-darwin.sourceforge.net/GNOME/">GNOME sous GNU/Darwin</a></li>
		</ul>

		<h2>Autres projets</h2>
		<ul>
		  <li><a href="http://www.kde.org/">Projet KDE</a></li>
		  <li><a href="http://freebsd.kde.org/">KDE sous FreeBSD</a></li>
		  <li><a href="http://www.opengroup.org/desktop/">CDE (commercial)</a></li>
		</ul>

		<a id="search" name="search"></a>
		<form action="http://freebsd.rambler.ru/srch" method="get">
		  <p>Recherche dans les archives de la liste de diffusion freebsd-gnome :</p>
		  <input type="text" name="words" size="25"/>
		  <input type="hidden" name="rubric" value="122" />
		  <input type="submit" value="Search"/>
		</form>

	  	</div> <!-- contentwrap -->
  </xsl:template>
</xsl:stylesheet>
