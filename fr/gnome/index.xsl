<!-- $FreeBSD: www/fr/gnome/index.xsl,v 1.1 2003/05/04 12:28:49 stephane Exp $ -->

<!-- 
   The FreeBSD French Documentation Project 
   Original revision: 1.34
   
   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdf1="http://my.netscape.com/rdf/simple/0.9/"
		version="1.0">
  
  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>
  <xsl:variable name="section" select="'developers'"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/fr/gnome/index.xsl,v 1.1 2003/05/04 12:28:49 stephane Exp $'"/>
  <xsl:variable name="title" select="'Projet GNOME pour FreeBSD'"/>

  <xsl:output type="html" encoding="iso-8859-1"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <xsl:copy-of select="$header1"/>
      
            <body xsl:use-attribute-sets="att.body">
      
        <div id="containerwrap">
          <div id="container">
      
      	<xsl:copy-of select="$header2"/>
      
      	<div id="content">
      
      	      <xsl:copy-of select="$sidenav"/>
      
      	      <div id="contentwrap">
      	      
      	      <div id="rightwrap">
		<div class="rightnav">

		<h2>Nouvelles de GNOME pour FreeBSD</h2>
		<p>
		    Derni&#232;res mises &#224; jour:
		    <xsl:value-of
		      select="descendant::month[position() = 1]/name"/>
		    <xsl:text> </xsl:text>
		    <xsl:value-of
		      select="descendant::day[position() = 1]/name"/>,
		    <xsl:text> </xsl:text>
		    <xsl:value-of
		      select="descendant::year[position() = 1]/name"/>
		    </p>
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

		  </div> <!-- rightnav -->
                </div> <!-- rightwrap -->
      	      
	      <xsl:copy-of select="$header3"/>

              <h2>Qu'est-ce que GNOME ?</h2>
              <img src="{$enbase}/gnome/images/gnome.png" align="right"
                   border="0" alt="GNOME Logo"/>

              <p>Le projet GNOME est n&#233; d'un effort pour cr&#233;er un environnement de travail 
	        enti&#232;rement libre pour les syst&#232;mes libres. Depuis le d&#233;but, l'objectif principal
                de GNOME est de fournir une suite d'applications et un environnement
		simples &#224; utiliser. Le Projet GNOME pour FreeBSD
                s'efforce d'apporter GNOME aux utilisateurs de FreeBSD.</p>

              <p>Comme pour la plupart des programmes GNU, GNOME a &#233;t&#233; con&#231;u pour fonctionner sur tous
                les syst&#232;mes d'exploitation modernes de type Unix. Gr&#226;ce aux efforts du
                Projet GNOME pour FreeBSD et de nombreux volontaires, FreeBSD fait partie
		de ces syst&#232;mes.</p>

              <p>Le projet GNOME a &#233;tendu ses objectifs depuis les derniers 
                mois pour essayer de r&#233;soudre un certain nombre de probl&#232;mes dans l'infrastructure
		actuelle du syst&#232;me Unix.</p>

              <p>Le projet GNOME chapeaute le tout. Les principaux composants de
                GNOME sont :</p>
              <ul>
                <li>Le <a href="http://www.gnome.org">bureau GNOME</a> : Un environnement
                  graphique simple &#224; utiliser &#224; destination des utilisateurs.</li>
                <li>The <a href="http://developer.gnome.org">plate-forme de d&#233;veloppement
		  GNOME</a> : Une importante collection d'outils, de biblioth&#232;ques
                  et de composants pour d&#233;velopper des applications sous Unix.</li>
                <li>The <a href="http://www.gnome.org/gnome-office">Suite bureautique
		  GNOME</a> : Un ensemble d'applications &#224; vocation bureautique.</li>
              </ul>

              <h2>Statut du port</h2>

              <p>Nous supportons actuellement les syst&#232;mes FreeBSD 4.x et 5-CURRENT 
                pour GNOME 1.4 et 2.2. Les versions ant&#233;rieures &#224; FreeBSD 4.6 ne 
		sont pas support&#233;es. La plus grande partie de GNOME a &#233;t&#233; port&#233; sous FreeBSD;
                toutefois, il reste <a href="docs/volunteer.html">encore beaucoup &#224;  
		faire</a> !</p>

	  <h2>GNOME sous FreeBSD</h2>
	    <ul>
	      <li><a href="http://www.FreeBSD.org/gnome/">GNOME sous FreeBSD - Accueil</a></li>
	      <li><a href="docs/faq.html#q1">Instructions d'installation pour GNOME 1.4</a></li>
	      <li><a href="docs/faq2.html#q1">Instructions d'installation pour GNOME 2.2</a></li>
	      <li><a href="../ports/gnome.html">Applications disponibles</a></li>
	      <li><a href="docs/volunteer.html">Comment participer</a></li>
	      <li><a href="docs/bugging.html">Rapporter un bug</a></li>
	      <li><a href="screenshots.html">Captures d'&#233;crans</a></li>
	      <li><a href="contact.html">Nous contacter</a></li>
	    </ul>

	  <h2>Documentation</h2>
	    <ul>
	      <li><a href="docs/faq.html">FAQ GNOME 1.4</a></li>
	      <li><a href="docs/faq2.html">FAQ GNOME 2.2</a></li>
	      <li><a href="docs/porting.html">Cr&#233;ation des ports</a></li>
	      <li><a href="docs/22knownissues.html">Probl&#232;mes connus avec GNOME 2.2 sous FreeBSD</a></li>
	    </ul>

	  <h2>Ressources</h2>
	    <ul>
	      <li><a href="http://www.gnome.org/">Projet GNOME</a></li>
	      <li><a href="http://www.gnome.org/gnome-office/">Suite bureautique GNOME</a></li>
	      <li><a href="http://gnu-darwin.sourceforge.net/GNOME/">GNOME sous GNU/Darwin</a></li>
	    </ul>

	  <h2>Autres projets</h2>
	    <ul>
	      <li><a href="http://www.kde.org/">Projet KDE</a></li>
	      <li><a href="http://freebsd.kde.org/">KDE sous FreeBSD</a></li>
	      <li><a href="http://www.opengroup.org/desktop/">CDE (commercial)</a></li>
	    </ul>

	  <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
	    <p>Recherche dans les archives de la liste de diffusion freebsd-gnome:</p>
	      <input type="text" name="words" size="20"/>
	      <input type="hidden" name="max" value="25"/>
	      <input type="hidden" name="source" value="freebsd-gnome"/>
	      <input type="submit" value="Go"/>
	  </form>

	  	</div> <!-- contentwrap -->
		<br class="clearboth" />
	
	</div> <!-- content -->
	
	<xsl:copy-of select="$footer"/>
	
        </div> <!-- container -->
   </div> <!-- containerwrap -->

      </body>
    </html>
  </xsl:template>    
</xsl:stylesheet>
