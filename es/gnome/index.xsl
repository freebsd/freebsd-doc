<!-- $FreeBSD: www/es/gnome/index.xsl,v 1.43 2003/10/30 13:41:49 marcus Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:rdf1="http://my.netscape.com/rdf/simple/0.9/"
                exclude-result-prefixes="rdf rdf1" version="1.0">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/es/gnome/index.xsl,v 1.43 2003/10/30 13:41:49 marcus Exp $'"/>
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
                              &#183; <a href="http://www.FreeBSD.org/es/gnome/">Inicio GNOME en FreeBSD</a><br/>
                              &#183; <a href="docs/faq2.html#q1">Instrucciones de Instalaci&#243;n</a><br/>
                              &#183; <a href="../ports/gnome.html">Aplicaciones Disponibles</a><br/>
                              &#183; <a href="docs/volunteer.html">C&#243;mo Ayudar</a><br/>
                              &#183; <a href="docs/bugging.html">Reportando un Error (Bug)</a><br/>
                              &#183; <a href="screenshots.html">Capturas de Pantalla</a><br/>
                              &#183; <a href="contact.html">Cont&#225;ctenos</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Documentaci&#243;n</b></font>
                            <small><br/>
                              &#183; <a href="docs/faq2.html">GNOME FAQ</a><br/>
                              &#183; <a href="docs/porting.html">Creando Ports</a><br/>
                              &#183; <a href="docs/knownissues.html">Problemas Conocidos</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Fuentes</b></font>
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
                            <small>Buscar en archivos de la lista de correo freebsd-gnome:<br/>
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
              <h2><font color="#990000">&#191;Qu&#233; es GNOME?</font></h2>
              <img src="{$base}/gnome/images/gnome.png" align="right"
                   border="0" alt="GNOME Logo"/>

              <p>El proyecto GNOME nace como un esfuerzo de crear un entorno
                completo de escritorio para sistemas libres.  Desde un comienzo,
                el objetivo principal de GNOME ha sido el de proveer al usuario
                un entorno de escritorio de f&#225;cil uso y una suite completa de
                aplicaciones amigables.  El Proyecto FreeBSD GNOME consiste en
                llevar GNOME al usuario de FreeBSD.</p>

              <p>Como sucede con la mayoria de los programas GNU, GNOME ha
                sido dise&#241;ado para ejecutarse en todos los sistemas
                operativos modernos basados en Unix.  A traves del esfuerzo
                del Proyecto FreeBSD GNOME e infinidad de voluntarios, esa
                lista de sistemas operativos incluye a FreeBSD.</p>

              <p>En los ultimos meses, el proyecto GNOME ha expandido sus
                objetivos para solucionar un sinfin de problemas en la
                infrastructura existente.</p>

              <p>El proyecto GNOME actua como sombrilla.  Los principales
                componentes de GNOME son:</p>
              <ul>
                <li>El <a href="http://www.gnome.org">escritorio GNOME</a>:
                  Un entorno gr&#225;fico de f&#225;cil uso para usuarios.</li>
                <li>La plataforma de <a href="http://developer.gnome.org">
                  desarrollo GNOME</a>:  Una rica colecci&#243;n de herramientas,
                  librer&#237;as y componentes, para desarrollar potentes
                  aplicaciones en Unix.</li>
                <li>La <a href="http://www.gnome.org/gnome-office">GNOME
                  Office</a>:  Un conjunto de aplicaciones de oficina y 
                  productividad.</li>
              </ul>

              <h2><font color="#990000">Estado de la migraci&#243;n</font></h2>

              <p>Actualmente se soporta GNOME <xsl:copy-of select="$gnomever"/>
                en los sistemas FreeBSD 4.x y 5-CURRENT.  Cualquier versi&#243;n
                anterior a FreeBSD 4.8 no est&#225; soportada.  La mayor parte de
                GNOME ha sido migrada aunque, a&#250;n queda 
                <a href="docs/volunteer.html">mucho por hacer</a>!.</p>

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
                            Ultima Actualizacin:
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
                            <a href="newsflash.html">Ms...</a>
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
                                </xsl:attribute>Ms...
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
