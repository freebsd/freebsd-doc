<?xml version="1.0" encoding="ISO-8859-1" ?>

<!--
     $FreeBSD$
     $FreeBSDde: de-www/index.xsl,v 1.8 2003/08/17 16:53:30 mheinen Exp $
     basiert auf: 1.74
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD: www/en/index.xsl,v 1.42 2002/12/16 21:10:22 keramida Exp $'"/>
  <xsl:variable name="title" select="'The FreeBSD Project'"/>

  <xsl:output type="html" encoding="iso-8859-1"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="$title"/></title>

	<meta name="description" content="The FreeBSD Project"/>

	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Gallery,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="/favicon.ico" type="image/x-icon"/>
      </head>

      <body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#840084"
	    alink="#0000FF">

	<table border="0" cellspacing="0" cellpadding="0" width="100%">
	  <tr>
	    <td><a href="http://www.FreeBSD.org/index.html">
		<img src="{$enbase}/gifs/freebsd_1.gif" height="94" width="306"
		     alt="FreeBSD: The Power to Serve" border="0"/></a></td>

	    <td align="right" valign="bottom">
	      <form action="http://www.FreeBSD.org/cgi/mirror.cgi"
		    method="get">

		<br/>

		<font color="#990000"><b>W&#228;hlen Sie einen Server
		  in Ihrer N&#228;he:</b></font>

		<br/>

		<select name="goto">
		  <!--  Only list TRUE mirrrors here! Native language pages
		        which are not mirrored should be listed in
		        support.sgml.  -->

		  <option value="http://www.dk.FreeBSD.org/">IPv6 D&#228;nemark</option>
		  <option value="http://www2.de.FreeBSD.org/">IPv6 Deutschland</option>
		  <option value="http://www1.uk.FreeBSD.org/">IPv6 Gro&#223;britannien</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">IPv6 (6Bone), Japan</option>
		  <option value="http://www2.no.FreeBSD.org/">IPv6 Norwegen</option>
		  <option value="http://www2.at.FreeBSD.org/">IPv6 &#214;sterreich</option>
		  <option value="http://www4.us.FreeBSD.org/">IPv6 USA/1</option>
		  <option value="http://www5.us.FreeBSD.org/">IPv6 USA/2</option>
		  <option value="http://www.ar.FreeBSD.org/">Argentinien</option>
		  <option value="http://www.au.FreeBSD.org/">Australien/1</option>
		  <option value="http://www2.au.FreeBSD.org/">Australien/2</option>
		  <option value="http://freebsd.unixtech.be/">Belgien</option>
		  <option value="http://www.br.FreeBSD.org/freebsd/">Brasilien/1</option>
		  <option value="http://www2.br.FreeBSD.org/www.freebsd.org/">Brasilien/2</option>
		  <option value="http://www3.br.FreeBSD.org/">Brasilien/3</option>
		  <option value="http://www.bg.FreeBSD.org/">Bulgarien</option>
		  <option value="http://www.cn.FreeBSD.org/">China</option>
		  <option value="http://www.dk.FreeBSD.org/">D&#228;nemark/1</option>
		  <option value="http://www3.dk.FreeBSD.org/">D&#228;nemark/2</option>
		  <option value="http://www.de.FreeBSD.org/">Deutschland/1</option>
		  <option value="http://www1.de.FreeBSD.org/">Deutschland/2</option>
		  <option value="http://www2.de.FreeBSD.org/">Deutschland/3</option>
		  <option value="http://www.ee.FreeBSD.org/">Estland</option>
		  <option value="http://www.fi.FreeBSD.org/">Finnland/1</option>
		  <option value="http://www2.fi.FreeBSD.org/">Finnland/2</option>
		  <option value="http://www.fr.FreeBSD.org/">Frankreich</option>
		  <option value="http://www.gr.FreeBSD.org/">Griechenland/1</option>
		  <option value="http://www.FreeBSD.gr/">Griechenland/2</option>
		  <option value="http://www.uk.FreeBSD.org/">Gro&#223;britannien/1</option>
		  <option value="http://www2.uk.FreeBSD.org/">Gro&#223;britannien/2</option>
		  <option value="http://www3.uk.FreeBSD.org/">Gro&#223;britannien/3</option>
		  <option value="http://www4.uk.FreeBSD.org/">Gro&#223;britannien/4</option>
		  <option value="http://www1.uk.FreeBSD.org/">Gro&#223;britannien/5</option>
		  <option value="http://www.hk.FreeBSD.org/">Hong Kong</option>
		  <option value="http://www.ie.FreeBSD.org/">Irland/1</option>
		  <option value="http://www2.ie.FreeBSD.org/">Irland/2</option>
		  <option value="http://www.is.FreeBSD.org/">Island</option>
		  <option value="http://www.it.FreeBSD.org/">Italien/1</option>
		  <option value="http://www.gufi.org/mirrors/www.freebsd.org/data/">Italien/2</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">Japan</option>
		  <option value="http://www.ca.FreeBSD.org/">Kanada/1</option>
		  <option value="http://www2.ca.FreeBSD.org/">Kanada/2</option>
		  <option value="http://www.kr.FreeBSD.org/">Korea/1</option>
		  <option value="http://www2.kr.FreeBSD.org/">Korea/2</option>
		  <option value="http://www3.kr.FreeBSD.org/">Korea/3</option>
		  <option value="http://www.lv.FreeBSD.org/">Lettland</option>
		  <option value="http://www.lt.FreeBSD.org/">Litauen</option>
		  <option value="http://www.nz.FreeBSD.org/">Neuseeland</option>
		  <option value="http://www.nl.FreeBSD.org/">Niederlande/1</option>
		  <option value="http://www2.nl.FreeBSD.org/">Niederlande/2</option>
		  <option value="http://www.no.FreeBSD.org/">Norwegen/1</option>
		  <option value="http://www2.no.FreeBSD.org/">Norwegen/2</option>
		  <option value="http://www.at.FreeBSD.org/">&#214;sterreich/1</option>
		  <option value="http://www2.at.FreeBSD.org/">&#214;sterreich/2</option>
		  <option value="http://www.FreeBSD.org.ph/">Philippinen</option>
		  <option value="http://www.pl.FreeBSD.org/">Polen/1</option>
		  <option value="http://www2.pl.FreeBSD.org/">Polen/2</option>
		  <option value="http://www2.pt.FreeBSD.org/">Portugal/1</option>
		  <option value="http://www4.pt.FreeBSD.org/">Portugal/4</option>
		  <option value="http://www.ro.FreeBSD.org/">Rum&#228;nien/1</option>
		  <option value="http://www2.ro.FreeBSD.org/">Rum&#228;nien/2</option>
		  <option value="http://www3.ro.FreeBSD.org/">Rum&#228;nien/3</option>
		  <option value="http://www4.ro.FreeBSD.org/">Rum&#228;nien/4</option>
		  <option value="http://www.ru.FreeBSD.org/">Russland/1</option>
		  <option value="http://www2.ru.FreeBSD.org/">Russland/2</option>
		  <option value="http://www3.ru.FreeBSD.org/">Russland/3</option>
		  <option value="http://www4.ru.FreeBSD.org/">Russland/4</option>
		  <option value="http://www.sm.FreeBSD.org/">San Marino</option>
		  <option value="http://www.se.FreeBSD.org/">Schweden/1</option>
		  <option value="http://www2.se.FreeBSD.org/">Schweden/2</option>
		  <option value="http://www.ch.FreeBSD.org/">Schweiz/1</option>
		  <option value="http://www2.ch.FreeBSD.org/">Schweiz/2</option>
		  <option value="http://www2.sg.FreeBSD.org/">Singapur</option>
		  <option value="http://www.sk.FreeBSD.org/">Slowakische Republik/1</option>
		  <option value="http://www2.sk.FreeBSD.org/">Slowakische Republik/2</option>
		  <option value="http://www.si.FreeBSD.org/">Slowenien/1</option>
		  <option value="http://www2.si.FreeBSD.org/">Slowenien/2</option>
		  <option value="http://www.es.FreeBSD.org/">Spanien/1</option>
		  <option value="http://www2.es.FreeBSD.org/">Spanien/2</option>
		  <option value="http://www3.es.FreeBSD.org/">Spanien/3</option>
		  <option value="http://www.za.FreeBSD.org/">S&#252;dafrika/1</option>
		  <option value="http://www2.za.FreeBSD.org/">S&#252;dafrika/2</option>
		  <option value="http://www.tw.FreeBSD.org/">Taiwan/1</option>
		  <option value="http://www2.tw.FreeBSD.org/">Taiwan/2</option>
		  <option value="http://www3.tw.FreeBSD.org/">Taiwan/3</option>
		  <option value="http://www4.tw.FreeBSD.org/">Taiwan/4</option>
		  <option value="http://www.cz.FreeBSD.org/">Tschechische Republik</option>
		  <option value="http://www.tr.FreeBSD.org/">T&#252;rkei/1</option>
		  <option value="http://www2.tr.FreeBSD.org/">T&#252;rkei/2</option>
		  <option value="http://www.enderunix.org/freebsd/">T&#252;rkei/3</option>
		  <option value="http://www.ua.FreeBSD.org/">Ukraine/1</option>
		  <option value="http://www2.ua.FreeBSD.org/">Ukraine/2</option>
		  <option value="http://www5.ua.FreeBSD.org/">Ukraine/3</option>
		  <option value="http://www4.ua.FreeBSD.org/">Ukraine/Krim</option>
		  <option value="http://www.hu.FreeBSD.org/">Ungarn/1</option>
		  <option value="http://www2.hu.FreeBSD.org/">Ungarn/2</option>
		  <option value="http://www2.us.FreeBSD.org/">USA/1</option>
		  <option value="http://www4.us.FreeBSD.org/">USA/2</option>
		  <option value="http://www5.us.FreeBSD.org/">USA/3</option>
		</select>

		<input type="submit" value=" Los "/>

		<br/>

		<font color="#990000"><b>Sprache: </b></font>
		<a href="{$enbase}/index.html">Englisch</a>,
		<a href="{$enbase}/it/index.html">Italienisch</a>,
		<a href="{$enbase}/ja/index.html">Japanisch</a>,
		<a href="{$enbase}/ru/index.html">Russisch</a>,
		<a href="{$enbase}/es/index.html">Spanisch</a>,
		<a href="{$enbase}/support.html#web">andere</a>
	      </form>
	    </td>
	  </tr>
	</table>

	<br/>

	<hr size="1" noshade="noshade"/>

	<!-- Main layout table -->
	<table border="0" cellspacing="0" cellpadding="2">
	  <tr>
	    <td valign="top">
	      <table border="0" cellspacing="0" cellpadding="1"
		     bgcolor="#000000" width="100%">
		<tr>
		  <td>
		    <table cellpadding="4" cellspacing="0" border="0"
			   bgcolor="#ffcc66" width="100%">
		      <tr>
			<td>
			  <p><font size="+1" color="#990000"><b>Neuigkeiten</b></font>


			    <small><br/>
			      &#183; <a href="news/newsflash.html">Ank&#252;ndigungen</a><br/>
			      &#183; <a href="{$enbase}/news/press.html">Aus der Presse</a><br/>
			      &#183; <a href="news/index.html">mehr ...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Software</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/doc/de_DE.ISO8859-1/books/handbook/mirrors.html">FreeBSD Bezugsquellen</a><br/>
			      &#183; <a href="{$base}/releases/index.html">Release Informationen</a><br/>
			      &#183; <a href="{$enbase}/ports/index.html">Anwendungen (Ports)</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Dokumentation</b></font>

			    <small><br/>
			      &#183; <a href="{$enbase}/projects/newbies.html">F&#252;r Einsteiger</a><br/>
			      &#183; <a href="{$enbase}/doc/de_DE.ISO8859-1/books/handbook/index.html">Handbuch</a><br/>
			      &#183; <a href="{$enbase}/doc/de_DE.ISO8859-1/books/faq/index.html">FAQ</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/man.cgi">Manual-Pages</a><br/>
			      &#183; <a href="{$enbase}/docproj/index.html">Doc. Project</a><br/>
			      &#183; <a href="{$enbase}/docs.html">mehr ...</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Hilfe</b></font>

			    <small><br/>
			      &#183; <a href="{$enbase}/support.html#mailing-list">Mailinglisten</a><br/>
			      &#183; <a href="{$enbase}/support.html#newsgroups">Newsgroups</a><br/>
			      &#183; <a href="{$enbase}/support.html#user">User Groups</a><br/>
			      &#183; <a href="{$enbase}/support.html#web">Web Ressourcen</a><br/>
			      &#183; <a href="{$enbase}/security/index.html">Sicherheit</a><br/>
			      &#183; <a href="{$enbase}/support.html">mehr ...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Fehlerberichte</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/send-pr.html">einreichen</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr-summary.cgi">offene</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr.cgi">nach ID suchen</a><br/>
			      &#183; <a href="{$enbase}/support.html#gnats">mehr ...</a><br/>
			    </small></p>


			  <p><font size="+1" color="#990000"><b>Entwicklung</b></font>

			    <small><br/>
			      &#183; <a href="{$enbase}/projects/index.html">Projekte</a><br/>
			      &#183; <a href="{$enbase}/releng/index.html">Release Engineering</a><br/>
			      &#183; <a href="{$enbase}/support.html#cvs">CVS Repository</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b><!-- Kommerzielle -->Anbieter</b></font>

			    <small><br/>
			      &#183; <a href="{$enbase}/commercial/software_bycat.html">Software</a><br/>
			      &#183; <a href="{$enbase}/commercial/hardware.html">Hardware</a><br/>
			      &#183; <a href="{$enbase}/commercial/consulting_bycat.html">Beratung</a><br/>
			      &#183; <a href="{$enbase}/commercial/misc.html">Verschiedenes</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Spenden</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/donations/index.html">Donations Liaison</a><br/>
			      &#183; <a href="{$enbase}/donations/donors.html">gespendet</a><br/>
			      &#183; <a href="{$enbase}/donations/wantlist.html">gesucht</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>&#220;bersicht</b></font>

			    <small><br/>
			      &#183; <a href="{$enbase}/search/index-site.html">Inhalt</a><br/>
			      &#183; <a href="{$enbase}/search/search.html">Suchen</a><br/>
			      &#183; <a href="{$enbase}/internal/index.html">mehr ...</a><br/>
			    </small></p>

			  <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
			    <small>Suche<br/>
			      <input type="text" name="words" size="10"/>
			      <input type="hidden" name="max" value="25"/>
			      <input type="hidden" name="source" value="www"/>
			      <input type="submit" value="Los"/></small>
			  </form></td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>
	    </td>

	    <td></td>

	    <!-- Main body column -->

	    <td align="left" valign="top" rowspan="2">
	      <h2><font color="#990000">Was ist FreeBSD?</font></h2>

	      <p>FreeBSD ist ein modernes Betriebssystem f&#252;r
		Intel kompatible (x86), DEC-Alpha, IA-64, PC-98 und
		UltraSPARC&#174;-Architekturen.  An der Unterst&#252;tzung weiterer
		<a href="{$enbase}/platforms/index.html">Plattformen</a>
		wird gearbeitet.  FreeBSD ist eine Weiterentwicklung von
		BSD, dem <xsl:value-of select="$unix"/>-Betriebssystem der
		University of California, Berkeley.  Das System wird
		von einer <a
		href="{$enbase}/doc/en_US.ISO8859-1/articles/contributors/index.html">gro&#223;en
		Entwicklergruppe</a> gepflegt und erweitert.</p>

	      <h2><font color="#990000">Herausragende Funktionen</font></h2>

	      <p>In den Bereichen Netzwerk, Leistungsf&#228;higkeit,
		Sicherheit und Kompatibilit&#228;t besitzt FreeBSD
		heute schon <a href="{$base}/features.html">Funktionen</a>,
		die in anderen Betriebssystemen, selbst in den besten
		kommerziellen, fehlen.</p>

	      <h2><font color="#990000">Leistungsf&#228;hige
		Internet-Dienste</font></h2>

	      <p>FreeBSD ist bestens geeignet f&#252;r
		<a href="{$base}/internet.html">Internet- oder Intranet-</a>
		Server.  Auch unter h&#246;chsten Lasten arbeiten die
		Netzwerkdienste zuverl&#228;ssig.  Der effiziente Umgang
		mit dem Speicher garantiert schnelle Antwortzeiten
		f&#252;r tausende gleichzeitig laufende Benutzerprozesse.
		Beispiele f&#252;r Anwendungen und Dienste unter
		FreeBSD finden Sie in der
		<a href="{$enbase}/gallery/gallery.html">Galerie</a>.</p>

	      <h2><font color="#990000">Viele Anwendungen</font></h2>

	      <p>Die Qualit&#228;t von FreeBSD zusammen mit preiswerter
		und leistungsf&#228;higer PC-Hardware bietet eine
		wirtschaftliche Alternative zu kommerziellen
		<xsl:value-of select="$unix"/> Workstations.
		Unter FreeBSD laufen viele
		<a href="{$base}/applications.html">Anwendungen</a>;
		das System eignet sich sowohl f&#252;r Arbeitspl&#228;tze
		als auch f&#252;r Server.</p>

	      <h2><font color="#990000">Leicht zu installieren</font></h2>

	      <p>FreeBSD kann von mehreren Medien installiert werden,
		beispielsweise CD-ROM, DVD-ROM, Disketten, Bandlaufwerken
		oder einer MS-DOS&#174; Partition.  Sie k&#246;nnen FreeBSD
		auch <i>direkt</i> mit FTP oder NFS installieren, wenn
		Sie eine Netzwerkverbindung haben.  Dazu brauchen Sie
		zwei 1.44&#160;MB Disketten und
		<a href="{$enbase}/doc/en_US.ISO8859-1/books/handbook/install.html">die
		Installations-Anleitung</a>.</p>

	      <h2><font color="#990000">FreeBSD ist <i>frei</i></font></h2>

	      <a href="{$enbase}/copyright/daemon.html"><img src="{$enbase}/gifs/dae_up3.gif"
						   alt=""
						   height="81" width="72"
						   align="right"
						   border="0"/></a>

	      <p>W&#228;hrend man vermuten k&#246;nnte, dass ein
		Betriebssystem mit diesem Funktionsumfang teuer verkauft
		wird, ist FreeBSD
		<a href="{$enbase}/copyright/index.html">kostenlos</a> und
		bringt den kompletten Quellcode gleich mit.  Wenn
		Sie FreeBSD ausprobieren wollen, finden Sie in
		<a href="{$enbase}/doc/de_DE.ISO8859-1/books/handbook/mirrors.html">Bezugsquellen
		f&#252;r FreeBSD</a> weitere Informationen.</p>

	      <h2><font color="#990000">Mitmachen bei FreeBSD</font></h2>

	      <p>Sie k&#246;nnen leicht zu FreeBSD beitragen.  Suchen
		Sie einfach eine Stelle, die verbessert werden muss.
		Ihre sorgf&#228;ltig und sauber vorgenommenen
		&#196;nderungen k&#246;nnen Sie dem Projekt mit
		send-pr oder &#252;ber einen Committer, wenn Sie
		einen kennen, zukommen lassen.  Es sind viele Beitr&#228;ge
		m&#246;glich:  beispielsweise Dokumentationen,
		Grafiken oder Quellcode.  Einzelheiten entnehmen Sie
		bitte dem Artikel
		<a href="{$enbase}/doc/en_US.ISO8859-1/articles/contributing/index.html">Contributing
		to FreeBSD</a>.</p>

	      <p>Auch wenn Sie kein Programmierer sind, k&#246;nnen
		Sie zu FreeBSD beitragen.  Die FreeBSD&#160;Foundation
		ist eine  gemeinn&#252;tzige Gesellschaft.  Spenden
		an die Gesellschaft k&#246;nnen Sie (zumindest in
		den USA) von der Steuer absetzen.  Weitere Informationen
		erhalten Sie von
		<a href="mailto:bod@FreeBSDFoundation.org">bod@FreeBSDFoundation.org</a>
		oder schreiben Sie an: The&#160;FreeBSD&#160;Foundation,
		7321 Brockway Dr. Boulder, CO 80303.  USA</p>

	      <p>Silicon Breeze vertreibt eine in Metall gegossene
		Skulptur des FreeBSD Daemons.  15% des Erl&#246;ses
		flie&#223;en an die FreeBSD&#160;Foundation
		zur&#252;ck.  Auf der Webseite des <a
		  href="http://www.linuxjewellery.com/beastie/">Linux
		  Jewellery Store</a> k&#246;nnen Sie die Skulptur
		bestellen und dort finden Sie auch weitere
		Informationen.</p>
	    </td>

	    <td></td>

	    <!-- Right-most column -->
	    <td valign="top">
	      <!-- News / release info table -->
	      <table border="0" cellspacing="0" cellpadding="1"
		     bgcolor="#000000" width="100%">
		<tr>
		  <td>
		    <table cellpadding="4" cellspacing="0" border="0"
			   bgcolor="#ffcc66" width="100%">
		      <tr>
			<td valign="top"><p><font size="+1" color="#990000"><b>Neue Technik:
			    <xsl:value-of select="$rel.current"/>-RELEASE</b></font><br/>

			    <small>&#183; <a href="{$u.rel.announce}">Ank&#252;ndigung</a><br/>
			      &#183; <a href="{$enbase}/doc/en_US.ISO8859-1/books/handbook/install.html">Installation</a><br/>
			      &#183; <a href="{$u.rel.notes}">Release Notes</a><br/>
			      &#183; <a href="{$u.rel.hardware}">Hardware Notes</a><br/>
			      &#183; <a href="{$u.rel.errata}">Errata</a><br/>
			      &#183; <a href="{$u.rel.early}">Early Adopter's Guide</a></small></p>

			  <p><font size="+1" color="#990000"><b>Produktionsreife:
			    <xsl:value-of select="$rel2.current"/>-RELEASE</b></font><br/>

			    <small>&#183; <a href="{$u.rel2.announce}">Ank&#252;ndigung</a><br/>
			      &#183; <a href="{$enbase}/doc/en_US.ISO8859-1/books/handbook/install.html">Installation</a><br/>
			      &#183; <a href="{$u.rel2.notes}">Release Notes</a><br/>
			      &#183; <a href="{$u.rel2.hardware}">Hardware Notes</a><br/>
			      &#183; <a href="{$u.rel2.errata}">Errata</a></small></p>

			  <p><font size="+1" color="#990000"><b>Ank&#252;ndigungen</b></font><br/>
			    <font size="-1">
			      aktualisiert am:
			      <xsl:value-of
				select="descendant::day[position() = 1]/name"/>
			      <xsl:text>. </xsl:text>
			      <xsl:value-of
				select="descendant::month[position() = 1]/name"/>
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="descendant::year[position() = 1]/name"/>
			      <br/>
			      <!-- Pull in the 10 most recent news items -->
			      <xsl:for-each select="descendant::event[position() &lt;= 10]">
				&#183;  <a>
				  <xsl:attribute name="href">
				    news/newsflash.html#<xsl:call-template name="generate-event-anchor"/>
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
			      <a href="news/newsflash.html">mehr ...</a>
			    </font></p>

			  <!--
			  <p><font size="+1" color="#990000"><b>Aus der Presse</b></font><br/>

			    <font size="-1">
			      aktualisiert im:
			      <xsl:value-of
				select="document('news/press.xml')/descendant::month[position() = 1]/name"/>
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="document('news/press.xml')/descendant::year[position() = 1]/name"/>
			      <br/>
			      -->
			      <!-- Pull in the 10 most recent press items -->
			      <!--
			      <xsl:for-each select="document('news/press.xml')/descendant::story[position() &lt; 10]">
				&#183; <a>
				  <xsl:attribute name="href">
				    news/press.html#<xsl:call-template name="generate-story-anchor"/>
				  </xsl:attribute>
				  <xsl:value-of select="name"/>
				</a><br/>
			      </xsl:for-each>
			      <a href="news/press.html">mehr ...</a>
			    </font>
			  </p>
			  -->

			  <p><font size="+1" color="#990000"><b>Sicherheits-Hinweise</b></font><br/>

			    <font size="-1">
			      aktualisiert am:
			      <xsl:value-of
				select="document('security/advisories.xml')/descendant::day[position() = 1]/name"/>
			      <xsl:text>. </xsl:text>
			      <xsl:value-of
				select="document('security/advisories.xml')/descendant::month[position() = 1]/name"/>
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="document('security/advisories.xml')/descendant::year[position() = 1]/name"/>
			      <br/>
			      <!-- Pull in the 10 most recent security advisories -->
			      <xsl:for-each select="document('security/advisories.xml')/descendant::advisory[position() &lt; 10]">
				&#183; <a>
				  <xsl:attribute name="href">ftp://ftp.freebsd.org/pub/FreeBSD/CERT/advisories/<xsl:value-of select="name"/>.asc</xsl:attribute>
				  <xsl:value-of select="name"/>
				</a><br/>
			      </xsl:for-each>
			      <a href="{$enbase}/security/">mehr ...</a>
			    </font>
			  </p>
			</td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>

	      <p>&#xa0;</p>

	      <table border="0" cellspacing="0" cellpadding="1"
		     bgcolor="#000000" width="100%">
		<tr>
		  <td>
		    <table cellpadding="4" cellspacing="0" border="0"
			   bgcolor="#FFFFFF" width="100%"><tr>
			<td>Mehr &#252;ber FreeBSD erfahren Sie aus
			  <a href="{$enbase}/publish.html">Ver&#246;ffentlichungen</a>
			  oder <a href="{$enbase}/news/press.html">aus der
			  Presse</a> und nat&#252;rlich auf dieser
			  Webseite!</td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>
	    </td>
	  </tr>
	</table>

	<!-- compatibility links to old German site -->
	<hr noshade="noshade" size="1" />

	<table width="100%" border="0" cellspacing="0" cellpadding="3">
	  <tr>
	    <td><a href="{$debase}/cdrom.html">CD-ROM</a></td>
	    <td><a href="{$debase}/mailinglists.html">Mailinglisten</a></td>
	    <td><a href="{$debase}/mirror.html">Spiegel</a></td>
	    <td><a href="{$debase}/doc.html">Dokumentation</a></td>
	    <td><a href="{$debase}/people.html">Menschen</a></td>
	    <td><a href="{$debase}/misc.html">Verschiedenes</a></td>
	  </tr>
	</table>
	<!-- end of compatibility links to old German site -->

	<hr noshade="noshade" size="1" />

	<table width="100%" border="0" cellspacing="0" cellpadding="3">
	  <tr>
	    <td><a href="http://www.freebsdmall.com/"><img
							   src="{$enbase}/gifs/mall_title_medium.gif" alt="[FreeBSD Mall]"
							   height="65" width="165" border="0"/></a></td>

	    <td><a href="http://www.ugu.com/"><img src="{$enbase}/gifs/ugu_icon.gif"
						   alt="[Sponsor of Unix Guru Universe]"
						   height="64" width="76"
						   border="0"/></a></td>

	    <td><a href="http://www.daemonnews.org/"><img src="{$enbase}/gifs/darbylogo.gif"
		alt="[Daemon News]" height="45" width="130"
		border="0"/></a></td>

	    <td><a href="{$enbase}/copyright/daemon.html"><img
							     src="{$enbase}/gifs/powerlogo.gif"
							     alt="[Powered by FreeBSD]"
							     height="64"
							     width="160"
							     border="0"/></a></td>
	  </tr>
	</table>

	<table width="100%" cellpadding="0" border="0" cellspacing="0">
	  <tr>
	    <td align="left"
		valign="top"><small><a href="{$base}/mailto.html">Schreiben
		  Sie uns</a><br/>
		<xsl:value-of select="$date"/></small></td>

	    <td align="right"
		valign="top"><small><a href="copyright/index.html">Legal</a> &#169; 1995-2003
		The FreeBSD Project.<br/>
		All rights reserved.</small></td>
	  </tr>
	</table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

<!--
     Local Variables:
     mode: xml
     sgml-indent-data: t
     sgml-omittag: nil
     sgml-always-quote-attributes: t
     End:
-->
