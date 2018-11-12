<?xml version="1.0" encoding="KOI8-R" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSDru: frdp/www/ru/gnome/index.xsl,v 1.5 2004/01/13 12:07:39 andy Exp $

     Original revision: 1.46
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdf1="http://my.netscape.com/rdf/simple/0.9/"
		exclude-result-prefixes="rdf rdf1" version="1.0">
  
  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>
  <xsl:variable name="section" select="'developers'"/>

  <xsl:variable name="base" select="'../..'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:variable name="title" select="'������ FreeBSD GNOME'"/>

  <xsl:output type="html" encoding="koi8-r"
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
      	      
	      <xsl:copy-of select="$header3"/>

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

                          <p><font size="+1" color="#990000"><b>GNOME �� FreeBSD</b></font>
                            <small><br/>
                              &#183; <a href="http://www.FreeBSD.org/ru/gnome/">������� ��������</a><br/>
                              &#183; <a href="docs/faq2.html#q1">���������� �� ���������</a><br/>
                              &#183; <a href="../ports/gnome.html">��������� ����������</a><br/>
                              &#183; <a href="docs/volunteer.html">��� ������</a><br/>
                              &#183; <a href="docs/bugging.html">�������� �� ������</a><br/>
                              &#183; <a href="screenshots.html">���������</a><br/>
                              &#183; <a href="contact.html">��������� � ����</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>������������</b></font>
                            <small><br/>
                              &#183; <a href="docs/faq2.html">FAQ</a><br/>
                              &#183; <a href="docs/develfaq.html">FAQ �� ����� ����������</a><br/>
                              &#183; <a href="docs/porting.html">�������� ������</a><br/>
                              &#183; <a href="docs/knownissues.html">��������� ��������</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>�������</b></font>
                            <small><br/>
                              &#183; <a href="http://www.gnome.org/">������ GNOME</a><br/>
                              &#183; <a href="http://www.gnome.org/gnome-office/">GNOME Office</a><br/>
                              &#183; <a href="http://gnu-darwin.sourceforge.net/GNOME/">GNOME �� GNU/Darwin</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>������� �������</b></font>
                            <small><br/>
                              &#183; <a href="http://www.kde.org/">������ KDE</a><br/>
                              &#183; <a href="http://freebsd.kde.org/">KDE �� FreeBSD</a><br/>
                              &#183; <a href="http://www.opengroup.org/desktop/">CDE (������������)</a><br/>
                            </small></p>

                          <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
                            <small>����� � ������� �������� freebsd-gnome:<br/>
                              <input type="text" name="words" size="10"/>
                              <input type="hidden" name="max" value="25"/>
                              <input type="hidden" name="source" value="freebsd-gnome"/>
                              <input type="submit" value="������"/>
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
              <h2><font color="#990000">��� ����� GNOME?</font></h2>
              <img src="{$base}/gnome/images/gnome.png" align="right"
                   border="0" alt="GNOME Logo"/>

              <p>������ GNOME ��� ����� � ����� �������� ��������� ���������
                ����������� �������� ��� �������� ���������������� ������.  �
                ������ ������ ������� ������� GNOME ���� �������� ������
                ���������� � ����������� �������� � ������� �������������
                �����������.  ������ FreeBSD GNOME �������� ��� ��������� GNOME
                �� FreeBSD.</p>

              <p>��� � ��� ����������� �������� GNU, �������� GNOME
                ��������������� ��� ������ �� ���� ����������� Unix-��������
                ������������ ��������.  ��������� ������� ������� FreeBSD GNOME
                � ��������� ������������, � ���� ������ ������������ ������
                ���� FreeBSD.</p>

              <p>������ GNOME � ��������� ��������� ������� �������� ����
                ������� � ������� ������� ��������� �������, ��������
                ��������� �������������� <xsl:value-of select="$unix"/>.</p>

              <p>������ GNOME �������� ��� ������.  ��������� ������������
                GNOME ��������:</p>

              <ul>
                <li> <a href="http://www.gnome.org">������� ���� GNOME</a>:
                  ������� � ������������� ������� ������� ���
                  �������������.</li>

                <li> <a href="http://developer.gnome.org">��������� ����������
                  GNOME</a>:  ������� ��������� ������������, ��������� �
                  ��������� ��� ���������� ������ ���������� � Unix.</li>

                <li> <a href="http://www.gnome.org/gnome-office">GNOME
                  Office</a>:  ����� ������� ����������.</li>
              </ul>

              <h2><font color="#990000">��������� �����</font></h2>

              <p>GNOME ��� FreeBSD �� ������ ������ �������������� � �������
                4.8, 4.9, 5.2, -STABLE � -CURRENT.  ����������� ��
                GNOME ���� ���������� �� FreeBSD; ������ �ӣ �ݣ <a
                href="docs/volunteer.html">���� ��� ��� ����������</a>!</p>
            </td>

            <td></td>

            <!-- ������ ������� ������� -->
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
                        
                        <p><font size="+1" color="#990000"><b>FreeBSD GNOME News</b></font><br/>
                          <font size="-1">
                            Latest update: 
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
                          
                          <p><font size="+1" color="#990000"><b>GNOME Project News</b></font><br/>
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
