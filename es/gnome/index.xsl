<?xml version="1.0" encoding="ISO-8859-1"?>

<!-- $FreeBSD: www/es/gnome/index.xsl,v 1.1 2003/05/11 19:49:25 jesusr Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdf1="http://my.netscape.com/rdf/simple/0.9/"
		version="1.0">
  
  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/es/gnome/index.xsl,v 1.1 2003/05/11 19:49:25 jesusr Exp $'"/>
  <xsl:variable name="title" select="'Proyecto FreeBSD GNOME'"/>

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

                          <p><font size="+1" color="#990000"><b>GNOME en FreeBSD</b></font>
                            <small><br/>
                              &#183; <a href="http://www.FreeBSD.org/gnome/">Inicio GNOME en FreeBSD</a><br/>
                              &#183; <a href="docs/faq.html#q1">Instrucciones de Instalaci&#243;n para GNOME 1.4</a><br/>
                              &#183; <a href="docs/faq2.html#q1">Instrucciones de Instalaci&#243;n para GNOME 2.0</a><br/>
                              &#183; <a href="../ports/gnome.html">Aplicaciones Disponibles</a><br/>
                              &#183; <a href="docs/volunteer.html">C&#243;mo Ayudar</a><br/>
                              &#183; <a href="docs/bugging.html">Reportando un Error</a><br/>
                              &#183; <a href="screenshots.html">Screenshots</a><br/>
                              &#183; <a href="contact.html">Cont&#225;ctenos</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Documentaci&#243;n</b></font>
                            <small><br/>
                              &#183; <a href="docs/faq.html">FAQ de GNOME 1.4</a><br/>
                              &#183; <a href="docs/faq2.html">FAQ de GNOME 2.0</a><br/>
                              &#183; <a href="docs/porting.html">Creaci&#243;n de Ports</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Recursos</b></font>
                            <small><br/>
                              &#183; <a href="http://www.gnome.org/">Proyecto GNOME</a><br/>
                              &#183; <a href="http://www.gnome.org/gnome-office/">GNOME Office</a><br/>
                              &#183; <a href="http://gnu-darwin.sourceforge.net/GNOME/">GNOME en GNU/Darwin</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Proyectos Relacionados</b></font>
                            <small><br/>
                              &#183; <a href="http://www.kde.org/">Proyecto KDE</a><br/>
                              &#183; <a href="http://freebsd.kde.org/">KDE en FreeBSD</a><br/>
                              &#183; <a href="http://www.opengroup.org/desktop/">CDE (comercial)</a><br/>
                            </small></p>

                          <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
                            <small>B&#250;squeda en los archivos de la lista de correo freebsd-gnome:<br/>
                              <input type="text" name="words" size="10"/>
                              <input type="hidden" name="max" value="25"/>
                              <input type="hidden" name="source" value="freebsd-gnome"/>
                              <input type="submit" value="Enviar"/>
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
              <h2><font color="#990000">&#191;Qu&#233; es GNOME?</font></h2>
              <img src="../../en/gnome/images/gnome.png" align="right"
                   border="0" width="66" height="83" alt="GNOME Logo"/>

              <p>El proyecto GNOME  nace para crear un entorno de
                escritorio para sistemas abiertos  que sea completamente libre.
                Desde un principio  el objetivo principal de GNOME ha sido disponer  
                de un conjunto de aplicaciones y un entorno de escritorio de 
                f&#225;cil uso.  El proyecto FreeBSD GNOME tiene como objetivo 
                acercar GNOME al usuario de FreeBSD.</p>

              <p>Como la mayor parte de los programas GNU, GNOME ha sido 
                dise&#241;ado para ser ejecutado en todos los sistemas 
                operativos modernos basados en UNIX.  Por medio del esfuerzo del
                Proyecto FreeBSD GNOME e incontables voluntarios esos sistemas
                operativos incluyen a FreeBSD.</p>

              <p>En los pasados meses el proyecto GNOME ha expandido sus 
                objetivos, para se&#241;alar cierto n&#250;mero de problemas que
                existen en la infraestructura Unix.</p>

              <p>El Proyecto GNOME  act&#250;a como sombrilla.  Los componentes 
                m&#225;s importantes de GNOME  son:</p>
              <ul>
                <li>El <a href="http://www.gnome.org">escritorio GNOME</a>:  Un 
                  entorno gr&#225;fico, basado en un entorno de ventanas, para
                  el usuario.</li>
                <li>La <a href="http://developer.gnome.org">plataforma de
                  desarrollo GNOME</a>:  Una rica colecci&#243;n de herramientas,
                  librer&#237;as y componentes  para desarrollar poderosas
                  aplicaciones en Unix.</li>
                <li>La suite de <a href="http://www.gnome.org/gnome-office">Oficina
                  de GNOME</a>:  Un conjunto de aplicaciones de oficina.</li>
              </ul>

              <h2><font color="#990000">Est&#225;atus de la migraci&#243;n</font></h2>

              <p>Actualmente se cuenta con soporte para GNOME 1.4 y 2.0 para 
                sistemas FreeBSD 4.x y 5 -CURRENT.  Cualquier versi&#243;n
                anterior a FreeBSD 4.5  no est&#225; soportada.  La mayor parte de 
                GNOME ha sido portado a FreeBSD aunque a&#250;n <a 
                href="docs/volunteer.html">hay mucho por hacer</a>!.</p>

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
                        
                        <p><font size="+1" color="#990000"><b>Noticias FreeBSD GNOME</b></font><br/>
                          <font size="-1">
                            Ultima actualizaci&#243;n: 
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
                            <a href="newsflash.html">More...</a>
                          </font></p>
                          
                          <p><font size="+1" color="#990000"><b>Noticias Proyecto GNOME</b></font><br/>
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
                                </xsl:attribute>More...
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
