<!-- $FreeBSD: www/fr/index.xsl,v 1.4 2003/07/14 16:52:49 stephane Exp $ -->

<!-- 
   The FreeBSD French Documentation Project
   Original revision: 1.66
   
   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/fr/index.xsl,v 1.4 2003/07/14 16:52:49 stephane Exp $'"/>
  <xsl:variable name="title" select="'Le Projet FreeBSD'"/>

  <xsl:output type="html" encoding="iso-8859-1"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="$title"/></title>

	<meta name="description" content="Le Projet FreeBSD"/>

	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Galerie,
	      Version, Application, Logiciel, Manuel de R&#233;f&#233;rence, FAQ, Guides, Bugs,
	      CVS, CVSup, Nouvelles, Revendeurs, homepage, CTM, Unix"/>
      </head>

      <body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#840084"
	    alink="#0000FF">

	<table border="0" cellspacing="0" cellpadding="0" width="100%">
	  <tr>
	    <td><a href="http://www.FreeBSD.org/index.html">
		<img src="gifs/freebsd_1.gif" height="94" width="306"
		     alt="FreeBSD : Le Pouvoir de Servir" border="0"/></a></td>

	    <td align="right" valign="bottom">
	      <form action="http://www.FreeBSD.org/cgi/mirror.cgi"
		    method="get">

		<br/>

		<font color="#990000"><b>Choisissez un serveur proche de chez vous :</b></font>

		<br/>

		<select name="goto">
		  <!--  Only list TRUE mirrrors here! Native language pages
		        which are not mirrored should be listed in
		        support.sgml.  -->
        <option value="http://www2.at.FreeBSD.org/">Autriche IPv6</option>
        <option value="http://www.dk.FreeBSD.org/">Danemark IPv6</option>
        <option value="http://www2.de.FreeBSD.org">Allemagne IPv6</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">Japon IPv6 (6Bone)</option>
        <option value="http://www2.no.FreeBSD.org/">Norv&#232;ge IPv6</option>
        <option value="http://www.ar.FreeBSD.org/">Argentine</option>
		  <option value="http://www.au.FreeBSD.org/">Australie/1</option>
        <option value="http://www2.au.FreeBSD.org/">Australie/2</option>
		  <option value="http://www3.au.FreeBSD.org/">Australie/3</option>
		  <option value="http://www4.au.FreeBSD.org/">Australie/4</option>
		  <option value="http://www5.au.FreeBSD.org/">Australie/5</option>
		  <option value="http://www6.au.FreeBSD.org/">Australie/6</option>
        <option value="http://freebsd.itworks.com.au/">Australie/8</option>
        <option value="http://www.at.FreeBSD.org/">Autriche/1</option>
		  <option value="http://www2.at.FreeBSD.org/">Autriche/2</option>
		  <option value="http://freebsd.unixtech.be/">Belgique</option>
		  <option value="http://www.br.FreeBSD.org/www.freebsd.org/">Br&#233;sil/1</option>
		  <option value="http://www2.br.FreeBSD.org/www.freebsd.org/">Br&#233;sil/2</option>
		  <option value="http://www3.br.FreeBSD.org/">Br&#233;sil/3</option>
		  <option value="http://www.bg.FreeBSD.org/">Bulgarie</option>
		  <option value="http://www.ca.FreeBSD.org/">Canada</option>
		  <option value="http://www2.ca.FreeBSD.org/">Canada/2</option>
		  <!--
		  <option value="http://www3.ca.FreeBSD.org/">Canada/3</option>
		  -->
		  <option value="http://www.cn.FreeBSD.org/">Chine</option>
		  <option value="http://www.cz.FreeBSD.org/">R&#233;publique Tch&#232;que</option>
		  <option value="http://www.dk.FreeBSD.org/">Danemark/1</option>
        <option value="http://www3.dk.FreeBSD.org/">Danemark/3</option>
		  <option value="http://www.ee.FreeBSD.org/">Estonie</option>
		  <option value="http://www.fi.FreeBSD.org/">Finlande</option>
        <option value="http://www2.fi.FreeBSD.org/">Finlande/2</option>
		  <option value="http://www.fr.FreeBSD.org/">France</option>
		  <option value="http://www.de.FreeBSD.org/">Allemagne/1</option>
		  <option value="http://www1.de.FreeBSD.org/">Allemagne/2</option>
		  <option value="http://www2.de.FreeBSD.org/">Allemagne/3</option>
		  <option value="http://www.gr.FreeBSD.org/">Gr&#232;ce</option>
        <option value="http://www.hk.FreeBSD.org/">Hong-Kong</option>
		  <option value="http://www.hu.FreeBSD.org/">Hongrie/1</option>
        <option value="http://www2.hu.FreeBSD.org/">Hongrie/2</option>
        <option value="http://www.is.FreeBSD.org/">Islande</option>
		  <option value="http://www.ie.FreeBSD.org/">Irelande/1</option>
		  <option value="http://www2.ie.FreeBSD.org/">Irelande/2</option>
		  <option value="http://www.it.FreeBSD.org/">Italie/1</option>
		  <option value="http://www.gufi.org/mirrors/www.freebsd.org/data/">Italie/2</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">Japon</option>
		  <option value="http://www.kr.FreeBSD.org/">Cor&#233;e</option>
		  <option value="http://www2.kr.FreeBSD.org/">Cor&#233;e/2</option>
        <option value="http://www3.kr.FreeBSD.org/">Cor&#233;e/3</option>
		  <option value="http://www.lv.FreeBSD.org/">Lettonie</option>
		  <option value="http://www.lt.FreeBSD.org/">Lituanie</option>
		  <option value="http://www.nl.FreeBSD.org/">Pays-Bas/1</option>
		  <option value="http://www2.nl.FreeBSD.org/">Pays-Bas/2</option>
		  <option value="http://www.nz.FreeBSD.org/">Nouvelle-Z&#233;lande</option>
		  <option value="http://www.no.FreeBSD.org/">Norv&#232;ge/1</option>
        <option value="http://www2.no.FreeBSD.org/">Norv&#232;ge/2</option>
        <option value="http://www.FreeBSD.org.ph/">Philippines</option>
		  <option value="http://www.pl.FreeBSD.org/">Pologne/1</option>
		  <option value="http://www2.pl.FreeBSD.org/">Pologne/2</option>
        <!--
		  <option value="http://www.pt.FreeBSD.org/">Portugal/1</option>
        -->
		  <option value="http://www2.pt.FreeBSD.org/">Portugal/2</option>
        <option value="http://www4.pt.FreeBSD.org/">Portugal/4</option>
		  <option value="http://www.ro.FreeBSD.org/">Roumanie</option>
        <option value="http://www2.ro.FreeBSD.org/">Roumanie/2</option>
		  <option value="http://www3.ro.FreeBSD.org/">Roumanie/3</option>
        <option value="http://www4.ro.FreeBSD.org/">Roumanie/4</option>
		  <option value="http://www.ru.FreeBSD.org/">Russie/1</option>
		  <option value="http://www2.ru.FreeBSD.org/">Russie/2</option>
		  <option value="http://www3.ru.FreeBSD.org/">Russie/3</option>
		  <option value="http://www4.ru.FreeBSD.org/">Russie/4</option>
        <option value="http://www.sm.FreeBSD.org/">San Marin</option>
        <option value="http://www2.sg.FreeBSD.org/">Singapoure</option>
		  <option value="http://www.sk.FreeBSD.org/">R&#233;publique Slovaque/1</option>
        <option value="http://www2.sk.FreeBSD.org/">R&#233;publique Slovaque/2</option>
		  <option value="http://www.si.FreeBSD.org/">Slov&#233;nie/1</option>
        <option value="http://www2.si.FreeBSD.org/">Slov&#233;nie/2</option>
		  <option value="http://www.es.FreeBSD.org/">Espagne/1</option>
        <option value="http://www2.es.FreeBSD.org/">Espagne/2</option>
        <option value="http://www3.es.FreeBSD.org/">Espagne/3</option>
		  <option value="http://www.za.FreeBSD.org/">Afrique du Sud/1</option>
		  <option value="http://www2.za.FreeBSD.org/">Afrique du Sud/2</option>
		  <option value="http://www.se.FreeBSD.org/">Su&#232;de/1</option>
        <option value="http://www2.se.FreeBSD.org/">Su&#232;de/2</option>
		  <option value="http://www.ch.FreeBSD.org/">Suisse/1</option>
        <option value="http://www2.ch.FreeBSD.org/">Suisse/2</option>
		  <option value="http://www.tw.FreeBSD.org/">Ta&#239;wan/1</option>
        <option value="http://www2.tw.FreeBSD.org/">Ta&#239;wan/2</option>
		  <option value="http://www3.tw.FreeBSD.org/">Ta&#239;wan/3</option>
		  <option value="http://www4.tw.FreeBSD.org/">Ta&#239;wan/4</option>
		  <option value="http://www.tr.FreeBSD.org/">Turquie/1</option>
        <option value="http://www2.tr.FreeBSD.org/">Turquie/2</option>
		  <option value="http://www.enderunix.org/freebsd/">Turquie/3</option>
		  <option value="http://www.ua.FreeBSD.org/">Ukraine/1</option>
		  <option value="http://www2.ua.FreeBSD.org/">Ukraine/2</option>
		  <option value="http://www4.ua.FreeBSD.org/">Ukraine/Crim&#233;e</option>
        <option value="http://www5.ua.FreeBSD.org/">Ukraine/5</option>
		  <option value="http://www.uk.FreeBSD.org/">Royaume-Uni/1</option>
		  <option value="http://www2.uk.FreeBSD.org/">Royaume-Uni/2</option>
		  <option value="http://www3.uk.FreeBSD.org/">Royaume-Uni/3</option>
        <option value="http://www4.uk.FreeBSD.org/">Royaume-Uni/4</option>
		  <option value="http://www.FreeBSD.org/">USA/Californie</option>
		  <option value="http://www3.FreeBSD.org/">USA/3</option>
		  <option value="http://www7.FreeBSD.org/">USA/7</option>
		</select>

		<input type="submit" value=" Go "/>

		<br/>

		<font color="#990000"><b>Langue : </b></font>
      <a href="it/index.html">Italien</a>,
		<a href="ja/index.html">Japonais</a>,
      <a href="ru/index.html">Russe</a>,
		<a href="es/index.html">Espagnol</a>,
		<a href="support.html#web">Autres</a>
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
			  <p><font size="+1" color="#990000"><b>Nouvelles</b></font>

	      
			    <small><br/>
			      &#183; <a href="news/newsflash.html">Annonces</a><br/>
			      &#183; <a href="news/press.html">Dans la presse</a><br/>
			      &#183; <a href="news/index.html">Plus...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Logiciels</b></font>
			    <small><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/mirrors.html">Obtenir FreeBSD</a><br/>
			      &#183; <a href="releases/index.html">Information sur les versions</a><br/>
			      &#183; <a href="{$base}/ports/index.html">Applications disponibles</a><br/>
			    </small></p>
	    
			  <p><font size="+1" color="#990000"><b>Documentations</b></font>
		
			    <small><br/>
			      &#183; <a href="projects/newbies.html">Pour les d&#233;butants</a><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/index.html">Manuel de R&#233;f&#233;rence</a><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/faq/index.html">FAQ</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/man.cgi">Pages de manuel</a><br/>
			      &#183; <a href="{$base}/docproj/index.html">Projet de Documentation</a><br/>
			      &#183; <a href="docs.html">Plus...</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Support</b></font>

			    <small><br/>
			      &#183; <a href="{$base}/support.html#mailing-list">Listes de diffusion</a><br/>
			      &#183; <a href="{$base}/support.html#newsgroups">Forums de discussion</a><br/>
			      &#183; <a href="{$base}/support.html#user">Groupes Utilisateurs</a><br/>
			      &#183; <a href="{$base}/support.html#web">Ressources Web</a><br/>
			      &#183; <a href="security/index.html">S&#233;curit&#233;</a><br/>
			      &#183; <a href="{$base}/support.html">Plus...</a>
			    </small></p>

           <p><font size="+1" color="#990000"><b>Rapports de Bugs</b></font>
			    <small><br/>
			      &#183; <a href="send-pr.html">Envoyer un rapport de bug</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr-summary.cgi">Consulter les rapports ouverts</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr.cgi">Rechercher par ID de bug</a><br/>
			      &#183; <a href="{$base}/support.html#gnats">Plus...</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>D&#233;veloppement</b></font>
		
			    <small><br/>
			      &#183; <a href="projects/index.html">Projets</a><br/>
               &#183; <a href="releng/index.html">Production des versions</a><br/>
			      &#183; <a href="{$base}/support.html#cvs">D&#233;p&#244;t CVS</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Revendeurs</b></font>

			    <small><br/>
			      &#183; <a href="{$base}/commercial/software_bycat.html">Logiciels</a><br/>
			      &#183; <a href="{$base}/commercial/hardware.html">Mat&#233;riels</a><br/>
			      &#183; <a href="{$base}/commercial/consulting_bycat.html">Consultants</a><br/>
			      &#183; <a href="{$base}/commercial/misc.html">Divers</a><br/>
			    </small></p>
             
           <p><font size="+1" color="#990000"><b>Donations</b></font>
           
             <small><br/>
               &#183; <a href="{$base}/donations/index.html">Coordination donations</a><br/>
               &#183; <a href="{$base}/donations/donors.html">Donations actuelles</a><br/>
               &#183; <a href="{$base}/donations/wantlist.html">Liste des besoins</a><br/>
             </small></p>

			  <p><font size="+1" color="#990000"><b>Ce Site</b></font>

			    <small><br/>
			      &#183; <a href="{$base}/search/index-site.html">Plan du site</a><br/>
			      &#183; <a href="{$base}/search/search.html">Recherche</a><br/>
			      &#183; <a href="internal/index.html">Plus...</a><br/>
			    </small></p>

			  <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
			    <small>Rechercher :<br/>
			      <input type="text" name="words" size="10"/>
			      <input type="hidden" name="max" value="25"/>
			      <input type="hidden" name="source" value="www"/>
			      <input type="submit" value="Go"/></small>
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
	      <h2><font color="#990000">Qu'est-ce que FreeBSD ?</font></h2>
	
	      <p>FreeBSD est un syst&#232;me d'exploitation avanc&#233; pour
		les architectures compatibles x86, DEC Alpha, IA-64, PC-98 et UltraSPARC.
		Il est d&#233;riv&#233; de UNIX BSD, la version d'<xsl:value-of select="$unix"/> 
		d&#233;velopp&#233; &#224;
		l'Universit&#233; de Californie, Berkeley.
		Il est d&#233;velopp&#233; et maintenu par
		<a
		href="{$base}/doc/en_US.ISO8859-1/articles/contributors/index.html">une
		importante &#233;quipe de personnes</a>. D'autres
		<a href="{$base}/platforms/index.html">plates-formes</a> sont &#224;
		divers stades de d&#233;veloppement.</p>
	      
	      <h2><font color="#990000">Des fonctions avanc&#233;es</font></h2>

	      <p>FreeBSD offre aujourd'hui des <a href="{$base}/features.html">fonctions avanc&#233;es</a>
		pour le r&#233;seau, les performances, la s&#233;curit&#233; et
		la compatibilit&#233;
		qui sont encore absentes d'autres syst&#232;mes d'exploitation,
		y compris certains des meilleurs syst&#232;mes commerciaux.</p>
	      
	      <h2><font color="#990000">Des solutions performantes pour Internet</font></h2>

	      <p>FreeBSD est id&#233;al dans le cadre d'un serveur
		<a href="{$base}/internet.html">Internet ou Intranet</a>.
		Il offre des services r&#233;seaux robustes, m&#234;me sous de fortes
		charges, et utilise efficacement la m&#233;moire afin de maintenir des
		temps de r&#233;ponses corrects pour des milliers de processus utilisateurs
		simultan&#233;s. Vous pouvez consulter notre
		<a href="gallery/gallery.html">galerie</a> d'exemples de
		services et d'applications utilisant FreeBSD.</p>

	      <h2><font color="#990000">Une grande vari&#233;t&#233;
		  d'applications</font></h2>

	      <p>La qualit&#233; de FreeBSD combin&#233;e avec le co&#251;t tr&#232;s bas et
		les hautes performances des PC actuels font de FreeBSD une alternative
		&#233;conomique aux stations de travail <xsl:value-of select="$unix"/> 
		commerciales. Il est tr&#232;s bien
		adapt&#233; &#224; un grand nombre <a href="{$base}/applications.html">d'applications</a>
		aussi bien pour les serveurs que pour les postes individuels.</p>

	      <h2><font color="#990000">Facile &#224; installer</font></h2>

	      <p>FreeBSD peut s'installer depuis divers supports comme des
		CD-ROM, des DVD-ROM, des disquettes, des bandes magn&#233;tiques, une partition MS-DOS&#174; ou, si
		vous avez une connexion r&#233;seau, 
		<i>directement</i> depuis un serveur FTP anonyme ou un serveur NFS. Tout ce dont vous avez besoin
		est de 2 disquettes vierges de 1.44 Mo et de
		<a href="{$base}/doc/en_US.ISO8859-1/books/handbook/install.html">ces
		  instructions</a>.</p>

	      <h2><font color="#990000">FreeBSD est <i>libre et gratuit</i></font></h2>

	      <a href="copyright/daemon.html"><img src="gifs/dae_up3.gif"
						   alt=""
						   height="81" width="72"
						   align="right"
						   border="0"/></a>

	      <p>Alors que vous pourriez vous attendre &#224; ce qu'un syst&#232;me d'exploitation
		avec ce type de fonctions soit vendu &#224; un prix &#233;lev&#233;, FreeBSD est disponible
		<a href="{$base}/copyright/index.html">gratuitement</a>
		et est fourni avec l'int&#233;gralit&#233; de son code source. Si vous voulez l'essayer,
		<a href="{$base}/doc/en_US.ISO8859-1/books/handbook/mirrors.html">de plus
		  amples informations sont disponibles</a>.</p>

	      <h2><font color="#990000">Contribuer &#224; FreeBSD</font></h2>

	      <p>Il est facile de contribuer &#224; FreeBSD. Tout ce que vous avez &#224; faire
		est de trouver une partie de FreeBSD dont vous pensez qu'elle pourrait
		&#234;tre am&#233;lior&#233;e et de faire ces changements (avec soin)
		puis de les soumettre au projet par l'interm&#233;diaire du programme "send-pr"
		ou d'une personne y participant d&#233;j&#224;, si vous en connaissez une. Cela peut &#234;tre
		de la documentation, du graphisme ou du code. Consultez l'article
		<a href="{$base}/doc/en_US.ISO8859-1/articles/contributing/index.html">Contribuer
		&#224; FreeBSD</a>pour plus d'informations.</p>

		<p>M&#234;me si vous n'&#234;tes pas un programmeur, il existe d'autres fa&#231;ons de
 		contribuer &#224; FreeBSD. La Fondation FreeBSD est une
		organisation &#224; but non-lucratif pour laquelle les dons directs
		sont enti&#232;rement d&#233;ductibles. Veuillez contacter
		<a href="mailto:bod@FreeBSDFoundation.org">bod@FreeBSDFoundation.org</a>
		pour plus d'informations ou &#233;crivez &#224; : The FreeBSD Foundation,
		7321 Brockway Dr.  Boulder, CO.  80303.  USA</p>

		<p>Silicon Breeze a &#233;galement sculpt&#233; et moul&#233; le D&#233;mon BSD
		en m&#233;tal et fait don de 15% du produit des ventes de
		ces statuettes &#224; la Fondation FreeBSD. Le r&#233;cit
		complet et de plus amples informations pour commander cette statuette
		sont disponibles sur
 		<a href="http://www.linuxjewellery.com/beastie/">cette page.</a>
		</p>

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
			     <td valign="top"><p><font size="+1" color="#990000"><b>Version la plus r&#233;cente :
			       <xsl:value-of select="$rel.current"/></b></font><br/>

			       <small>&#183; <a href="{$u.rel.announce}">Annonce</a><br/>
			        &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/install.html">Guide d'installation</a><br/>
			        &#183; <a href="{$u.rel.notes}">Notes</a><br/>
			        &#183; <a href="{$u.rel.hardware}">Compatibilit&#233; mat&#233;riel</a><br/>
			        &#183; <a href="{$u.rel.errata}">Errata</a><br/>
                 &#183; <a href="{$u.rel.early}">Guide pour les premiers utilisateurs</a></small></p>
           
               <p><font size="+1" color="#990000"><b>Version de production :
                 <xsl:value-of select="$rel2.current"/></b></font><br/>
                 <small>&#183; <a href="{$u.rel2.announce}">Annonce</a><br/>
                   &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/install.html">Guide d'installation</a><br/>
                   &#183; <a href="{$u.rel2.notes}">Notes</a><br/>
                   &#183; <a href="{$u.rel2.hardware}">Compatibilit&#233; mat&#233;riel</a><br/>
                   &#183; <a href="{$u.rel2.errata}">Errata</a></small></p>

			  <p><font size="+1" color="#990000"><b>Nouvelles du Projet</b></font><br/>
			    <font size="-1">
			      Derni&#232;re mise &#224; jour :
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
			      <a href="news/newsflash.html">Plus...</a>
			    </font></p>

			  <p><font size="+1" color="#990000"><b>FreeBSD dans la presse</b></font><br/>

			    <font size="-1">
			      Derni&#232;re mise &#224; jour :
			      <xsl:value-of
				select="document('news/press.xml')/descendant::month[position() = 1]/name"/>
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="document('news/press.xml')/descendant::year[position() = 1]/name"/>
			      <br/>
			      <!-- Pull in the 10 most recent press items -->
			      <xsl:for-each select="document('news/press.xml')/descendant::story[position() &lt; 10]">
				&#183; <a>
				  <xsl:attribute name="href">
				    news/press.html#<xsl:call-template name="generate-story-anchor"/>
				  </xsl:attribute>
				  <xsl:value-of select="name"/>
				</a><br/>
			      </xsl:for-each>
			      <a href="news/press.html">Plus...</a>
			    </font>
			  </p>
           
           <p><font size="+1" color="#990000"><b>Avis de s&#233;curit&#233;</b></font><br/>

			    <font size="-1">
			      Derni&#232;re mise &#224; jour :
			      <xsl:value-of
				select="document('security/advisories.xml')/descendant::month[position() = 1]/name"/>
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="document('security/advisories.xml')/descendant::day[position() = 1]/name"/>
			      <xsl:text>, </xsl:text>
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
			      <a href="security/">Plus...</a>
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
			<td>Pour en apprendre davantage &#224; propos de FreeBSD, visitez notre galerie
			  de
			  <a href="{$base}/publish.html">publications</a> ou
			  <a href="news/press.html">d'articles de presse</a>
			  li&#233;s &#224; FreeBSD,
			  et visitez notre site web !</td>
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
	    <td><a href="http://www.freebsdmall.com/"><img
							   src="gifs/mall_title_medium.gif" alt="[FreeBSD Mall]"
							   height="65" width="165" border="0"/></a></td>

	    <td><a href="http://www.ugu.com/"><img src="gifs/ugu_icon.gif"
						   alt="[Sponsor of Unix Guru Universe]"
						   height="64" width="76"
						   border="0"/></a></td>

	    <td><a href="http://www.daemonnews.org/"><img src="gifs/darbylogo.gif"
		alt="[Daemon News]" height="45" width="130"
		border="0"/></a></td>

	    <td><a href="{$base}/copyright/daemon.html"><img
							     src="gifs/powerlogo.gif"
							     alt="[Powered by FreeBSD]"
							     height="64"
							     width="160"
							     border="0"/></a></td>
	  </tr>
	</table>

	<p><small>Le site web est mis &#224; jour quotidiennement &#224; 0800 et
	    2000 UTC.</small></p>

	<table width="100%" cellpadding="0" border="0" cellspacing="0">
	  <tr>
	    <td align="left"
		valign="top"><small><a href="{$base}/mailto.html">Contactez
		  nous</a><br/>
		<xsl:value-of select="$date"/></small></td>

	    <td align="right"
		valign="top"><small><a href="copyright/index.html">Infos l&#233;gales</a><br/> &#169; 1995-2003
		Le Projet FreeBSD.<br/>
		Tous droits r&#233;serv&#233;s.</small></td>
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
