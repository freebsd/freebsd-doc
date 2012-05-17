<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY email "freebsd-ia64">
<!ENTITY title "FreeBSD/ia64 Project">
<!ENTITY % navinclude.developers "INCLUDE">
]>
<!--
  $FreeBSDde: de-www/platforms/ia64/todo.xsl,v 1.16 2011/06/05 17:57:18 jkois Exp $
  $FreeBSD$
  basiert auf: 1.11
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD$'"/>

  <xsl:output doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    encoding="iso-8859-1" method="html"/>

  <xsl:template match="/">
    <html>
      &header1;
      <body>

	<div id="CONTAINERWRAP">
	  <div id="CONTAINER">
	    &header2;

	    <div id="CONTENT">
	      <div id="SIDEWRAP">
                &nav;
              </div> <!-- SIDEWRAP -->

	      <div id="CONTENTWRAP">
		&header3;

              <img align="right" alt="Montecito die" src="&enbase;/platforms/ia64/montecito-die.png"/>

	      <p>Die FreeBSD/ia64-PR-Datenbank durchsuchen:</p>

		<form action="http://www.FreeBSD.org/cgi/query-pr-summary.cgi" method="get">
		  <input type="hidden" name="category" value="ia64"/>
		  <input type="hidden" name="sort" value="none"/>
		  <input type="text" name="text"/>
		  <input type="submit" value="Los"/>
		</form>

	<h3>Was noch getan werden muss</h3>

	<p>Diese Seite ist Ausgangspunkt f&#252;r Leute, die Aufgaben
	  suchen.  Die Reihenfolge der Aufgaben auf dieser Seite ist
	  nicht immer ein Hinweis auf deren Priorit&#228;t, in der
	  Regel aber schon.  Nicht alle Aufgaben finden hier
	  Erw&#228;hnung, das bedeutet jedoch nicht, dass diese nicht
	  zu erledigen sind.  Ein typisches Beispiel ist das
	  Instandhalten der ia64 Webseiten ...
	  ungl&#252;cklicherweise.</p>

	<h4>Auf dem Weg zur Tier 1 Plattform</h4>

	<p>Nach zwei Ver&#246;ffentlichungen als Tier&#160;2 Plattform,
	  wird es Zeit, eine Tier&#160;1 Plattform zu werden.  Dies
	  umfasst verschiedene Aufgaben wie:</p>

	<ul>
	  <li>
	    Der Installationsprozess soll eine schon vorhandene
	    GPT mit einer EFI-Partition, die ein anderes
	    Betriebssystem enth&#228;lt, ber&#252;cksichtigen.
	    Ein FreeBSD-Eintrag im EFI-Boot-Men&#252; w&#228;re
	    auch ganz nett.
	  </li>
	  <li>
	    Portieren des GNU-Debuggers.  Er wird auf einer
	    Entwicklungsmaschine dringend ben&#246;tigt und ist
	    f&#252;r Tier&#160;1 Plattformen vorgeschrieben.
	  </li>
	  <li>
	    Portieren des X-Servers (ports/x11/XFree86-4-Server).
	    Dies ist nicht unbedingt Voraussetzung f&#252;r den
	    Tier&#160;1 Status, jedoch wird der X-Server gebraucht,
	    um ia64 als Desktopmaschine zu benutzen.
	  </li>
	</ul>

	<h4>Ports und Packages</h4>

	<p>Wichtig f&#252;r den Erfolg von FreeBSD auf ia64 sind neben
	  ls(1) weitere laufende Programme.  Unsere umfangreiche
	  Ports-Sammlung ist vor allem auf ia32 ausgerichtet,
	  kein Wunder also, dass viele Ports nicht unter ia64
	  bauen oder laufen.  Es gibt eine aktuelle <a
	  href="http://pointyhat.FreeBSD.org/errorlogs/ia64-8-latest/">Liste
	  der Ports</a>, die sich aus dem ein oder anderen Grund
	  nicht bauen lassen.  Ein Port wird nicht gebaut und nicht
	  gez&#228;hlt, wenn er von einem Port abh&#228;ngt, der sich
	  nicht bauen l&#228;sst.  Es w&#228;re eine gro&#223;e
	  Hilfe, wenn Sie an Ports arbeiten, von denen viele andere
	  Ports abh&#228;ngen (siehe die "Aff." Spalte der
	  Tabelle).</p>

	<h4>Feinschliff</h4>

	<p>Es gibt viele Funktionen (vor allem Routinen in
	  Maschinensprache), die ohne R&#252;cksicht auf
	  Geschwindigkeit oder Robustheit geschrieben wurden.  Diese
	  Funktionen k&#246;nnen unabh&#228;ngig von der laufenden
	  Entwicklung ersetzt werden.  Diese Aufgabe setzt auch nicht
	  unbedingt ein riesiges Wissen oder gro&#223;e Erfahrung
	  voraus.</p>

	<h4>Hauptentwicklung</h4>

	<p>Einige Sachen, die noch nicht funktionieren oder die
	  es noch nicht gibt, sind so verzwickt und grundlegend, dass
	  sie auch andere Plattformen betreffen k&#246;nnten.
	  Unter anderem:</p>

	<ul>
	  <li>
	    UP- und SMP-Stabilit&#228;t verbessern.  Das
	    Low-Level-Handling der VM-&#220;bersetzungen muss
	    verbessert werden.  Das betrifft die Korrektheit sowie die
	    Performanz.
	  </li>
	  <li>
	    Grundlegende Ger&#228;tetreiber wie sio(4) und syscons(4)
	    funktionieren nicht auf ia64 Maschinen, welche keine
	    Unterst&#252;tzung f&#252;r Legacy-Ger&#228;te haben.
	    Das ist ein gro&#223;es Problem, da dies alle Plattformen
	    betrifft und eventuell zur Konsequenz hat, dass
	    (gro&#223;e) Teile gewisser Subsysteme neu geschrieben
	    werden m&#252;ssen.  Auf jeden Fall eine Aufgabe, die
	    gro&#223; angelegte Unterst&#252;tzung und Koordination
	    ben&#246;tigt.
	  </li>
	  <li>
	    Besserer Umgang mit sp&#228;rlichen (physischen)
	    Speicherkonfigurationen, in dem das Erstellen von
	    VM-Tabellen, die den ganzen Adressraum umfassen, vermieden
	    wird.  Es sollen besser Speicherteile benutzt werden,
	    die zu Verf&#252;gung stehen.  Momentan sind wir
	    gezwungen, aus diesem Grund Speicher zu ignorieren.
	  </li>
	</ul>

	      </div> <!-- CONTENTWRAP -->

	      <br class="clearboth" />
	    </div> <!-- CONTENT -->
            <div id="FOOTER">
               &copyright;<br />
               &date;
            </div> <!-- FOOTER -->
	  </div> <!-- CONTAINER -->
	</div> <!-- CONTAINERWRAP -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
