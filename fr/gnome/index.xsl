<!-- $FreeBSD$ -->

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

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:variable name="title" select="'Projet GNOME pour FreeBSD'"/>

  <xsl:output type="html" encoding="iso-8859-1"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <xsl:copy-of select="$header1"/>

      <body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#840084"
            alink="#0000FF">

        <xsl:copy-of select="$header2"/>

        <table border="0" cellspacing="0" cellpadding="2">
          <tr>
            <td valign="top"> <!-- width="10%" -->
              <table border="0" cellspacing="0" cellpadding="1"
                     bgcolor="#000000" width="100%">
                <tr>
                  <td>
                    <table cellpadding="4" cellspacing="0" border="0"
                           bgcolor="#ffcc66" width="100%">
                      <tr>
                        <td>

                          <p><font size="+1" color="#990000"><b>GNOME sous FreeBSD</b></font>
                            <small><br/>
                              &#183; <a href="http://www.FreeBSD.org/gnome/">GNOME sous FreeBSD - Accueil</a><br/>
                              &#183; <a href="docs/faq.html#q1">Instructions d'installation pour GNOME 1.4</a><br/>
                              &#183; <a href="docs/faq2.html#q1">Instructions d'installation pour GNOME 2.2</a><br/>
                              &#183; <a href="../ports/gnome.html">Applications disponibles</a><br/>
                              &#183; <a href="docs/volunteer.html">Comment participer</a><br/>
                              &#183; <a href="docs/bugging.html">Rapporter un bug</a><br/>
                              &#183; <a href="screenshots.html">Captures d'&#233;crans</a><br/>
                              &#183; <a href="contact.html">Nous contacter</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Documentation</b></font>
                            <small><br/>
                              &#183; <a href="docs/faq.html">FAQ GNOME 1.4</a><br/>
                              &#183; <a href="docs/faq2.html">FAQ GNOME 2.2</a><br/>
                              &#183; <a href="docs/porting.html">Cr&#233;ation des ports</a><br/>
                              &#183; <a href="docs/22knownissues.html">Probl&#232;mes connus avec GNOME 2.2 sous FreeBSD</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Ressources</b></font>
                            <small><br/>
                              &#183; <a href="http://www.gnome.org/">Projet GNOME</a><br/>
                              &#183; <a href="http://www.gnome.org/gnome-office/">Suite bureautique GNOME</a><br/>
                              &#183; <a href="http://gnu-darwin.sourceforge.net/GNOME/">GNOME sous GNU/Darwin</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Autres projets</b></font>
                            <small><br/>
                              &#183; <a href="http://www.kde.org/">Projet KDE</a><br/>
                              &#183; <a href="http://freebsd.kde.org/">KDE sous FreeBSD</a><br/>
                              &#183; <a href="http://www.opengroup.org/desktop/">CDE (commercial)</a><br/>
                            </small></p>

                          <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
                            <small>Recherche dans les archives de la liste de diffusion freebsd-gnome :<br/>
                              <input type="text" name="words" size="10"/>
                              <input type="hidden" name="max" value="25"/>
                              <input type="hidden" name="source" value="freebsd-gnome"/>
                              <input type="submit" value="Go"/>
                            </small>
                          </form>

                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>

            <td></td>

            <!-- Main body column -->

            <td align="left" valign="top" rowspan="2">
              <h2><font color="#990000">Qu'est-ce que GNOME ?</font></h2>
              <img src="{$base}/gnome/images/gnome.png" align="right"
                   border="0" width="66" height="83" alt="GNOME Logo"/>

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

              <h2><font color="#990000">Statut du port</font></h2>

              <p>Nous supportons actuellement les syst&#232;mes FreeBSD 4.x et 5-CURRENT 
                pour GNOME 1.4 et 2.2. Les versions ant&#233;rieures &#224; FreeBSD 4.6 ne 
		sont pas support&#233;es. La plus grande partie de GNOME a &#233;t&#233; port&#233; sous FreeBSD;
                toutefois, il reste <a href="docs/volunteer.html">encore beaucoup &#224;  
		faire</a> !</p>

            </td>
            
            <td></td>

            <!-- Right-most column -->
            <td valign="top"> <!-- width="20%" -->
              <!-- News table -->
              <table border="0" cellspacing="0" cellpadding="1"
                     bgcolor="#000000" width="100%">
                <tr>
                  <td>
                    <table cellpadding="4" cellspacing="0" border="0"
                           bgcolor="#ffcc66" width="100%">
                      <tr>
                        <td valign="top">
                        
                        <p><font size="+1" color="#990000"><b>Nouvelles de GNOME pour FreeBSD</b></font><br/>
                          <font size="-1">
                            Derni&#232;res mises &#224; jour : 
                            <xsl:value-of
                              select="descendant::month[position() = 1]/name"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of
                              select="descendant::day[position() = 1]/name"/>,
                            <xsl:text> </xsl:text>
                            <xsl:value-of
                              select="descendant::year[position() = 1]/name"/>
                            <br/>
                            <!-- Pull in the 10 most recent news items -->
                            <xsl:for-each select="descendant::event[position() &lt;= 10]">
                              &#183;  <a>
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
                              </a>
                            </xsl:for-each>
                            <a href="newsflash.html">Plus...</a>
                          </font></p>
                          
                          <p><font size="+1" color="#990000"><b>Nouvelles du Projet GNOME</b></font><br/>
                            <font size="-1">
                              <xsl:for-each select="document('http://gnomedesktop.org/backend.php')/rss/channel/*[name() = 'item'][position() &lt; 10]">
                                &#183; <a>
                                  <xsl:attribute name="href">
                                    <xsl:value-of select="link"/>
                                  </xsl:attribute>
                                  <xsl:value-of select="title"/><br/>
                                </a>
                              </xsl:for-each>
                            <a>
                              <xsl:for-each select="document('http://gnomedesktop.org/backend.php')/rss/*[name() = 'channel'][position() = 1]">
                                <xsl:attribute name="href">
                                  <xsl:value-of select="link"/>
                                </xsl:attribute>Plus...
                              </xsl:for-each>
                            </a>
                          </font></p>

                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
            
          </tr>
        </table>
        <xsl:copy-of select="$footer"/>
      </body>
    </html>
  </xsl:template>    
</xsl:stylesheet>
