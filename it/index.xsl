<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/it/index.xsl,v 1.3 2003/04/05 14:53:54 trhodes Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="includes.xsl"/>
  <xsl:import href="../en/news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="enbase" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/it/index.xsl,v 1.3 2003/04/05 14:53:54 trhodes Exp $'"/>
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
      </head>

      <body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#840084"
	    alink="#0000FF">

	<table border="0" cellspacing="0" cellpadding="0" width="100%">
	  <tr>
	    <td><a href="http://www.FreeBSD.org/it/index.html">
		<img src="{$enbase}/gifs/freebsd_1.gif" height="94" width="306"
		     alt="FreeBSD: The Power to Serve" border="0"/></a></td>

	    <td align="right" valign="bottom">
	      <form action="http://www.FreeBSD.org/cgi/mirror.cgi"
		    method="get">

		<br/>

		<font color="#990000"><b>Seleziona un server vicino a te:</b></font>

		<br/>

		<select name="goto">
		  <option value="http://www2.at.FreeBSD.org/">IPv6 Austria</option>
		  <option value="http://www.dk.FreeBSD.org/">IPv6 Danimarca</option>
		  <option value="http://www2.de.FreeBSD.org">IPv6 Germania</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">IPv6 (6Bone) Giappone</option>
		  <option value="http://www2.no.FreeBSD.org/">IPv6 Norvegia</option>
		  <option value="http://www.ar.FreeBSD.org/">Argentina</option>
		  <option value="http://www.au.FreeBSD.org/">Australia/1</option>
		  <option value="http://www2.au.FreeBSD.org/">Australia/2</option>
		  <option value="http://www3.au.FreeBSD.org/">Australia/3</option>
		  <option value="http://www4.au.FreeBSD.org/">Australia/4</option>
		  <option value="http://www5.au.FreeBSD.org/">Australia/5</option>
		  <option value="http://www6.au.FreeBSD.org/">Australia/6</option>
		  <option value="http://freebsd.itworks.com.au/">Australia/8</option>
		  <option value="http://www.at.FreeBSD.org/">Austria/1</option>
		  <option value="http://www2.at.FreeBSD.org/">Austria/2</option>
		  <option value="http://freebsd.unixtech.be/">Belgio</option>
		  <option value="http://www.br.FreeBSD.org/www.freebsd.org/">Brasile/1</option>
		  <option value="http://www2.br.FreeBSD.org/www.freebsd.org/">Brasile/2</option>
		  <option value="http://www3.br.FreeBSD.org/">Brasile/3</option>
		  <option value="http://www.bg.FreeBSD.org/">Bulgaria</option>
		  <option value="http://www.ca.FreeBSD.org/">Canada/1</option>
		  <option value="http://www2.ca.FreeBSD.org/">Canada/2</option>
		  <option value="http://www.cn.FreeBSD.org/">Cina</option>
		  <option value="http://www.kr.FreeBSD.org/">Corea</option>
		  <option value="http://www2.kr.FreeBSD.org/">Corea/2</option>
		  <option value="http://www3.kr.FreeBSD.org/">Corea/3</option>
		  <option value="http://www.dk.FreeBSD.org/">Danimarca/1</option>
		  <option value="http://www3.dk.FreeBSD.org/">Danimarca/3</option>
		  <option value="http://www.ee.FreeBSD.org/">Estonia</option>
		  <option value="http://www.FreeBSD.org.ph/">Filippine</option>
		  <option value="http://www.fi.FreeBSD.org/">Finlandia/1</option>
		  <option value="http://www2.fi.FreeBSD.org/">Finlandia/2</option>
		  <option value="http://www.fr.FreeBSD.org/">Francia</option>
		  <option value="http://www.de.FreeBSD.org/">Germania/1</option>
		  <option value="http://www1.de.FreeBSD.org/">Germania/2</option>
		  <option value="http://www2.de.FreeBSD.org/">Germania/3</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">Giappone</option>
		  <option value="http://www.gr.FreeBSD.org/">Grecia</option>
		  <option value="http://www.hk.FreeBSD.org/">Hong Kong</option>
		  <option value="http://www.ie.FreeBSD.org/">Irlanda/1</option>
		  <option value="http://www2.ie.FreeBSD.org/">Irlanda/2</option>
		  <option value="http://www.is.FreeBSD.org/">Islanda</option>
		  <option value="http://www.it.FreeBSD.org/">Italia/1</option>
		  <option value="http://www.gufi.org/mirrors/www.freebsd.org/data/">Italia/2</option>
		  <option value="http://www.lv.FreeBSD.org/">Lettonia</option>
		  <option value="http://www.lt.FreeBSD.org/">Lituania</option>
		  <option value="http://www.no.FreeBSD.org/">Norvegia/1</option>
		  <option value="http://www2.no.FreeBSD.org/">Norvegia/2</option>
		  <option value="http://www.nz.FreeBSD.org/">Nuova Zelanda</option>
		  <option value="http://www.nl.FreeBSD.org/">Olanda/1</option>
		  <option value="http://www2.nl.FreeBSD.org/">Olanda/2</option>
		  <option value="http://www.pl.FreeBSD.org/">Polonia/1</option>
		  <option value="http://www2.pl.FreeBSD.org/">Polonia/2</option>
		  <option value="http://www2.pt.FreeBSD.org/">Portogallo/2</option>
		  <option value="http://www4.pt.FreeBSD.org/">Portogallo/4</option>
		  <option value="http://www.uk.FreeBSD.org/">Regno Unito/1</option>
		  <option value="http://www2.uk.FreeBSD.org/">Regno Unito/2</option>
		  <option value="http://www3.uk.FreeBSD.org/">Regno Unito/3</option>
		  <option value="http://www4.uk.FreeBSD.org/">Regno Unito/4</option>
		  <option value="http://www.cz.FreeBSD.org/">Repubblica Ceca</option>
		  <option value="http://www.sk.FreeBSD.org/">Repubblica Slovacca/1</option>
		  <option value="http://www2.sk.FreeBSD.org/">Repubblica Slovacca/2</option>
		  <option value="http://www.ro.FreeBSD.org/">Romania</option>
		  <option value="http://www2.ro.FreeBSD.org/">Romania/2</option>
		  <option value="http://www3.ro.FreeBSD.org/">Romania/3</option>
		  <option value="http://www4.ro.FreeBSD.org/">Romania/4</option>
		  <option value="http://www.ru.FreeBSD.org/">Russia/1</option>
		  <option value="http://www2.ru.FreeBSD.org/">Russia/2</option>
		  <option value="http://www3.ru.FreeBSD.org/">Russia/3</option>
		  <option value="http://www4.ru.FreeBSD.org/">Russia/4</option>
		  <option value="http://www.sm.FreeBSD.org/">San Marino</option>
		  <option value="http://www2.sg.FreeBSD.org/">Singapore</option>
		  <option value="http://www.si.FreeBSD.org/">Slovenia/1</option>
		  <option value="http://www2.si.FreeBSD.org/">Slovenia/2</option>
		  <option value="http://www.es.FreeBSD.org/">Spagna/1</option>
		  <option value="http://www2.es.FreeBSD.org/">Spagna/2</option>
		  <option value="http://www3.es.FreeBSD.org/">Spagna/3</option>
		  <option value="http://www.za.FreeBSD.org/">Sud Africa/1</option>
		  <option value="http://www2.za.FreeBSD.org/">Sud Africa/2</option>
		  <option value="http://www.se.FreeBSD.org/">Svezia/1</option>
		  <option value="http://www2.se.FreeBSD.org/">Svezia/2</option>
		  <option value="http://www.ch.FreeBSD.org/">Svizzera/1</option>
		  <option value="http://www2.ch.FreeBSD.org/">Svizzera/2</option>
		  <option value="http://www.tw.FreeBSD.org/">Taiwan/1</option>
		  <option value="http://www2.tw.FreeBSD.org/">Taiwan/2</option>
		  <option value="http://www3.tw.FreeBSD.org/">Taiwan/3</option>
		  <option value="http://www4.tw.FreeBSD.org/">Taiwan/4</option>
		  <option value="http://www.tr.FreeBSD.org/">Turchia/1</option>
		  <option value="http://www2.tr.FreeBSD.org/">Turchia/2</option>
		  <option value="http://www.enderunix.org/freebsd/">Turchia/3</option>
		  <option value="http://www.ua.FreeBSD.org/">Ucraina/1</option>
		  <option value="http://www2.ua.FreeBSD.org/">Ucraina/2</option>
		  <option value="http://www4.ua.FreeBSD.org/">Ucraina/Crimea</option>
		  <option value="http://www5.ua.FreeBSD.org/">Ucraina/5</option>
		  <option value="http://www.hu.FreeBSD.org/">Ungheria/1</option>
		  <option value="http://www2.hu.FreeBSD.org/">Ungheria/2</option>
		  <option value="http://www.FreeBSD.org/">USA/California</option>
		  <option value="http://www3.FreeBSD.org/">USA/3</option>
		  <option value="http://www7.FreeBSD.org/">USA/7</option>
		</select>

		<input type="submit" value=" Vai "/>

		<br/>

		<font color="#990000"><b>Lingua: </b></font>
		<a href="{$enbase}/index.html">Inglese</a>,
		<a href="{$enbase}/ja/index.html">Giapponese</a>,
		<a href="{$enbase}/ru/index.html">Russo</a>,
		<a href="{$enbase}/es/index.html">Spagnolo</a>,
		<a href="{$enbase}/support.html#web">Altro</a>
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
			  <p><font size="+1" color="#990000"><b>Novità</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/news/newsflash.html">Annunci</a><br/>
			      &#183; <a href="{$enbase}/news/press.html">Sulla Stampa</a><br/>
			      &#183; <a href="{$enbase}/news/index.html">Altro...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Software</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/doc/it_IT.ISO8859-15/books/handbook/mirrors.html">Ottenere FreeBSD</a><br/>
			      &#183; <a href="{$enbase}/releases/index.html">Info sulle Release</a><br/>
			      &#183; <a href="{$enbase}/ports/index.html">Applicazioni Portate</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Documentazione</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/projects/newbies.html">Per i Niubbi</a><br/>
			      &#183; <a href="{$enbase}/doc/it_IT.ISO8859-15/books/handbook/index.html">Manuale</a><br/>
			      &#183; <a href="{$enbase}/doc/en_US.ISO8859-1/books/faq/index.html">FAQ</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/man.cgi">Pagine man</a><br/>
			      &#183; <a href="{$enbase}/docproj/index.html">Doc. Project</a><br/>
			      &#183; <a href="docs.html">Altro...</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Supporto</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/support.html#mailing-list">Mailing list</a><br/>
			      &#183; <a href="{$enbase}/support.html#newsgroups">Newsgroup</a><br/>
			      &#183; <a href="{$enbase}/support.html#user">Gruppi Utenti</a><br/>
			      &#183; <a href="{$enbase}/support.html#web">Risorse Web</a><br/>
			      &#183; <a href="{$enbase}/security/index.html">Sicurezza</a><br/>
			      &#183; <a href="{$enbase}/support.html">Altro...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Bug Report</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/send-pr.html">Invia un bug report</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr-summary.cgi">Visualizza i report</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr.cgi">Cerca tramite bug ID</a><br/>
			      &#183; <a href="{$enbase}/support.html#gnats">Altro...</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Sviluppo</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/projects/index.html">Progetti</a><br/>
			      &#183; <a href="{$enbase}/releng/index.html">Release Engineering</a><br/>
			      &#183; <a href="{$enbase}/support.html#cvs">Repository CVS</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Fornitori</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/commercial/software_bycat.html">Software</a><br/>
			      &#183; <a href="{$enbase}/commercial/hardware.html">Hardware</a><br/>
			      &#183; <a href="{$enbase}/commercial/consulting_bycat.html">Consulenza</a><br/>
			      &#183; <a href="{$enbase}/commercial/misc.html">Varie</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Donazioni</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/donations/index.html">Info sul Progetto</a><br/>
			      &#183; <a href="{$enbase}/donations/donors.html">Attuali Donazioni</a><br/>
			      &#183; <a href="{$enbase}/donations/wantlist.html">Elenco delle richieste</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Questo Sito</b></font>
			    <small><br/>
			      &#183; <a href="{$enbase}/search/index-site.html">Mappa del Sito</a><br/>
			      &#183; <a href="{$enbase}/search/search.html">Cerca</a><br/>
			      &#183; <a href="{$enbase}/internal/index.html">Altro...</a><br/>
			    </small></p>

			  <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
			    <small>Cerca:<br/>
			      <input type="text" name="words" size="10"/>
			      <input type="hidden" name="max" value="25"/>
			      <input type="hidden" name="source" value="www"/>
			      <input type="submit" value="Vai"/></small>
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
	      <h2><font color="#990000">Cos'è FreeBSD?</font></h2>

	      <p>FreeBSD è un sistema operativo avanzato per architetture
		compatibili x86, DEC Alpha, IA-64, PC-98 e UltraSPARC.
		È derivato da BSD, la versione di
		<xsl:value-of select="$unix"/> sviluppata
		all'Università della California, Berkeley.
		È sviluppato e mantenuto da <a
		  href="{$enbase}/doc/en_US.ISO8859-1/articles/contributors/index.html">un
		grande gruppo di individui</a>.
		<a href="{$enbase}/platforms/index.html">Piattaforme</a>
		aggiuntive sono in varie fasi di sviluppo.</p>

	      <h2><font color="#990000">Funzionalità avanzate</font></h2>

	      <p>FreeBSD offre <a href="{$enbase}/features.html">funzionalità</a>
	        di networking avanzato, prestazioni, sicurezza e compatibilità
	        che ad oggi mancano ancora in altri sistemi operativi, anche in
	        alcuni di quelli commerciali.</p>

	      <h2><font color="#990000">Soluzioni Internet potenti</font></h2>

	      <p>FreeBSD è ideale per un server
		<a href="{$enbase}/internet.html">Internet o Intranet</a>.
		Fornisce servizi di rete robusti sotto i carichi più pesanti e
		usa la memoria in maniera efficente per mantenere buoni tempi di
		risposta per migliaia di processi utente simultanei.  Visita la
		nostra <a href="{$enbase}/gallery/gallery.html">galleria</a> per
		esempi di applicazioni e servizi potenziati da FreeBSD.</p>

	      <h2><font color="#990000">Esegue un numero enorme di
		  applicazioni</font></h2>

	      <p>La qualità di FreeBSD combinata con l'attuale hardware per PC a
	        basso prezzo e ad alta velocità rende FreeBSD un'alternativa
	        molto economica alle workstation <xsl:value-of select="$unix"/>
	        commerciali.  Si adatta molto bene a un gran numero di <a
	          href="{$enbase}/applications.html">applicazioni</a> sia
	        desktop che server.</p>

	      <h2><font color="#990000">Facile da installare</font></h2>

	      <p>FreeBSD può essere installato da una varietà di supporti,
	        inclusi CD-ROM, DVD-ROM, floppy disk, nastri magnetici,
	        partizioni MS-DOS&#174;, o, se hai una connessione di rete, puoi
	        installarlo <i>direttamente</i> tramite FTP anonimo o NFS.
	        Tutto quello di cui hai bisogno è un paio di dischetti vuoti da
	        1.44MB e <a
	          href="{$enbase}/doc/it_IT.ISO8859-15/books/handbook/install.html">queste
		  istruzioni</a>.</p>

	      <h2><font color="#990000">FreeBSD è <i>libero</i></font></h2>

	      <a href="copyright/daemon.html"><img src="{$enbase}/gifs/dae_up3.gif"
						   alt=""
						   height="81" width="72"
						   align="right"
						   border="0"/></a>

	      <p>Sebbene tu possa aspettarti che un sistema operativo con queste
	        caratteristiche venga venduto ad alto prezzo, FreeBSD è
	        disponibile <a
	          href="{$enbase}/copyright/index.html">gratuitamente</a> e
		viene fornito con il codice sorgente completo.  Se vuoi
		provarlo, <a
		  href="{$enbase}/doc/it_IT.ISO8859-15/books/handbook/mirrors.html">sono
		  disponibili maggiori informazioni</a>.</p>

	      <h2><font color="#990000">Contribuire a FreeBSD</font></h2>

	      <p>È facile contribuire a FreeBSD.  Tutto quello che devi fare è
	        trovare una parte di FreeBSD che pensi possa essere migliorata,
	        fare le modifiche (in modo attento e pulito) e reinviarle al
	        Progetto, tramite send-pr o a un committer, se ne conosci uno.
		Può essere qualsiasi cosa, dalla documentazione alla grafica al
		codice sorgente.  Guarda l'articolo <a
		  href="{$enbase}/doc/en_US.ISO8859-1/articles/contributing/index.html">Contributing
		to FreeBSD</a> per maggiori informazioni.</p>

	      <p>Anche se non sei un programmatore, ci sono altri modi per
 		contribuire a FreeBSD.  La FreeBSD Foundation è
 		un'organizzazione no-profit, percui i contributi diretti sono
 		completamente deducibili dalle tasse.  Contatta	<a
 		  href="mailto:bod@FreeBSDFoundation.org">bod@FreeBSDFoundation.org</a>
		per maggiori informazioni o scrivi a: The FreeBSD Foundation,
		7321 Brockway Dr. Boulder, CO 80303.  USA</p>

	      <p>La Silicon Breeze ha inoltre scolpito e fuso il Demone BSD in
		metallo e sta donando il 15% di tutti i proventi di queste
		statuette alla FreeBSD Foundation.  La storia completa e le
		informazioni su come ordinare il Demone BSD sono disponibili a
 		<a href="http://www.linuxjewellery.com/beastie/">questa
 		  pagina</a>.</p>
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
			<td valign="top"><p><font size="+1" color="#990000"><b>Release con Nuove Tecnologie:
			    <xsl:value-of select="$rel.current"/></b></font><br/>

			    <small>&#183; <a href="{$u.rel.announce}">Annuncio</a><br/>
			      &#183; <a href="{$enbase}/doc/it_IT.ISO8859-15/books/handbook/install.html">Guida di Installazione</a><br/>
			      &#183; <a href="{$u.rel.notes}">Note sulla Release</a><br/>
			      &#183; <a href="{$u.rel.hardware}">Note sull'Hardware</a><br/>
			      &#183; <a href="{$u.rel.errata}">Errata</a><br/>
			      &#183; <a href="{$u.rel.early}">Early Adopter's Guide</a></small></p>

			  <p><font size="+1" color="#990000"><b>Release di Produzione:
			    <xsl:value-of select="$rel2.current"/></b></font><br/>
			
			    <small>&#183; <a href="{$u.rel2.announce}">Annuncio</a><br/>
			      &#183; <a href="{$enbase}/doc/it_IT.ISO8859-15/books/handbook/install.html">Guida di Installazione</a><br/>
			      &#183; <a href="{$u.rel2.notes}">Note sulla Release</a><br/>
			      &#183; <a href="{$u.rel2.hardware}">Note sull'Hardware</a><br/>
			      &#183; <a href="{$u.rel2.errata}">Errata</a></small></p>

			  <p><font size="+1" color="#990000"><b>Novità sul Progetto</b></font><br/>
			    <font size="-1">
			      Ultimo aggiornamento:
			      <xsl:value-of
				select="descendant::day[position() = 1]/name"/>
			      <xsl:text> </xsl:text>
			      <xsl:call-template name="translate-month">
				<xsl:with-param name="month"
				  select="descendant::month[position() = 1]/name"/>
			      </xsl:call-template>
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="descendant::year[position() = 1]/name"/>
			      <br/>
			      <!-- Pull in the 10 most recent news items -->
			      <xsl:for-each select="descendant::event[position() &lt;= 10]">
				&#183;  <a>
				  <xsl:attribute name="href">
				    <xsl:value-of select="$enbase"/>/news/newsflash.html#<xsl:call-template name="generate-event-anchor"/>
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
			      <a href="{$enbase}/news/newsflash.html">Altro...</a>
			    </font></p>

			  <p><font size="+1" color="#990000"><b>Stampa FreeBSD</b></font><br/>

			    <font size="-1">
			      Ultimo aggiornamento:
			      <xsl:call-template name="translate-month">
				<xsl:with-param name="month"
				  select="document('../en/news/press.xml')/descendant::month[position() = 1]/name"/>
			      </xsl:call-template>
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="document('../en/news/press.xml')/descendant::year[position() = 1]/name"/>
			      <br/>
			      <!-- Pull in the 10 most recent press items -->
			      <xsl:for-each select="document('../en/news/press.xml')/descendant::story[position() &lt; 10]">
				&#183; <a>
				  <xsl:attribute name="href">
				    <xsl:value-of select="$enbase"/>/news/press.html#<xsl:call-template name="generate-story-anchor"/>
				  </xsl:attribute>
				  <xsl:value-of select="name"/>
				</a><br/>
			      </xsl:for-each>
			      <a href="{$enbase}/news/press.html">Altro...</a>
			    </font>
			  </p>

			  <p><font size="+1" color="#990000"><b>Avvisi di Sicurezza</b></font><br/>

			    <font size="-1">
			      Ultimo Aggiornamento:
			      <xsl:value-of
				select="document('../en/security/advisories.xml')/descendant::day[position() = 1]/name"/>
			      <xsl:text> </xsl:text>
			      <xsl:call-template name="translate-month">
				<xsl:with-param name="month"
				  select="document('../en/security/advisories.xml')/descendant::month[position() = 1]/name"/>
			      </xsl:call-template>
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="document('../en/security/advisories.xml')/descendant::year[position() = 1]/name"/>
			      <br/>
			      <!-- Pull in the 10 most recent security advisories -->
			      <xsl:for-each select="document('../en/security/advisories.xml')/descendant::advisory[position() &lt; 10]">
				&#183; <a>
				  <xsl:attribute name="href">ftp://ftp.freebsd.org/pub/FreeBSD/CERT/advisories/<xsl:value-of select="name"/>.asc</xsl:attribute>
				  <xsl:value-of select="name"/>
				</a><br/>
			      </xsl:for-each>
			      <a href="{$enbase}/security/index.html">Altro...</a>
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
			<td>Per saperne di più su FreeBSD, visita la nostra
			  galleria di <a
			    href="{$enbase}/publish.html">pubblicazioni</a>
			  relative a FreeBSD o <a
			    href="{$enbase}/news/press.html">FreeBSD sulla stampa</a>,
			  e naviga all'interno di questo sito!</td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>
	    </td>
	  </tr>
	</table>

	<hr noshade="noshade" size="1" />

	<table width="100%" border="0" cellspacing="0" cellpadding="3">
	  <tr>
	    <td><a href="http://www.freebsdmall.com/"><img src="{$enbase}/gifs/mall_title_medium.gif" alt="[FreeBSD Mall]"
							   height="65" width="165" border="0"/></a></td>

	    <td><a href="http://www.ugu.com/"><img src="{$enbase}/gifs/ugu_icon.gif"
						   alt="[Sponsor del Unix Guru Universe]"
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

	<p><small>I cambiamenti a questo sito web vanno on-line alle 8:00 e alle
	    20:00 UTC di ogni giorno.</small></p>

	<table width="100%" cellpadding="0" border="0" cellspacing="0">
	  <tr>
	    <td align="left"
		valign="top"><small><a href="{$base}/mailto.html">Contattaci</a><br/>
		<xsl:value-of select="$date"/></small></td>

	    <td align="right"
		valign="top"><small><a href="{$enbase}/copyright/index.html">Note legali</a> &#169; 1995-2003
		The FreeBSD Project.<br/>
		Tutti i diritti riservati.</small></td>
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
