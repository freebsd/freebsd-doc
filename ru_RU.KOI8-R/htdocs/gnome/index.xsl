<?xml version="1.0" encoding="koi8-r" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSDru: frdp/www/ru/gnome/index.xsl,v 1.5 2004/01/13 12:07:39 andy Exp $

     Original revision: 1.46
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdf1="http://my.netscape.com/rdf/simple/0.9/"
		xmlns="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="rdf rdf1" version="1.0">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>
  <xsl:variable name="section" select="'developers'"/>

  <xsl:variable name="base" select="'../..'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:variable name="title" select="'Проект FreeBSD GNOME'"/>

  <xsl:template names="process.content">
	<div id="contentwrap">

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

                          <p><font size="+1" color="#990000"><b>GNOME на FreeBSD</b></font>
                            <small><br/>
                              &#183; <a href="http://www.FreeBSD.org/ru/gnome/">Главная страница</a><br/>
                              &#183; <a href="docs/faq2.html#q1">Инструкции по установке</a><br/>
                              &#183; <a href="../ports/gnome.html">Доступные приложения</a><br/>
                              &#183; <a href="docs/volunteer.html">Как помочь</a><br/>
                              &#183; <a href="docs/bugging.html">Сообщить об ошибке</a><br/>
                              &#183; <a href="screenshots.html">Скриншоты</a><br/>
                              &#183; <a href="contact.html">Связаться с нами</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Документация</b></font>
                            <small><br/>
                              &#183; <a href="docs/faq2.html">FAQ</a><br/>
                              &#183; <a href="docs/develfaq.html">FAQ по ветке разработки</a><br/>
                              &#183; <a href="docs/porting.html">Создание портов</a><br/>
                              &#183; <a href="docs/knownissues.html">Известные проблемы</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Ресурсы</b></font>
                            <small><br/>
                              &#183; <a href="http://www.gnome.org/">Проект GNOME</a><br/>
                              &#183; <a href="http://www.gnome.org/gnome-office/">GNOME Office</a><br/>
                              &#183; <a href="http://gnu-darwin.sourceforge.net/GNOME/">GNOME на GNU/Darwin</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Близкие проекты</b></font>
                            <small><br/>
                              &#183; <a href="http://www.kde.org/">Проект KDE</a><br/>
                              &#183; <a href="http://freebsd.kde.org/">KDE на FreeBSD</a><br/>
                              &#183; <a href="http://www.opengroup.org/desktop/">CDE (коммерческий)</a><br/>
                            </small></p>

                          <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
                            <small>Поиск в архивах рассылки freebsd-gnome:<br/>
                              <input type="text" name="words" size="10"/>
                              <input type="hidden" name="max" value="25"/>
                              <input type="hidden" name="source" value="freebsd-gnome"/>
                              <input type="submit" value="Искать"/>
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
              <h2><font color="#990000">Что такое GNOME?</font></h2>
              <img src="{$base}/gnome/images/gnome.png" align="right"
                   border="0" alt="GNOME Logo"/>

              <p>Проект GNOME был начат с целью создания полностью свободной
                графической оболочки для свободно распространяемых систем.  С
                самого начала главной задачей GNOME было создание пакета
                приложений и графической оболочки с простым дружественным
                интерфейсом.  Проект FreeBSD GNOME работает над переносом GNOME
                во FreeBSD.</p>

              <p>Как и для большинства программ GNU, оболочка GNOME
                проектировалась для работы на всех современных Unix-подобных
                операционных системах.  Благодаря усилиям Проекта FreeBSD GNOME
                и множества добровольцев, в этом списке операционных систем
                есть FreeBSD.</p>

              <p>Проект GNOME в последние несколько месяцев расширил свои
                границы в сторону решения некоторых проблем, присущих
                имеющейся инфраструктуре <xsl:value-of select="$unix"/>.</p>

              <p>Проект GNOME выглядит как зонтик.  Основными компонентами
                GNOME являются:</p>

              <ul>
                <li> <a href="http://www.gnome.org">Рабочий стол GNOME</a>:
                  Простая в использовании оконная система для
                  пользователей.</li>

                <li> <a href="http://developer.gnome.org">Платформа разработки
                  GNOME</a>:  Богатая коллекция инструментов, библиотек и
                  компонент для разработки мощных приложений в Unix.</li>

                <li> <a href="http://www.gnome.org/gnome-office">GNOME
                  Office</a>:  Набор офисных приложений.</li>
              </ul>

              <h2><font color="#990000">Состояние порта</font></h2>

              <p>GNOME для FreeBSD на данный момент поддерживается в версиях
                4.8, 4.9, 5.2, -STABLE и -CURRENT.  Большинство из
                GNOME было перенесено во FreeBSD; однако всё ещё <a
                href="docs/volunteer.html">есть над чем поработать</a>!</p>
            </td>

            <td></td>

            <!-- Правая крайняя колонка -->
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
  </xsl:template>
</xsl:stylesheet>
