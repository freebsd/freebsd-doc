<!-- $FreeBSD: www/fr/index.xsl,v 1.9 2004/01/12 20:21:21 stephane Exp $ -->

<!-- 
   The FreeBSD French Documentation Project
   Original revision: 1.95
   
   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/fr/index.xsl,v 1.9 2004/01/12 20:21:21 stephane Exp $'"/>
  <xsl:variable name="title" select="'Le Projet FreeBSD'"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="advisories.xml" select="'none'"/>
  <xsl:param name="mirrors.xml" select="'none'"/>
  <xsl:param name="news.press.xml" select="'none'"/>
  <xsl:param name="news.project.xml" select="'none'"/>

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
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="/favicon.ico" type="image/x-icon"/>
      </head>

      <body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#840084"
	    alink="#0000FF">

	<table border="0" cellspacing="0" cellpadding="0" width="100%">
	  <tr>
	    <td><a href="http://www.FreeBSD.org/index.html">
		<img src="{$enbase}/gifs/freebsd_1.gif" height="94" width="306"
		     alt="FreeBSD : Le Pouvoir de Servir" border="0"/></a></td>

	    <td align="right" valign="bottom">
	      <form action="http://www.FreeBSD.org/cgi/mirror.cgi"
		    method="get">

		<br/>

		<font color="#990000"><b>Choisissez un serveur proche de chez vous :</b></font>

		<br/>

		<select name="goto">
		  <!--  Only list TRUE mirrors here! Native language pages 
		        which are not mirrored should be listed in
		        support.sgml.  -->

		  <xsl:call-template name="html-index-mirrors-options-list">
		    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
		  </xsl:call-template>
		</select>

		<input type="submit" value=" Go "/>

		<br/>

		<font color="#990000"><b>Langue : </b></font>
		<a href="{$enbase}/de/index.html" title="Allemand">[de]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$enbase}/index.html" title="Anglais">[en]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$enbase}/es/index.html" title="Espagnol">[es]</a>
		<xsl:text>&#160;</xsl:text>
		<span title="Fran&#231;ais">[fr]</span>
		<xsl:text>&#160;</xsl:text>
		<a href="{$enbase}/it/index.html" title="Italien">[it]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$enbase}/ja/index.html" title="Japonais">[ja]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$enbase}/ru/index.html" title="Russe">[ru]</a>
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
                          <xsl:call-template name="html-index-navigation-link-list">
                            <xsl:with-param name="navigation.xml" select="$navigation.xml"/>
                          </xsl:call-template>

			  <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
			    <small>Rechercher :<br/>
			      <input type="text" name="words" size="10"/>
			      <input type="hidden" name="max" value="25"/>
			      <input type="hidden" name="source" value="www"/>
			      <input type="submit" value="Go"/></small>
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
	      <h2><font color="#990000">Qu'est-ce que FreeBSD ?</font></h2>
	
	      <p>FreeBSD est un syst&#232;me d'exploitation avanc&#233; pour
		les architectures compatibles x86, AMD64, Alpha, IA-64, PC-98 et UltraSPARC&#174;.
		Il est d&#233;riv&#233; de UNIX BSD, la version d'<xsl:value-of select="$unix"/> 
		d&#233;velopp&#233; &#224;
		l'Universit&#233; de Californie, Berkeley.
		Il est d&#233;velopp&#233; et maintenu par
		<a
		href="{$enbase}/doc/{$url.doc.langcode}/articles/contributors/index.html">une
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
		<a href="{$enbase}/doc/{$url.doc.langcode}/books/handbook/install.html">ces
		  instructions</a>.</p>

	      <h2><font color="#990000">FreeBSD est <i>libre et gratuit</i></font></h2>

	      <a href="copyright/daemon.html"><img src="{$enbase}/gifs/dae_up3.gif"
						   alt=""
						   height="81" width="72"
						   align="right"
						   border="0"/></a>

	      <p>Alors que vous pourriez vous attendre &#224; ce qu'un syst&#232;me d'exploitation
		avec ce type de fonctions soit vendu &#224; un prix &#233;lev&#233;, FreeBSD est disponible
		<a href="{$base}/copyright/index.html">gratuitement</a>
		et est fourni avec l'int&#233;gralit&#233; de son code source. Si vous voulez l'essayer,
		<a href="{$enbase}/doc/{$url.doc.langcode}/books/handbook/mirrors.html">de plus
		  amples informations sont disponibles</a>.</p>

	      <h2><font color="#990000">Contribuer &#224; FreeBSD</font></h2>

	      <p>Il est facile de contribuer &#224; FreeBSD. Tout ce que vous avez &#224; faire
		est de trouver une partie de FreeBSD dont vous pensez qu'elle pourrait
		&#234;tre am&#233;lior&#233;e et de faire ces changements (avec soin)
		puis de les soumettre au projet par l'interm&#233;diaire du programme "send-pr"
		ou d'une personne y participant d&#233;j&#224;, si vous en connaissez une. Cela peut &#234;tre
		de la documentation, du graphisme ou du code. Consultez l'article
		<a href="{$enbase}/doc/{$url.doc.langcode}/articles/contributing/index.html">Contribuer
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
			<td valign="top"><p>
			    <a href="{$u.rel.early}">
			      <font size="+1" color="#990000"><b>Version la plus r&#233;cente :
				  <xsl:value-of select="$rel.current"/></b></font></a><br/>
			    <small>&#183; <a href="{$u.rel.announce}">Annonce</a><br/>
			      &#183; <a href="{$enbase}/doc/{$url.doc.langcode}/books/handbook/install.html">Guide d'installation</a><br/>
			      &#183; <a href="{$u.rel.notes}">Notes</a><br/>
			      &#183; <a href="{$u.rel.hardware}">Compatibilit&#233; mat&#233;riel</a><br/>
			      &#183; <a href="{$u.rel.errata}">Errata</a><br/>
			      &#183; <a href="{$u.rel.early}">Guide pour les premiers utilisateurs</a></small></p>
           
			  <p>
			    <a href="{$u.rel2.announce}">
			      <font size="+1" color="#990000"><b>Version de production :
				  <xsl:value-of select="$rel2.current"/></b></font></a><br/>

			    <small>&#183; <a href="{$u.rel2.announce}">Annonce</a><br/>
			      &#183; <a href="{$enbase}/doc/{$url.doc.langcode}/books/handbook/install.html">Guide d'installation</a><br/>
			      &#183; <a href="{$u.rel2.notes}">Notes</a><br/>
			      &#183; <a href="{$u.rel2.hardware}">Compatibilit&#233; mat&#233;riel</a><br/>
			      &#183; <a href="{$u.rel2.errata}">Errata</a></small></p>

			  <p><font size="+1" color="#990000"><b>Nouvelles du Projet</b></font><br/>
			    <font size="-1">
			      Derni&#232;re mise &#224; jour :
			      <xsl:call-template name="html-index-news-project-items-lastmodified">
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			      </xsl:call-template>

			      <br/>
			      
			      <xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			      </xsl:call-template>

			      <a href="news/newsflash.html">Plus...</a>
			    </font></p>

			  <p><font size="+1" color="#990000"><b>FreeBSD dans la presse</b></font><br/>

			    <font size="-1">
			      Derni&#232;re mise &#224; jour :
			      <xsl:call-template name="html-index-news-press-items-lastmodified">
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			      </xsl:call-template>

			      <br/>

			      <xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			      </xsl:call-template>
			      
			      <a href="news/press.html">Plus...</a>
			    </font>
			  </p>
           
			  <p><font size="+1" color="#990000"><b>Avis de s&#233;curit&#233;</b></font><br/>

			    <font size="-1">
			      Derni&#232;re mise &#224; jour :
			      <xsl:call-template name="html-index-advisories-items-lastmodified">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
			      </xsl:call-template>

			      <br/>
			      
			      <xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
			      </xsl:call-template>

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
							   src="{$enbase}/gifs/mall_title_medium.gif" alt="[FreeBSD Mall]"
							   height="65" width="165" border="0"/></a></td>

	    <td><a href="http://www.ugu.com/"><img src="{$enbase}/gifs/ugu_icon.gif"
						   alt="[Sponsor of Unix Guru Universe]"
						   height="64" width="76"
						   border="0"/></a></td>

	    <td><a href="http://www.daemonnews.org/"><img src="{$enbase}/gifs/darbylogo.gif"
		alt="[Daemon News]" height="45" width="130"
		border="0"/></a></td>

	    <td><a href="{$base}/copyright/daemon.html"><img
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
		valign="top"><small><a href="{$base}/mailto.html">Contactez
		  nous</a><br/>
		<xsl:value-of select="$date"/></small></td>

	    <td align="right"
		valign="top"><small><a href="copyright/index.html">Infos l&#233;gales</a><br/> &#169; 1995-2004
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
