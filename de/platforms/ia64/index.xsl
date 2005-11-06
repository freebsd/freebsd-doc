<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
  $FreeBSDde: de-www/platforms/ia64/index.xsl,v 1.4 2005/11/06 12:48:05 jkois Exp $
  basiert auf: 1.2
-->

  <xsl:import href="../../includes.xsl"/>
  <xsl:import href="includes.xsl"/>
  <xsl:variable name="base" select="'../..'"/>
  <xsl:variable name="enbase" select="'../../..'"/>
  <xsl:variable name="section" select="'developers'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:output doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    encoding="iso-8859-1" method="html"/>
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

	      <img align="right" alt="McKinley die" src="{$enbase}/platforms/ia64/mckinley-die.png"/>

	      <p>Das Archiv der ia64-Mailinglisten durchsuchen:</p>

		<form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
		  <input name="words" size="50" type="text"/>
		  <input name="max" type="hidden" value="25"/>
		  <input name="source" type="hidden" value="freebsd-ia64"/>
		  <input type="submit" value="Los"/>
		</form>

	<h3><a name="toc">Inhaltsverzeichnis</a></h3>

        <ul>
          <li>
            <a href="#intro">Einf&#252;hrung</a>
          </li>
          <li>
            <a href="#status">Aktueller Status</a>
          </li>
          <li>
            <a href="todo.html">Was noch fehlt</a>
          </li>
          <li>
            <a href="machines.html">Hardware-Liste</a>
          </li>
          <li>
            <a href="refs.html">Referenzen</a>
          </li>
        </ul>

        <h3>
          <a name="intro">Einf&#252;hrung</a>
        </h3>

	<p>Die FreeBSD/ia64 Projekt-Seiten enthalten Informationen
	  &#252;ber das Portieren von FreeBSD auf die Intel IA-64
	  Architektur; offiziell als Intel Itanium&#174; Processor
	  Family (IPF) bezeichnet.  Wie die Portierung selbst,
	  befinden sich diese Seiten noch in Arbeit.</p>

        <h3>
          <a name="status">Aktueller Status</a>
        </h3>

        <p>Die ia64-Portierung wird noch immer als Tier&#160;2
	  Plattform betrachtet.  Sie wird daher nicht vollst&#228;ndig
	  vom Security-Officer, den Release-Engineers und den
	  Betreuern des Bausystems unterst&#252;tzt.  In der Praxis
	  ist die Unterscheidung zwischen einer Tier&#160;1
	  Plattform (welche komplett unterst&#252;tzt wird) und einer
	  Tier&#160;2 Plattform nicht ganz so streng, wie es scheint.
	  In den meisten Aspekten entspricht die ia64-Portierung
	  eher einer Tier&#160;1 Plattform.
	  <br />
	  Aus Entwicklersicht ist es ein Vorteil, dass die Portierung
	  noch etwas l&#228;nger als Tier&#160;2 Plattform gilt.  Es
	  sind noch ein paar ABI-&#196;nderungen vorgesehen und in
	  diesem fr&#252;hen Entwicklungsstadium ist es nicht sehr
	  zweckdienlich, auf R&#252;ckw&#228;rtskompatibilit&#228;t
	  achten zu m&#252;ssen.</p>

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
