<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/it/includes.xsl,v 1.12 2005/08/29 15:04:36 ale Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../share/sgml/includes.xsl" />

  <xsl:variable name="url.doc.langcode" select="'it_IT.ISO8859-15'" />

  <xsl:variable name="i.daemon">
    <img src="{$enbase}/gifs/daemon.gif" alt="" align="left" width="80" height="76"/>
  </xsl:variable>

  <xsl:variable name="i.new">
    <img src="{$enbase}/gifs/new.gif" alt="[New!]" width="28" height="11"/>
  </xsl:variable>

  <xsl:variable name="copyright">
    <a href="{$enbase}/copyright/">Note Legali</a> | &#169; 1995-2005 the FreeBSD Project.  Tutti i diritti riservati.
  </xsl:variable>

  <xsl:variable name="home">
    <a href="{$base}/index.html"><img src="{$enbase}/gifs/home.gif" alt="FreeBSD Home Page" border="0" align="right" width="101" height="33"/></a>
  </xsl:variable>

  <xsl:variable name="section" select="''"/>

  <xsl:variable name="header1">
    <head><title><xsl:value-of select="$title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <meta name="MSSmartTagsPreventParsing" content="TRUE" />
    <link rel="shortcut icon" href="{$enbase}/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="{$enbase}/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" media="screen" href="{$enbase}/layout/css/fixed.css" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="{$enbase}/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="{$enbase}/layout/js/styleswitcher.js"></script>
    </head>    
  </xsl:variable>
  
  <xsl:variable name="header2">
            <span class="txtoffscreen"><a href="#content" title="Salta la navigazione del sito" accesskey="1">Salta la navigazione del sito</a> (1)</span>
            <span class="txtoffscreen"><a href="#contentwrap" title="Salta la navigazione della sezione" accesskey="2">Salta la navigazione della sezione</a> (2)</span>
            <div id="headercontainer">
      
              <div id="header">
      	      <h2 class="blockhide">Intestazione e Logo</h2>
                <div id="headerlogoleft">
                  <a href="{$base}" title="FreeBSD"><img src="{$enbase}/layout/images/logo.png" width="360" height="40" alt="FreeBSD" /></a>
                </div> <!-- headerlogoleft -->
                <div id="headerlogoright">
      			<h2 class="blockhide">Collegamenti Periferici</h2>
      			  <div id="searchnav">
      				<ul id="searchnavlist">
      				  <li>
      					Dimensione del Testo: <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Normal Text'); return false;" title="Dimensione Testo Normale">Normale</a> / <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Large Text'); return false;" title="Dimensione Testo Grande">Grande</a>
      				  </li>
      				  <li>
      					<a href="{$enbase}/donations/" title="Donazioni">Donazioni</a>
      				  </li>
      				  <li class="last-child">
      					<a href="{$base}/mailto.html" title="Contattaci">Contattaci</a>
      				  </li>
      				</ul>
      			  </div> <!-- searchnav -->
      			<div id="search">
      			  <form action="{$enbase}/cgi/search.cgi" method="get">
      				<div>
      			      <h2 class="blockhide"><label for="words">Cerca</label></h2>
      				  <input type="hidden" name="max" value="25" /> <input type="hidden" name="source" value="www" /><input id="words" name="words" type="text" size="20" maxlength="255" onfocus="if( this.value==this.defaultValue ) this.value='';" value="Cerca" />&#160;<input id="submit" name="submit" type="submit" value="Cerca" />
      				</div>
      			  </form>
      			</div> <!-- search -->
                </div> <!-- headerlogoright -->
      
              </div> <!-- header -->
      
        	<h2 class="blockhide">Navigazione del Sito</h2>
              <div id="topnav">
                <ul id="topnavlist">
		  <li>
			<a href="{$base}/" title="Home">Home</a>
		  </li>
		  <li>
			<a href="{$base}/about.html" title="Info">Info</a>
		  </li>
		  <li>
			<a href="{$enbase}/where.html" title="Ottenere FreeBSD">Ottenere FreeBSD</a>
		  </li>
		  <li>
			<a href="{$base}/docs.html" title="Documentazione">Documentazione</a>
		  </li>
		  <li>
			<a href="{$enbase}/community.html" title="Comunità">Comunità</a>
		  </li>
		  <li>
			<a href="{$enbase}/projects/index.html" title="Sviluppo">Sviluppo</a>
		  </li>
		  <li>
			<a href="{$enbase}/support.html" title="Supporto">Supporto</a>
		  </li>		  
		</ul>
              </div> <!-- topnav -->
            </div> <!-- headercontainer -->
  </xsl:variable>
  
  <xsl:variable name="header3">
  	<h1><xsl:value-of select="$title"/></h1>
  </xsl:variable>
  
  <xsl:variable name="sidenav">
	<div id="sidewrap">
	
	<div id="sidenav">
	<h2 class="blockhide">Navigation della Sezione</h2>
	
	<xsl:if test="$section = 'about'" >
		<ul>
		<li><a href="{$base}/about.html">Info</a></li>
		<li><a href="{$enbase}/features.html">Caratteristiche</a></li>
		<li><a href="{$enbase}/applications.html">Applicazioni</a></li>
		<li><a href="{$enbase}/internet.html">Connettività</a></li>
		<li><a href="{$enbase}/advocacy/">Avvocatura</a></li>
		<li><a href="{$enbase}/marketing/">Marketing</a></li>
		<li><a href="{$enbase}/news/newsflash.html">News</a></li>
		<li><a href="{$enbase}/events/events.html">Eventi</a></li>
		<li><a href="{$enbase}/news/press.html">Stampa</a></li>
		<li><a href="{$enbase}/art.html">Illustrazioni</a></li>
		<li><a href="{$enbase}/donations/">Donazioni</a></li>
		<li><a href="{$enbase}/copyright/">Note Legali</a></li>
		</ul>
    	</xsl:if>
    	
    	<xsl:if test="$section = 'community'" >
		<ul>
		<li><a href="{$enbase}/community.html">Comunità</a></li>
		<!--li><a href="{$enbase}/community/mailinglists.html">Mailing List</a></li>
		<li><a href="{$enbase}/community/irc.html">IRC</a></li>
		<li><a href="{$enbase}/community/newsgroups.html">Newsgroup</a></li>
		<li><a href="{$enbase}/usergroups.html">Gruppi Utenti</a></li>
		<li><a href="{$enbase}/community/webresources.html">Risorse Web</a></li-->
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'developers'" >
		<ul>
		<li><a href="{$base}/projects/index.html">Sviluppo</a></li>
		<li><a href="{$enbase}/doc/en_US.ISO8859-1/books/developers-handbook">Manuale dello Sviluppatore</a></li>
		<li><a href="{$enbase}/doc/en_US.ISO8859-1/books/porters-handbook">Manuale del Porter</a></li>
		<li><a href="{$enbase}/developers/cvs.html">Repository CVS</a></li>
		<li><a href="{$enbase}/releng/index.html">Release Engineering</a></li>
		<li><a href="{$enbase}/platforms/">Piattaforme</a>
			<ul>
				<li><a href="{$enbase}/platforms/alpha.html">alpha</a></li>
				<li><a href="{$enbase}/platforms/amd64.html">amd64</a></li>
				<li><a href="{$enbase}/platforms/i386.html">i386</a></li>
				<li><a href="{$enbase}/platforms/ia64.html">ia64</a></li>
				<li><a href="{$enbase}/platforms/pc98.html">pc98</a></li>
				<li><a href="{$enbase}/platforms/sparc.html">sparc64</a></li>
			</ul>
		</li>
		<li><a href="{$enbase}/doc/en_US.ISO8859-1/articles/contributing/index.html">Contribuire</a></li>
		</ul>
    	</xsl:if>

	<xsl:if test="$section = 'docs'" >
		<ul>
		<li><a href="{$base}/docs.html">Documentazione</a></li>
		<li><a href="{$enbase}/doc/en_US.ISO8859-1/books/faq/">FAQ</a></li>
		<li><a href="{$enbase}/doc/{$url.doc.langcode}/books/handbook/index.html">Manuale</a></li>
		<li><a href="{$enbase}/docs/man.html">Pagine man</a>
			<ul>
				<li><a href="{$enbase}/cgi/man.cgi">Man Online</a></li>
			</ul>
		</li>
		<li><a href="{$base}/docs/books.html">Libri e Articoli Tradotti Online</a></li>
		<li><a href="{$enbase}/docs/books.html">Libri e Articoli Online</a></li>
		<li><a href="{$enbase}/publish.html">Pubblicazioni</a></li>
		<li><a href="{$enbase}/docs/webresources.html">Risorse Web</a></li>
		<li><a href="{$enbase}/projects/newbies.html">Per i Neofiti</a></li>
		<li><a href="{$enbase}/docproj/">Documentation Project</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'download'" >
		<ul>
		<li><a href="{$base}/where.html">Ottenere FreeBSD</a></li>
		<li><a href="{$base}/releases/">Info sulle Release</a>
			<ul>
				<li><a href="{$u.rel.announce}">Release di Produzione: <xsl:value-of select="$rel.current"/></a></li>
				<li><a href="{$u.rel2.announce}">Release di Produzione (Legacy): <xsl:value-of select="$rel2.current"/></a></li>
				<li><a href="{$base}/snapshots/">Snapshot delle Release</a></li>
			</ul>
		</li>
		<li><a href="{$enbase}/ports/">Applicazioni Portate</a></li>
		</ul>
	</xsl:if>
    	
    	<xsl:if test="$section = 'support'" >
		<ul>
		<li><a href="{$base}/support.html">Supporto</a></li>
		<li><a href="{$enbase}/commercial/">Fornitori</a>
			<ul>
				<li><a href="{$enbase}/commercial/software_bycat.html">Software</a></li>
				<li><a href="{$enbase}/commercial/hardware.html">Hardware</a></li>
				<li><a href="{$enbase}/commercial/consult_bycat.html">Consulenza</a></li>
				<li><a href="{$enbase}/commercial/isp.html">Internet Service Providers</a></li>
				<li><a href="{$enbase}/commercial/misc.html">Varie</a></li>
			</ul>
		</li>
		<li><a href="{$enbase}/security/">Sicurezza</a></li>
		<li><a href="{$enbase}/support/bugreports.html">Report di Bug</a>
			<ul>
				<li><a href="{$enbase}/send-pr.html">Invia un report</a></li>
			</ul>
		</li>
		<li><a href="{$enbase}/support/webresources.html">Risorse Web</a></li>
		</ul>
    	</xsl:if>
	
	</div> <!-- sidenav -->
	
	</div> <!-- sidewrap -->
  </xsl:variable>
  
  <xsl:variable name="footer">
	<div id="footer">
	<xsl:copy-of select="$copyright"/><br />
	<xsl:copy-of select="$date"/>
	</div> <!-- footer -->
  </xsl:variable>

  <xsl:variable name="u.rel.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel.announce">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel.installation">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/installation.html</xsl:variable>
  <xsl:variable name="u.rel.readme">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/readme.html</xsl:variable>
  <xsl:variable name="u.rel.migration">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel.current"/>R/migration-guide.html</xsl:variable>
  <xsl:variable name="u.rel2.notes">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel2.announce">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel2.errata">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel2.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/hardware.html</xsl:variable>
  <xsl:variable name="u.rel2.installation">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/installation.html</xsl:variable>
  <xsl:variable name="u.rel2.readme">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/readme.html</xsl:variable>

  <!-- template: "html-index-advisories-items"
       pulls in the 10 most recent security advisories -->

  <xsl:template name="html-index-advisories-items">
    <xsl:param name="advisories.xml" select="''" />
    <xsl:param name="type" select="'advisory'" />

    <xsl:choose>
      <xsl:when test="$type = 'advisory'">
        <xsl:for-each select="document($advisories.xml)/descendant::advisory[position() &lt;= 3]">
          <xsl:param name="year" select="../../../name" />
          <xsl:param name="month" select="../../name" />
          <xsl:param name="day" select="../name" />
        <p>
          <span class="txtdate">
              <xsl:value-of select='
                concat(format-number($day, "00"), "-",
                format-number($month, "00"), "-",
                format-number($year, "####"))' />
          </span><br />
          <xsl:choose>
            <xsl:when test="@omithref = 'yes'">
              <xsl:value-of select="name"/>
            </xsl:when>
            <xsl:otherwise>
              <a><xsl:attribute name="href">
                  <xsl:value-of select="concat($ftpbase, name, '.asc')"/>
                </xsl:attribute>
                <xsl:value-of select="name"/></a>
            </xsl:otherwise>
          </xsl:choose>
          </p>
        </xsl:for-each>
      </xsl:when>
      <xsl:when test="$type = 'notice'">
        <xsl:for-each select="document($advisories.xml)/descendant::notice[position() &lt;= 3]">
        <xsl:param name="year" select="../../../name" />
        <xsl:param name="month" select="../../name" />
        <xsl:param name="day" select="../name" />
        <p>
          <span class="txtdate">
              <xsl:value-of select='
                concat(format-number($day, "00"), "-",
                format-number($month, "00"), "-",
                format-number($year, "####"))' />
          </span><br />
          <xsl:choose>
            <xsl:when test="@omithref = 'yes'">
              <xsl:value-of select="name"/>
            </xsl:when>
            <xsl:otherwise>
              <a><xsl:attribute name="href">
                  <xsl:value-of select="concat($ftpbaseerrata, name, '.asc')"/>
                </xsl:attribute>
                <xsl:value-of select="name"/></a>
            </xsl:otherwise>
          </xsl:choose>
          </p>
        </xsl:for-each>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- template: "html-index-news-project-items"
       pulls in the 5 most recent project items -->

  <xsl:template name="html-index-news-project-items">
    <xsl:param name="news.project.xml" select="'none'" />

    <xsl:for-each select="document($news.project.xml)/descendant::day[position() &lt;= 5]">
      <xsl:param name="year" select="ancestor::year/name" />
      <xsl:param name="month" select="ancestor::month/name" />
      <xsl:param name="day" select="name" />

      <xsl:for-each select="event">
        <xsl:param name="anchor-position" select="position()" />

        <p>
        <span class="txtdate">
          <xsl:value-of select='
              concat(format-number($day, "00"), "-",
              format-number($month, "00"), "-",
              format-number($year, "####"))' />
        </span><br />
        <a>
          <xsl:attribute name="href">
            <xsl:text>../news/newsflash.html#</xsl:text>
            <xsl:call-template name="html-news-generate-anchor">
              <xsl:with-param name="label" select="'event'" />
              <xsl:with-param name="year" select="$year" />
              <xsl:with-param name="month" select="$month" />
              <xsl:with-param name="day" select="$day" />
              <xsl:with-param name="pos" select="$anchor-position" />
            </xsl:call-template>
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
        </p>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-index-news-press-items"
       pulls in the 5 most recent press items -->

  <xsl:template name="html-index-news-press-items">
    <xsl:param name="news.press.xml" select="''" />

    <xsl:for-each select="document($news.press.xml)/descendant::story[position() &lt;= 5]">
      <xsl:param name="year" select="../../name" />
      <xsl:param name="month" select="../name" />
      <xsl:param name="day" select="../name" />
      <xsl:param name="url" select="url" />
      <xsl:param name="site-url" select="site-url" />

      <xsl:param name="pos">
        <xsl:for-each select="../story">
          <xsl:if test="url = $url">
            <xsl:value-of select="position()" />
          </xsl:if>
        </xsl:for-each>
      </xsl:param>

      <p>
      <span class="txtdate">
        <xsl:value-of select='
            concat(format-number($month, "00"), "-",
            format-number($year, "####"))' />
      </span><br />
      <a>
        <xsl:attribute name="href">
          <xsl:text>../news/press.html#</xsl:text>
          <xsl:call-template name="html-news-generate-anchor">
            <xsl:with-param name="label" select="'story'" />
            <xsl:with-param name="year" select="$year" />
            <xsl:with-param name="month" select="$month" />
            <xsl:with-param name="pos" select="$pos" />
          </xsl:call-template>
        </xsl:attribute>

        <xsl:value-of select="name"/>
      </a></p>
      
    </xsl:for-each>
  </xsl:template>

 <!-- template: "html-index-events-items"
       pulls in the 5 most recent events items -->

  <xsl:template name="html-index-events-items">
    <xsl:param name="events.xml" select="''" />
    <xsl:param name="curdate.xml" select="''" />
    <xsl:variable name="curdate" select="document($curdate.xml)//curdate"/>

    <xsl:for-each select="document($events.xml)/descendant::event[position() &lt; 5
                                                                        and ((number(enddate/year) &gt; number($curdate/year)) or
                                                                            (number(enddate/year) = number($curdate/year) and
                                                                             number(enddate/month) &gt; number($curdate/month)) or
                                                                            (number(enddate/year) = number($curdate/year) and
                                                                             number(enddate/month) = number($curdate/month) and
                                                                             enddate/day &gt;= $curdate/day))]">
      <xsl:sort select="startdate/year" order="ascending"/>
      <xsl:sort select="format-number(startdate/month, '00')" order="ascending"/>
      <xsl:sort select="format-number(startdate/day, '00')" order="ascending"/>

      <p>
      <span class="txtdate">
         <xsl:value-of select='
            concat(format-number(startdate/day, "00"), "-",
            format-number(startdate/month, "00"), "-",
            format-number(startdate/year, "####"), " -  ",
            format-number(enddate/day, "00"), "-",
            format-number(enddate/month, "00"), "-",
            format-number(enddate/year, "####"))' />
      </span><br />
      <a>
        <xsl:attribute name="href">
          <xsl:text>../events/#event:</xsl:text><xsl:value-of select='@id' />
        </xsl:attribute>

        <xsl:value-of select="name"/>

        <br />
        (<xsl:value-of select='location/city' />, <xsl:value-of select='location/country' />)
      </a></p>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
