<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD$ -->
<!--
   The FreeBSD French Documentation Project
   Original revision: 1.4
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">


<xsl:variable name="gnome_sidenav">
	<div id="SIDEWRAP">

	<div id="SIDENAV">
		<h2 class="blockhide">Section Navigation</h2>
		<ul>
			<li><a href="{$base}/gnome/index.html">FreeBSD/GNOME</a>
				<ul>
					<li><a href="{$base}/gnome/docs/faq2.html#q1">Instructions d'installation</a></li>
					<li><a href="{$enbase}/gnome/docs/faq212.html#q2">Instructions de mise &#224; jour</a></li>
					<li><a href="{$enbase}/gnome/../ports/gnome.html">Applications disponibles</a></li>
					<li><a href="{$base}/gnome/docs/volunteer.html">Comment participer</a></li>
					<li><a href="{$base}/gnome/docs/bugging.html">Rapporter un bogue</a></li>
					<li><a href="{$base}/gnome/screenshots.html">Captures d'écran</a></li>
					<li><a href="{$base}/gnome/contact.html">Nous contacter</a></li>
				</ul>
			</li>
			<li><a href="{$base}/gnome/index.html">Documentation</a>
				<ul>
					<li><a href="{$base}/gnome/docs/faq2.html">FAQ</a></li>
					<li><a href="{$enbase}/gnome/docs/faq212.html">FAQ mise &#224; jour 2.10 &#224; 2.12</a></li>
					<li><a href="{$enbase}/gnome/docs/develfaq.html">FAQ branche de développement</a></li>
					<li><a href="{$base}/gnome/docs/porting.html">Création des ports</a></li>
					<li><a href="{$enbase}/gnome/docs/faq212.html#q5">Problèmes connus</a></li>
				</ul>
			</li>
		</ul>
	</div> <!-- sidenav -->

	</div> <!-- sidewrap -->
</xsl:variable>

</xsl:stylesheet>
