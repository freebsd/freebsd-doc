<!--
   The FreeBSD Documentation Project
   The FreeBSD French Documentation Project

   Original revision: 1.7
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../../includes.xsl"/>
  <xsl:import href="includes.xsl"/>
  <xsl:variable name="date" select="'$FreeBSD: www/fr/platforms/ia64/todo.xsl,v 1.2 2005/12/17 10:58:29 blackend Exp $'"/>
  <xsl:variable name="section" select="'developers'"/>
  <xsl:output doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    encoding="iso-8859-1" method="html"/>
  <xsl:template match="/">
    <html>
      <xsl:copy-of select="$header1"/>

      <body>

	<div id="CONTAINERWRAP">
	  <div id="CONTAINER">
	    <xsl:copy-of select="$header2"/>

	    <div id="CONTENT">
	      <xsl:copy-of select="$sidenav"/>

	      <div id="CONTENTWRAP">
		<xsl:copy-of select="$header3"/>
		<img align="right" alt="Montecito die" src="{$enbase}/platforms/ia64/montecito-die.png"/>

		<p>Rechercher dans la base de PRs de FreeBSD/ia64:</p>

	<form action="http://www.FreeBSD.org/cgi/query-pr-summary.cgi"
	      method="get">
	    <input type="hidden" name="category" value="ia64"/>
	    <input type="hidden" name="sort" value="none"/>
	    <input type="text" name="text"/>
	    <input type="submit" value="Go"/>
		</form>

	<h3>
	  Ce qu'il reste &#224; faire
	</h3>
	<p>
	  Cette page essaye d'&#234;tre un point de d&#233;part pour les
	  personnes qui veulent trouver quelque chose &#224; faire.
	  L'ordre des t&#226;ches de cette page n'est pas une indication
	  de priorit&#233; stricte, mais c'est une bonne indication.  Il
	  y a d'autres t&#226;ches qui ne sont pas mentionn&#233;es ici,
	  mais qui doivent n&#233;anmoins &#234;tre r&#233;alis&#233;es.
	  Un exemple typique est la maintenance des pages web ia64...
	  malheureusement.
	</p>

	<h4>
	  Devenir une plateforme de niveau 1
	</h4>
	<p>
	  Avec deux versions en tant que plateforme de niveau 2 &#224;
	  son actif, il est temps de devenir une plateforme de niveau 1.
	  Ceci comprend des t&#226;ches aussi vari&#233;es que:
	</p>
	<ul>
	  <li>
	    Am&#233;liorer le processus d'installation pour prendre en
	    compte un GPT avec une partition EFI existante, comprenant
	    d'autres syst&#232;mes d'exploitation.  La possibili&#233;
	    de rajouter FreeBSD au menu de d&#233;marrage EFI serait une
	    bonne chose.
	  </li>
	  <li>
	    Porter le debugger GNU.  Il manque cruellement sur une
	    machine de d&#233;veloppement et est requis sur les
	    plateformes de niveau 1.
	  </li>
	  <li>
	    Porter le serveur X (ports/x11/XFree86-4-Server).  Pas
	    indispensable pour un statut de niveau 1, mais on ne peut
	    pas faire sans si l'on veut utiliser ia64 comme machine de
	    bureau.
	  </li>
	</ul>

	<h4>
	  Logiciels port&#233;s et paquetages
	</h4>
	<p>
	  Une t&#226;che tr&#232;s importante pour le succ&#232;s de
	  FreeBSD sur ia64 est de s'assurer que les utilisateurs
	  puissent ex&#233;cuter autre chose que ls(1).  Notre
	  collection immense de logiciels port&#233;s s'est
	  principalement focalis&#233;e par le pass&#233; sur ia32, et
	  il n'est pas &#233;tonnant que de nombreux logiciels
	  port&#233;s ne compilent pas ou ne fonctionnent pas sur ia64.
	  Regardez <a
	  href="http://pointyhat.FreeBSD.org/errorlogs/ia64-6-latest/">ici</a>
	  pour une liste &#224; jour des logiciels port&#233;s qui ne
	  compilent pas pour une raison ou pour une autre.  Veuillez
	  noter que si des logiciels port&#233;s d&#233;pendent d'un ou
	  plusieurs logiciels port&#233;s cass&#233;s, ceux-ci ne sont
	  pas compil&#233;s et compt&#233;s.  Un bon moyen d'aider est
	  de travailler sur les logiciels port&#233;s qui ont beaucoup
	  de de d&#233;pendances (voir la colonne "Aff." dans le
	  tableau).
	</p>

	<h4>
	  Aff&#251;ter la scie
	</h4>
	<p>
	  De nombreuses fonctions (plus particuli&#232;rement des
	  routines en assembleur) ont &#233;t&#233; &#233;crites pour
	  combler une fonctionnalit&#233; manquante, sans aucune
	  consid&#233;ration de vitesse et/ou robustesse.  Une revue de
	  ces fonctions et un remplacement si n&#233;cessaire est une
	  bonne t&#226;che qui peut &#234;tre men&#233;e en
	  parrall&#232;le et ind&#233;pendamment d'autres activit&#233;s
	  et ne requi&#232;rent pas de connaissances et/ou
	  d'exp&#233;rience particuli&#232;res.
	</p>

	<h4>
	  D&#233;veloppement central
	</h4>
	<p>
	  Dans les choses de haut niveau qui ne marchent pas ou
	  n'existent pas, il y aussi des choses qui impliquent une
	  r&#233;&#233;criture des fondations et qui affectent
	  potentiellement les autres plateformes &#233;galement.  Ceci
	  comprend:
	</p>
	<ul>
	  <li>
	    Am&#233;liorer la stabilit&#233; UP et SMP en
	    am&#233;liorant le module PMAP.  La gestion bas niveau des
	    translations VM doit &#234;tre am&#233;lior&#233;e.  Ceci
	    inclut aussi bien l'exactitude que la performance.
	  </li>
	  <li>
	    Des pilotes de base comme sio(4) et syscons(4) ne
	    fonctionnent pas sur les machines ia64 qui ne supportent pas
	    les anciens p&#233;riph&#233;riques.  C'est un gros
	    probl&#232;me, car cela concerne toutes les plateformes et
	    pourrait n&#233;cessiter la r&#233;&#233;criture de grosses
	    parties de certains sous syst&#232;mes.  Cette t&#226;che a
	    besoin d'un support massif et de coordination.
	  </li>
	  <li>
	    Une meilleure gestion des configurations de m&#233;moire
	    (physique) clairsem&#233;e en ne cr&#233;ant pas de tableaux
	    de la VM qui recouvrent tout l'espace d'addressage, mais qui
	    couvrent plut&#244;t les morceaux de m&#233;moire qui sont
	    pr&#233;sents.  Nous sommes actuellement oblig&#233;s
	    d'ignorer de la m&#233;moire &#224; cause de cela.
	  </li>
	</ul>

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
