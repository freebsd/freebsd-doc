<!-- $FreeBSD: www/en/index.xsl,v 1.91 2004/01/02 14:07:33 blackend Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/en/index.xsl,v 1.91 2004/01/02 14:07:33 blackend Exp $'"/>
  <xsl:variable name="title" select="'The FreeBSD Project'"/>

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
		  <!--  Only list TRUE mirrors here! Native language pages 
		        which are not mirrored should be listed in
		        support.sgml.  -->

		  <xsl:call-template name="html-index-mirrors-options-list">
		    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
		  </xsl:call-template>
		</select>
		
		<input type="submit" value=" Go "/>
		
		<br/>
		
		<font color="#990000"><b>Language: </b></font> 
		<a href="{$base}/de/index.html" title="German">[de]</a>
		<xsl:text>&#160;</xsl:text>
		<span title="English">[en]</span>
		<xsl:text>&#160;</xsl:text>
		<a href="{$base}/es/index.html" title="Spanish">[es]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$base}/fr/index.html" title="French">[fr]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$base}/it/index.html" title="Italian">[it]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$base}/ja/index.html" title="Japanese">[ja]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$base}/ru/index.html" title="Russian">[ru]</a>
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
			  <p>
			    <a href="platforms/index.html">
			      <font size="+1" color="#990000"><b>Platforms</b></font>
			    </a><small><br/>
			      &#183; <a href="smp/index.html">i386</a><br/>
			      &#183; <a href="platforms/alpha.html">Alpha</a><br/>
			      &#183; <a href="platforms/ia64/index.html">IA-64</a><br/>
			      &#183; <a href="platforms/amd64.html">AMD64</a><br/>
			      &#183; <a href="platforms/sparc.html">Sparc64</a><br/>
			      &#183; <a href="platforms/index.html">More?</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Software</b></font>
			    <small><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/mirrors.html">Getting FreeBSD</a><br/>
			      &#183; <a href="releases/index.html">Release Information</a><br/>
			      &#183; <a href="{$base}/ports/index.html">Ported Applications</a><br/>
			    </small></p>
	    
			  <p>
			    <a href="docs.html">
			      <font size="+1" color="#990000"><b>Documentation</b></font>
			    </a><small><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/faq/index.html">FAQ</a><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/index.html">Handbook</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/man.cgi">Manual pages</a><br/>
			      &#183; <a href="projects/newbies.html">For Newbies</a><br/>
			      &#183; <a href="{$base}/docproj/index.html">Doc. Project</a><br/>
			    </small></p>
			  
			  <p>
			    <a href="support.html">
			      <font size="+1" color="#990000"><b>Support</b></font>
			    </a><small><br/>
			      &#183; <a href="{$base}/support.html#mailing-list">Mailing lists</a><br/>
			      &#183; <a href="{$base}/support.html#newsgroups">Newsgroups</a><br/>
			      &#183; <a href="{$base}/support.html#user">User Groups</a><br/>
			      &#183; <a href="{$base}/support.html#web">Web Resources</a><br/>
			      &#183; <a href="security/index.html">Security</a><br/>
			    </small></p>

			  <p>
			    <a href="{$base}/support.html#gnats">
			      <font size="+1" color="#990000"><b>Bug Reports</b></font>
			    </a><small><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr-summary.cgi?query">Search</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr.cgi">View one bug report</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr-summary.cgi">View all bug reports</a><br/>
			      &#183; <a href="send-pr.html">Send a bug report</a><br/>
			      &#183; <a href="doc/en_US.ISO8859-1/articles/problem-reports/article.html">Writing Bug Reports</a><br/>
			    </small></p>

	      
			  <p>
			    <a href="projects/index.html">
			      <font size="+1" color="#990000"><b>Development</b></font>
			    </a><small><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/developers-handbook">Developer's Handbook</a><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/porters-handbook">Porter's Handbook</a><br/>
			      &#183; <a href="{$base}/support.html#cvs">CVS Repository</a><br/>
			      &#183; <a href="releng/index.html">Release Engineering</a><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/articles/contributing/index.html">Contributing to FreeBSD</a><br/>
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

			  <p>
			    <a href="{$base}/search/index-site.html">
			      <font size="+1" color="#990000"><b>This Site</b></font>
			    </a><small><br/>
			      &#183; <a href="{$base}/search/search.html#web">Search Website</a><br/>
			      &#183; <a href="{$base}/search/search.html#mailinglists">Search Mailing Lists</a><br/>
			      &#183; <a href="{$base}/search/search.html">Search All</a><br/>
			    </small></p>

			  <p>
			    <a href="mailto.html">
			      <font size="+1" color="#990000"><b>Contacting FreeBSD</b></font>
			    </a>
			  </p>

			  <p>
			    <a href="copyright/index.html">
			      <font size="+1" color="#990000"><b>The BSD Copyright</b></font>
			    </a>
			  </p>

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
		x86 compatible, AMD64, DEC Alpha, IA-64, PC-98 and UltraSPARC&#174; architectures.
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
		CD-ROM, DVD-ROM, floppy disk, magnetic tape, an MS-DOS&#174; partition, or if
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

		<p>Even if you are not a programmer, there are other ways to
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
			<td valign="top"><p>
			      <a href="{$u.rel.early}">
			      <font size="+1" color="#990000"><b>New Technology Release:
			    <xsl:value-of select="$rel.current"/></b></font></a><br/>
			    <small>&#183; <a href="{$u.rel.announce}">Announcement</a><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/install.html">Installation Guide</a><br/>
			      &#183; <a href="{$u.rel.notes}">Release Notes</a><br/>
			      &#183; <a href="{$u.rel.hardware}">Hardware Notes</a><br/>
			      &#183; <a href="{$u.rel.errata}">Errata</a><br/>
			      &#183; <a href="{$u.rel.early}">Early Adopter's Guide</a></small></p>

			<p>
			      <a href="{$u.rel2.announce}">
			      <font size="+1" color="#990000"><b>Production Release:
			    <xsl:value-of select="$rel2.current"/></b></font></a><br/>
			
			    <small>&#183; <a href="{$u.rel2.announce}">Announcement</a><br/>
			      &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/install.html">Installation Guide</a><br/>
			      &#183; <a href="{$u.rel2.notes}">Release Notes</a><br/>
			      &#183; <a href="{$u.rel2.hardware}">Hardware Notes</a><br/>
			      &#183; <a href="{$u.rel2.errata}">Errata</a></small></p>

			  <p><font size="+1" color="#990000"><b>Project News</b></font><br/>
			    <font size="-1">
			      Latest update: 
			      <xsl:call-template name="html-index-news-project-items-lastmodified">
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			      </xsl:call-template>

			      <br/>

			      <xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			      </xsl:call-template>

			      <a href="news/newsflash.html">More...</a>
			    </font></p>
			  
			  <p><font size="+1" color="#990000"><b>FreeBSD Press</b></font><br/>

			    <font size="-1">
			      Latest update: 
			      <xsl:call-template name="html-index-news-press-items-lastmodified">
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			      </xsl:call-template>

			      <br/>

			      <xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			      </xsl:call-template>

			      <a href="news/press.html">More...</a>
			    </font>
			  </p>

			  <p><font size="+1" color="#990000"><b>Security Advisories</b></font><br/>

			    <font size="-1">
			      Latest update: 
			      <xsl:call-template name="html-index-advisories-items-lastmodified">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
			      </xsl:call-template>

			      <br/>

			      <xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
			      </xsl:call-template>

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

	<table width="100%" cellpadding="0" border="0" cellspacing="0">
	  <tr>
	    <td align="left" 
		valign="top"><small><a href="{$base}/mailto.html">Contact 
		  us</a><br/>
		<xsl:value-of select="$date"/></small></td>

	    <td align="right" 
		valign="top"><small><a href="copyright/index.html">Legal</a><br/> &#169; 1995-2004
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
