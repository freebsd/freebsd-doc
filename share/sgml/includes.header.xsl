<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/share/sgml/includes.header.xsl,v 1.11 2005/11/30 20:05:51 pav Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="i.daemon">
    <img src="{$base}/gifs/daemon.gif" alt="" align="left" width="80" height="76"/>
  </xsl:variable>

  <xsl:variable name="i.new">
    <img src="{$base}/gifs/new.gif" alt="[New!]" width="28" height="11"/>
  </xsl:variable>

  <xsl:variable name="copyright">
    <a href="{$base}/copyright/">Legal Notices</a> | &#169; 1995-2005 The FreeBSD Project.  All rights reserved.
  </xsl:variable>

  <xsl:variable name="email" select="'freebsd-questions'"/>

  <xsl:variable name="author">
    <a>
      <xsl:attribute name="href">
	<xsl:value-of select="concat($base, '/mailto.html')"/>
      </xsl:attribute>
      <xsl:value-of select="$email"/>@FreeBSD.org</a><br/><xsl:copy-of select="$copyright"/>
  </xsl:variable>

  <xsl:variable name="home">
    <a href="{$base}/index.html"><img src="{$base}/gifs/home.gif" alt="FreeBSD Home Page" border="0" align="right" width="101" height="33"/></a>
  </xsl:variable>

  <xsl:variable name="section" select="''"/>

  <xsl:variable name="header1">
    <head><title><xsl:value-of select="$title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <meta name="MSSmartTagsPreventParsing" content="TRUE" />
    <link rel="shortcut icon" href="{$base}/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="{$base}/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" media="screen" href="{$base}/layout/css/fixed.css" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="{$base}/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="{$base}/layout/js/styleswitcher.js"></script>
    </head>    
  </xsl:variable>
  
  <xsl:variable name="header2">
            <span class="txtoffscreen"><a href="#CONTENT" title="Skip site navigation" accesskey="1">Skip site navigation</a> (1)</span>
            <xsl:text> </xsl:text> 
            <span class="txtoffscreen"><a href="#CONTENTWRAP" title="Skip section navigation" accesskey="2">Skip section navigation</a> (2)</span>
            <div id="HEADERCONTAINER">
      
              <div id="HEADER">
      	      <h2 class="blockhide">Header And Logo</h2>
                <div id="HEADERLOGOLEFT">
                  <a href="{$base}" title="FreeBSD"><img src="{$base}/layout/images/logo.png" width="360" height="40" alt="FreeBSD" /></a>
                </div> <!-- HEADERLOGOLEFT -->
                <div id="HEADERLOGORIGHT">
      			<h2 class="blockhide">Peripheral Links</h2>
      			  <div id="SEARCHNAV">
      				<ul id="SEARCHNAVLIST">
      				  <li>
      					Text Size: <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Normal Text'); return false;" title="Normal Text Size">Normal</a> / <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Large Text'); return false;" title="Large Text Size">Large</a>
      				  </li>
      				  <li>
      					<a href="{$base}/donations/" title="Donate">Donate</a>
      				  </li>
      				  <li class="last-child">
      					<a href="{$base}/mailto.html" title="Contact">Contact</a>
      				  </li>
      				</ul>
      			  </div> <!-- SEARCHNAV -->
      			<div id="SEARCH">
      			  <form action="{$cgibase}/search.cgi" method="get">
      				<div>
      			      <h2 class="blockhide"><label for="WORDS">Search</label></h2>
      				  <input type="hidden" name="max" value="25" /> <input type="hidden" name="source" value="www" /><input id="WORDS" name="words" type="text" size="20" maxlength="255" onfocus="if( this.value==this.defaultValue ) this.value='';" value="Search" />&#160;<input id="SUBMIT" name="submit" type="submit" value="Search" />
      				</div>
      			  </form>
      			</div> <!-- SEARCH -->
                </div> <!-- HEADERLOGORIGHT -->
      
              </div> <!-- HEADER -->
      
        	<h2 class="blockhide">Site Navigation</h2>
              <div id="TOPNAV">
                <ul id="TOPNAVLIST">
		  <li>
			<a href="{$base}/" title="Home">Home</a>
		  </li>
		  <li>
			<a href="{$base}/about.html" title="About">About</a>
		  </li>
		  <li>
			<a href="{$base}/where.html" title="Get FreeBSD">Get FreeBSD</a>
		  </li>
		  <li>
			<a href="{$base}/docs.html" title="Documentation">Documentation</a>
		  </li>
		  <li>
			<a href="{$base}/community.html" title="Community">Community</a>
		  </li>
		  <li>
			<a href="{$base}/projects/index.html" title="Developers">Developers</a>
		  </li>
		  <li>
			<a href="{$base}/support.html" title="Support">Support</a>
		  </li>
		</ul>
              </div> <!-- TOPNAV -->
            </div> <!-- HEADERCONTAINER -->
  </xsl:variable>
  
  <xsl:variable name="header3">
  	<h1><xsl:value-of select="$title"/></h1>
  </xsl:variable>
  
  <xsl:variable name="sidenav">
	<div id="SIDEWRAP">
	
	<div id="SIDENAV">
	<h2 class="blockhide">Section Navigation</h2>
	
	<xsl:if test="$section = 'about'" >
		<ul>
		<li><a href="{$base}/about.html">About</a></li>
		<li><a href="{$base}/features.html">Features</a></li>
		<li><a href="{$base}/applications.html">Applications</a></li>
		<li><a href="{$base}/internet.html">Internetworking</a></li>
		<li><a href="{$base}/advocacy/">Advocacy</a></li>
		<li><a href="{$base}/marketing/">Marketing</a></li>
		<li><a href="{$base}/news/newsflash.html">News</a></li>
		<li><a href="{$base}/events/events.html">Events</a></li>
		<li><a href="{$base}/news/press.html">Press</a></li>
		<li><a href="{$base}/art.html">Artwork</a></li>
		<li><a href="{$base}/donations/">Donations</a></li>
		<li><a href="{$base}/copyright/">Legal Notices</a></li>
		</ul>
    	</xsl:if>
    	
    	<xsl:if test="$section = 'community'" >
		<ul>
		<li><a href="{$base}/community.html">Community</a></li>
		<li><a href="{$base}/community/mailinglists.html">Mailing Lists</a></li>
		<li><a href="{$base}/community/irc.html">IRC</a></li>
		<li><a href="{$base}/community/newsgroups.html">Newsgroups</a></li>
		<li><a href="{$base}/usergroups.html">User Groups</a></li>
		<li><a href="{$base}/community/webresources.html">Web Resources</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'developers'" >
		<ul>
		<li><a href="{$base}/projects/index.html">Developers</a></li>
		<li><a href="{$base}/doc/en_US.ISO8859-1/books/developers-handbook">Developer&#39;s Handbook</a></li>
		<li><a href="{$base}/doc/en_US.ISO8859-1/books/porters-handbook">Porter&#39;s Handbook</a></li>
		<li><a href="{$base}/developers/cvs.html">CVS Repository</a></li>
		<li><a href="{$base}/releng/index.html">Release Engineering</a></li>
		<li><a href="{$base}/platforms/">Platforms</a>
			<ul>
				<li><a href="{$base}/platforms/alpha.html">alpha</a></li>
				<li><a href="{$base}/platforms/amd64.html">amd64</a></li>
				<li><a href="{$base}/platforms/i386.html">i386</a></li>
				<li><a href="{$base}/platforms/ia64/index.html">ia64</a></li>
				<li><a href="{$base}/platforms/pc98.html">pc98</a></li>
				<li><a href="{$base}/platforms/ppc.html">ppc</a></li>
				<li><a href="{$base}/platforms/sparc.html">sparc64</a></li>
			</ul>
		</li>
		<li><a href="{$base}/doc/en_US.ISO8859-1/articles/contributing/index.html">Contributing</a></li>
		</ul>
    	</xsl:if>

	<xsl:if test="$section = 'docs'" >
		<ul>
		<li><a href="{$base}/docs.html">Documentation</a></li>
		<li><a href="{$base}/doc/en_US.ISO8859-1/books/faq/">FAQ</a></li>
		<li><a href="{$base}/doc/en_US.ISO8859-1/books/handbook/">Handbook</a></li>
		<li><a href="{$base}/docs/man.html">Manual Pages</a>
			<ul>
				<li><a href="{$cgibase}/man.cgi">Man Online</a></li>
			</ul>
		</li>
		<li><a href="{$base}/docs/books.html">Books and Articles Online</a></li>
		<li><a href="{$base}/publish.html">Publications</a></li>
		<li><a href="{$base}/docs/webresources.html">Web Resources</a></li>
		<li><a href="{$base}/projects/newbies.html">For Newbies</a></li>
		<li><a href="{$base}/docproj/">Documentation Project</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'download'" >
		<ul>
		<li><a href="{$base}/where.html">Get FreeBSD</a></li>
		<li><a href="{$base}/releases/">Release Information</a>
			<ul>
				<li><a href="{$u.rel.announce}">Production Release: <xsl:value-of select="$rel.current"/></a></li>
				<li><a href="{$u.rel2.announce}">Production (Legacy) Release: <xsl:value-of select="$rel2.current"/></a></li>
				<li><a href="{$base}/snapshots/">Snapshot Releases</a></li>
				<xsl:if test="$beta.testing != ''">
				  <li><a href="{$base}/where.html">Upcoming Release <xsl:value-of
				    select="concat($betarel.current, '-', $betarel.vers)"/></a>
				  </li>
				</xsl:if>
			</ul>
		</li>
		<li><a href="{$base}/ports/">Ported Applications</a></li>
		</ul>
	</xsl:if>
    	
    	<xsl:if test="$section = 'support'" >
		<ul>
		<li><a href="{$base}/support.html">Support</a></li>
		<li><a href="{$base}/commercial/">Vendors</a>
			<ul>
				<li><a href="{$base}/commercial/software_bycat.html">Software</a></li>
				<li><a href="{$base}/commercial/hardware.html">Hardware</a></li>
				<li><a href="{$base}/commercial/consult_bycat.html">Consulting</a></li>
				<li><a href="{$base}/commercial/isp.html">Internet Service Providers</a></li>
				<li><a href="{$base}/commercial/misc.html">Miscellaneous</a></li>
			</ul>
		</li>
		<li><a href="{$base}/security/">Security Information</a></li>
		<li><a href="{$base}/support/bugreports.html">Bug Reports</a>
			<ul>
				<li><a href="{$base}/send-pr.html">Submit a Problem Report</a></li>
			</ul>
		</li>
		<li><a href="{$base}/support/webresources.html">Web Resources</a></li>
		</ul>
    	</xsl:if>
	
	</div> <!-- SIDENAV -->
	
	</div> <!-- SIDEWRAP -->
  </xsl:variable>
  
  <xsl:variable name="footer">
	<div id="FOOTER">
	<xsl:copy-of select="$copyright"/><br />
	<xsl:copy-of select="$date"/>
	</div> <!-- FOOTER -->
  </xsl:variable>
   
</xsl:stylesheet>
