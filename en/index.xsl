<!-- $FreeBSD: www/en/index.xsl,v 1.66 2003/06/28 18:21:45 rushani Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/en/index.xsl,v 1.66 2003/06/28 18:21:45 rushani Exp $'"/>
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
		<img src="gifs/freebsd_1.gif" height="94" width="306"
		     alt="FreeBSD: The Power to Serve" border="0"/></a></td>
	    
	    <td align="right" valign="bottom">
	      <form action="http://www.FreeBSD.org/cgi/mirror.cgi" 
		    method="get">
		
		<br/>
		
		<font color="#990000"><b>Select a server near you:</b></font>
		
		<br/>
	      
		<select name="goto">
		  <!--  Only list TRUE mirrrors here! Native language pages 
		        which are not mirrored should be listed in
		        support.sgml.  -->

		  <option value="http://www2.at.FreeBSD.org/">IPv6 Austria</option>
		  <option value="http://www.dk.FreeBSD.org/">IPv6 Denmark</option>
		  <option value="http://www2.de.FreeBSD.org">IPv6 Germany</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">IPv6 (6Bone) Japan</option>
		  <option value="http://www2.no.FreeBSD.org/">IPv6 Norway</option>
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
		  <option value="http://freebsd.unixtech.be/">Belgium</option>
		  <option value="http://www.br.FreeBSD.org/www.freebsd.org/">Brazil/1</option>
		  <option value="http://www2.br.FreeBSD.org/www.freebsd.org/">Brazil/2</option>
		  <option value="http://www3.br.FreeBSD.org/">Brazil/3</option>
		  <option value="http://www.bg.FreeBSD.org/">Bulgaria</option>
		  <option value="http://www.ca.FreeBSD.org/">Canada</option>
		  <option value="http://www2.ca.FreeBSD.org/">Canada/2</option>
		  <!--
		  <option value="http://www3.ca.FreeBSD.org/">Canada/3</option>
		  -->
		  <option value="http://www.cn.FreeBSD.org/">China</option>
		  <option value="http://www.cz.FreeBSD.org/">Czech Republic</option>
		  <!--
		  <option value="http://www2.cz.FreeBSD.org/">Czech Republic/2</option>
		  -->
		  <option value="http://www.dk.FreeBSD.org/">Denmark/1</option>
		  <option value="http://www3.dk.FreeBSD.org/">Denmark/3</option>
		  <option value="http://www.ee.FreeBSD.org/">Estonia</option>
		  <option value="http://www.fi.FreeBSD.org/">Finland</option>
		  <option value="http://www2.fi.FreeBSD.org/">Finland/2</option>
		  <option value="http://www.fr.FreeBSD.org/">France</option>
		  <option value="http://www.de.FreeBSD.org/">Germany/1</option>
		  <option value="http://www1.de.FreeBSD.org/">Germany/2</option>
		  <option value="http://www2.de.FreeBSD.org/">Germany/3</option>
		  <option value="http://www.gr.FreeBSD.org/">Greece</option>
		  <option value="http://www.hk.FreeBSD.org/">Hong Kong</option>
		  <option value="http://www.hu.FreeBSD.org/">Hungary/1</option>
		  <option value="http://www2.hu.FreeBSD.org/">Hungary/2</option>
		  <option value="http://www.is.FreeBSD.org/">Iceland</option>
		  <option value="http://www.ie.FreeBSD.org/">Ireland/1</option>
		  <option value="http://www2.ie.FreeBSD.org/">Ireland/2</option>
		  <option value="http://www.it.FreeBSD.org/">Italy/1</option>
		  <option value="http://www.gufi.org/mirrors/www.freebsd.org/data/">Italy/2</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">Japan</option>
		  <option value="http://www.kr.FreeBSD.org/">Korea</option>
		  <option value="http://www2.kr.FreeBSD.org/">Korea/2</option>
		  <option value="http://www3.kr.FreeBSD.org/">Korea/3</option>
		  <option value="http://www.lv.FreeBSD.org/">Latvia</option>
		  <option value="http://www.lt.FreeBSD.org/">Lithuania</option>
		  <option value="http://www.nl.FreeBSD.org/">Netherlands/1</option>
		  <option value="http://www2.nl.FreeBSD.org/">Netherlands/2</option>
		  <option value="http://www.nz.FreeBSD.org/">New Zealand</option>
		  <option value="http://www.no.FreeBSD.org/">Norway/1</option>
		  <option value="http://www2.no.FreeBSD.org/">Norway/2</option>
		  <option value="http://www.FreeBSD.org.ph/">Philippines</option>
		  <option value="http://www.pl.FreeBSD.org/">Poland/1</option>
		  <option value="http://www2.pl.FreeBSD.org/">Poland/2</option>
		  <!--
		  <option value="http://www.pt.FreeBSD.org/">Portugal/1</option>
		  -->
		  <option value="http://www2.pt.FreeBSD.org/">Portugal/2</option>
		  <option value="http://www4.pt.FreeBSD.org/">Portugal/4</option>
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
		  <option value="http://www.sk.FreeBSD.org/">Slovak Republic/1</option>
		  <option value="http://www2.sk.FreeBSD.org/">Slovak Republic/2</option>
		  <option value="http://www.si.FreeBSD.org/">Slovenia/1</option>
		  <option value="http://www2.si.FreeBSD.org/">Slovenia/2</option>
		  <option value="http://www.es.FreeBSD.org/">Spain/1</option>
		  <option value="http://www2.es.FreeBSD.org/">Spain/2</option>
		  <option value="http://www3.es.FreeBSD.org/">Spain/3</option>
		  <option value="http://www.za.FreeBSD.org/">South Africa/1</option>
		  <option value="http://www2.za.FreeBSD.org/">South Africa/2</option>
		  <option value="http://www.se.FreeBSD.org/">Sweden/1</option>
		  <option value="http://www2.se.FreeBSD.org/">Sweden/2</option>
		  <option value="http://www.ch.FreeBSD.org/">Switzerland/1</option>
		  <option value="http://www2.ch.FreeBSD.org/">Switzerland/2</option>
		  <option value="http://www.tw.FreeBSD.org/">Taiwan/1</option>
		  <option value="http://www2.tw.FreeBSD.org/">Taiwan/2</option>
		  <option value="http://www3.tw.FreeBSD.org/">Taiwan/3</option>
		  <option value="http://www4.tw.FreeBSD.org/">Taiwan/4</option>
		  <option value="http://www.tr.FreeBSD.org/">Turkey/1</option>
		  <option value="http://www2.tr.FreeBSD.org/">Turkey/2</option>
		  <option value="http://www.enderunix.org/freebsd/">Turkey/3</option>
		  <option value="http://www.ua.FreeBSD.org/">Ukraine/1</option>
		  <option value="http://www2.ua.FreeBSD.org/">Ukraine/2</option> 
		  <option value="http://www4.ua.FreeBSD.org/">Ukraine/Crimea</option> 
		  <option value="http://www5.ua.FreeBSD.org/">Ukraine/5</option> 
		  <option value="http://www.uk.FreeBSD.org/">United Kingdom/1</option>
		  <option value="http://www2.uk.FreeBSD.org/">United Kingdom/2</option>
		  <option value="http://www3.uk.FreeBSD.org/">United Kingdom/3</option>
		  <option value="http://www4.uk.FreeBSD.org/">United Kingdom/4</option>
		  <option value="http://www.FreeBSD.org/">USA/California</option>
		  <option value="http://www3.FreeBSD.org/">USA/3</option>
		  <option value="http://www7.FreeBSD.org/">USA/7</option>
		</select>
		
		<input type="submit" value=" Go "/>
		
		<br/>
		
		<font color="#990000"><b>Language: </b></font> 
		<a href="it/index.html">Italian</a>, 
		<a href="ja/index.html">Japanese</a>, 
		<a href="ru/index.html">Russian</a>, 
		<a href="es/index.html">Spanish</a>, 
		<a href="support.html#web">Other</a>
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
			  <p><font size="+1" color="#990000"><b>News</b></font>

	      
			    <small><br/>
			      &#183; <a href="news/newsflash.html">Announcements</a><br/>
			      &#183; <a href="news/press.html">In the Press</a><br/>
			      &#183; <a href="news/index.html">More ...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Software</b></font>
			    <small><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/mirrors.html">Getting FreeBSD</a><br/>
			      &#183; <a href="releases/index.html">Release Information</a><br/>
			      &#183; <a href="{$base}/ports/index.html">Ported Applications</a><br/>
			    </small></p>
	    
			  <p><font size="+1" color="#990000"><b>Documentation</b></font>
		
			    <small><br/>
			      &#183; <a href="projects/newbies.html">For Newbies</a><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/index.html">Handbook</a><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/faq/index.html">FAQ</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/man.cgi">Manual pages</a><br/>
			      &#183; <a href="{$base}/docproj/index.html">Doc. Project</a><br/>
			      &#183; <a href="docs.html">More...</a><br/>
			    </small></p>
			  
			  <p><font size="+1" color="#990000"><b>Support</b></font>
	      
			    <small><br/>
			      &#183; <a href="{$base}/support.html#mailing-list">Mailing lists</a><br/>
			      &#183; <a href="{$base}/support.html#newsgroups">Newsgroups</a><br/>
			      &#183; <a href="{$base}/support.html#user">User Groups</a><br/>
			      &#183; <a href="{$base}/support.html#web">Web Resources</a><br/>
			      &#183; <a href="security/index.html">Security</a><br/>
			      &#183; <a href="{$base}/support.html">More...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Bug Reports</b></font>
			    <small><br/>
			      &#183; <a href="send-pr.html">Send a bug report</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr-summary.cgi">View open reports</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr.cgi">Search by bug ID</a><br/>
			      &#183; <a href="{$base}/support.html#gnats">More...</a><br/>
			    </small></p>

	      
			  <p><font size="+1" color="#990000"><b>Development</b></font>
		
			    <small><br/>
			      &#183; <a href="projects/index.html">Projects</a><br/>
			      &#183; <a href="releng/index.html">Release Engineering</a><br/>
			      &#183; <a href="{$base}/support.html#cvs">CVS Repository</a><br/>
			    </small></p>
	      
			  <p><font size="+1" color="#990000"><b>Vendors</b></font>
			    
			    <small><br/>
			      &#183; <a href="{$base}/commercial/software_bycat.html">Software</a><br/>
			      &#183; <a href="{$base}/commercial/hardware.html">Hardware</a><br/>
			      &#183; <a href="{$base}/commercial/consulting_bycat.html">Consulting</a><br/>
			      &#183; <a href="{$base}/commercial/misc.html">Misc</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Donations</b></font>
			    <small><br/>
			      &#183; <a href="{$base}/donations/index.html">Donations Liaison</a><br/>
			      &#183; <a href="{$base}/donations/donors.html">Current Donations</a><br/>
			      &#183; <a href="{$base}/donations/wantlist.html">List of needs</a><br/>
			    </small></p>
	      
			  <p><font size="+1" color="#990000"><b>This Site</b></font>
		
			    <small><br/>
			      &#183; <a href="{$base}/search/index-site.html">Site Map</a><br/>
			      &#183; <a href="{$base}/search/search.html">Search</a><br/>
			      &#183; <a href="internal/index.html">More ...</a><br/>
			    </small></p>
	      
			  <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
			    <small>Search for:<br/>
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
	      <h2><font color="#990000">What is FreeBSD?</font></h2>
	
	      <p>FreeBSD is an advanced operating system for
		x86 compatible, DEC Alpha, IA-64, PC-98 and UltraSPARC architectures.
		It is derived from BSD, the version of <xsl:value-of select="$unix"/>
	        developed at 
		the University of California, Berkeley.
		It is developed and maintained by 
		<a
		href="{$base}/doc/en_US.ISO8859-1/articles/contributors/index.html">a
		large team of individuals</a>. Additional
		<a href="{$base}/platforms/index.html">platforms</a> are in
		various stages of development.</p>
	      
	      <h2><font color="#990000">Cutting edge features</font></h2>
	      
	      <p>FreeBSD offers advanced networking, performance, security
		and compatibility 
		<a href="{$base}/features.html">features</a>
		today which are still missing in other operating systems,
		even some of the best commercial ones.</p>
	      
	      <h2><font color="#990000">Powerful Internet solutions</font></h2>
	      
	      <p>FreeBSD makes an ideal 
		<a href="{$base}/internet.html">Internet or Intranet</a> 
		server. It provides robust network services under the heaviest
		loads and uses memory efficiently to maintain good response
		times for thousands of simultaneous user processes. Visit our
		<a href="gallery/gallery.html">gallery</a> for examples of
		FreeBSD powered applications and services.</p>
	    
	      <h2><font color="#990000">Run a huge number of
		  applications</font></h2>
	    
	      <p>The quality of FreeBSD combined with today's low-cost,
		high-speed PC hardware makes FreeBSD a very economical
		alternative to commercial  <xsl:value-of select="$unix"/>
	        workstations.  It is well-suited
		for a great number of both desktop and server 
		<a href="{$base}/applications.html">applications</a>.</p>
	    
	      <h2><font color="#990000">Easy to install</font></h2>
	    
	      <p>FreeBSD can be installed from a variety of media including
		CD-ROM, DVD-ROM, floppy disk, magnetic tape, a MS-DOS&#174; partition, or if
		you have a network connection, you can install it
		<i>directly</i> over anonymous FTP or NFS. All you need is a 
		pair of blank, 1.44MB floppies and 
		<a href="{$base}/doc/en_US.ISO8859-1/books/handbook/install.html">these 
		  directions</a>.</p>

	      <h2><font color="#990000">FreeBSD is <i>free</i></font></h2>
	    
	      <a href="copyright/daemon.html"><img src="gifs/dae_up3.gif" 
						   alt=""
						   height="81" width="72" 
						   align="right" 
						   border="0"/></a>
	      
	      <p>While you might expect an operating system with these 
		features to sell for a high price, FreeBSD is available 
		<a href="{$base}/copyright/index.html">free of charge</a>
		and comes with full source code. If you would like to try it
		out, 
		<a href="{$base}/doc/en_US.ISO8859-1/books/handbook/mirrors.html">more 
		  information is available</a>.</p>
	      
	      <h2><font color="#990000">Contributing to FreeBSD</font></h2>
	      
	      <p>It is easy to contribute to FreeBSD. All you need to do
		is find a part of FreeBSD which you think could be
		improved and make those changes (carefully and cleanly)
		and submit that back to the Project by means of send-pr
		or a committer, if you know one.  This could be anything
		from documentation to artwork to source code. See the 
		<a href="{$base}/doc/en_US.ISO8859-1/articles/contributing/index.html">Contributing
		to FreeBSD</a> article for more information.</p>

		<p>Even if you're not a programmer, there are other ways to
 		contribute to FreeBSD. The FreeBSD Foundation is a
		non-profit organization for which direct contributions
		are fully tax deductible.  Please contact
		<a href="mailto:bod@FreeBSDFoundation.org">bod@FreeBSDFoundation.org</a>
		for more information or write to: The FreeBSD Foundation,
		7321 Brockway Dr.  Boulder, CO 80303.  USA</p>

		<p>Silicon Breeze has also sculpted and cast the BSD Daemon
		in metal and is now donating 15% of all proceeds from
		these statuettes back to the FreeBSD Foundation. The complete
		story and information on how to order a BSD Daemon is
		available from
 		<a href="http://www.linuxjewellery.com/beastie/">this page.</a>
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
			<td valign="top"><p><font size="+1" color="#990000"><b>New Technology Release:
			    <xsl:value-of select="$rel.current"/></b></font><br/>
			
			    <small>&#183; <a href="{$u.rel.announce}">Announcement</a><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/install.html">Installation Guide</a><br/>
			      &#183; <a href="{$u.rel.notes}">Release Notes</a><br/>
			      &#183; <a href="{$u.rel.hardware}">Hardware Notes</a><br/>
			      &#183; <a href="{$u.rel.errata}">Errata</a><br/>
			      &#183; <a href="{$u.rel.early}">Early Adopter's Guide</a></small></p>

			  <p><font size="+1" color="#990000"><b>Production Release:
			    <xsl:value-of select="$rel2.current"/></b></font><br/>
			
			    <small>&#183; <a href="{$u.rel2.announce}">Announcement</a><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/install.html">Installation Guide</a><br/>
			      &#183; <a href="{$u.rel2.notes}">Release Notes</a><br/>
			      &#183; <a href="{$u.rel2.hardware}">Hardware Notes</a><br/>
			      &#183; <a href="{$u.rel2.errata}">Errata</a></small></p>

			  <p><font size="+1" color="#990000"><b>Project News</b></font><br/>
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
			      <a href="news/newsflash.html">More...</a>
			    </font></p>
			  
			  <p><font size="+1" color="#990000"><b>FreeBSD Press</b></font><br/>

			    <font size="-1">
			      Latest update: 
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
			      <a href="news/press.html">More...</a>
			    </font>
			  </p>

			  <p><font size="+1" color="#990000"><b>Security Advisories</b></font><br/>

			    <font size="-1">
			      Latest update: 
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
			      <a href="security/">More...</a>
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
			<td>To learn more about FreeBSD, visit our gallery of 
			  FreeBSD related 
			  <a href="{$base}/publish.html">publications</a> or 
			  <a href="news/press.html">FreeBSD in the press</a>,
			  and browse through this website!</td>
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

	<p><small>Changes to the web site go live at 0800 and 2000 UTC every
	    day.</small></p>
    
	<table width="100%" cellpadding="0" border="0" cellspacing="0">
	  <tr>
	    <td align="left" 
		valign="top"><small><a href="{$base}/mailto.html">Contact 
		  us</a><br/>
		<xsl:value-of select="$date"/></small></td>

	    <td align="right" 
		valign="top"><small><a href="copyright/index.html">Legal</a><br/> &#169; 1995-2003
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
