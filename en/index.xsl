<!-- $FreeBSD: www/en/index.xsl,v 1.142 2006/02/06 19:43:18 jcamou Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/en/index.xsl,v 1.142 2006/02/06 19:43:18 jcamou Exp $'"/>
  <xsl:variable name="title" select="'The FreeBSD Project'"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="advisories.xml" select="'none'"/>
  <xsl:param name="notices.xml" select="'none'"/>
  <xsl:param name="mirrors.xml" select="'none'"/>
  <xsl:param name="news.press.xml-master" select="'none'"/>
  <xsl:param name="news.press.xml" select="'none'"/>
  <xsl:param name="news.project.xml-master" select="'none'"/>
  <xsl:param name="news.project.xml" select="'none'"/>
  <xsl:param name="events.xml-master" select="'none'"/>
  <xsl:param name="events.xml" select="'none'"/>
  <xsl:param name="curdate.xml" select="'none'"/>

  <xsl:output type="html" encoding="iso-8859-1"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="$title"/></title>
	<meta name="description" content="The FreeBSD Project"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Ports,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="{$base}/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="{$base}/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" media="screen" href="{$base}/layout/css/fixed.css" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="{$base}/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="{$base}/layout/js/styleswitcher.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Project News" href="{$base}/news/news.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Security Advisories" href="{$base}/security/advisories.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD GNOME Project News" href="{$base}/gnome/news.rdf" />
	
	<!-- Formatted to be easy to spam harvest, please do not reformat. -->
	<xsl:comment>
        Spamtrap, do not email:
        &lt;a href="mailto:bruscar@freebsd.org"&gt;bruscar@freebsd.org&lt;/a&gt;
	</xsl:comment>
      </head>

      <body>

   <div id="CONTAINERWRAP">
    <div id="CONTAINER">
      <xsl:copy-of select="$header2"/>
      <div id="CONTENT">

        <div id="FRONTCONTAINER">
          <div id="FRONTMAIN">
            <div id="FRONTFEATURECONTAINER">

		<div id="FRONTFEATURELEFT">
			<div id="FRONTFEATURECONTENT">
				<h1>
				  Based on BSD UNIX&#174;
				</h1>
				<p>
				  FreeBSD is an advanced operating system for x86 compatible (including Pentium&#174; and Athlon&#8482;), amd64 compatible (including Opteron&#8482;, Athlon 64, and EM64T), Alpha/AXP, IA-64, PC-98 and UltraSPARC&#174; architectures. It is derived from BSD, the version of UNIX&#174; developed at the University of California, Berkeley. It is developed and maintained by a <a href="{$base}/doc/en_US.ISO8859-1/articles/contributors/index.html">large team of individuals</a>. Additional <a href="{$base}/platforms/">platforms</a> are in various stages of development.
				</p>
				<div id="TXTFRONTFEATURELINK">
				&#187;<a href="{$base}/about.html" title="Learn More">Learn More</a>
				</div> <!-- TXTFRONTFEATURELINK -->
			</div> <!-- FRONTFEATURECONTENT -->
		</div> <!-- FRONTFEATURELEFT -->

		<div id="FRONTFEATUREMIDDLE">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="{$base}/where.html">Get FreeBSD Now</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->
			
			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
				  <h2><a href="{$base}/releases/">LATEST RELEASES</a></h2>
				  <ul id="FRONTRELEASESLIST">
					<li>
					  <a href="{$u.rel.announce}">Production Release <xsl:value-of select="$rel.current"/></a>
					</li>
					<li>
					  <a href="{$u.rel2.announce}">Production (Legacy) Release <xsl:value-of select="$rel2.current"/></a>
					</li>
				    <xsl:if test="$beta.testing">
					<li>
					  <a href="{$base}/where.html#helptest">Upcoming Release
					    <xsl:value-of select="concat($betarel.current, '-', $betarel.vers)"/></a>
					</li>
				    </xsl:if>
				    <xsl:if test="$beta2.testing">
					<li>
					  <a href="{$base}/where.html#helptest">Upcoming Release
					    <xsl:value-of select="concat($betarel2.current, '-', $betarel2.vers)"/></a>
					</li>
				    </xsl:if>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="FRONTFEATURERIGHT">
			<h2 class="blockhide">Language Links</h2>
			<div id="LANGUAGENAV">
				<ul id="LANGUAGENAVLIST">
				  <li>
					<a href="{$base}/de/" title="German">de</a>
				  </li>
				  <li>
					<a href="{$base}/" title="English">en</a>
				  </li>
				  <li>
					<a href="{$base}/es/" title="Spanish">es</a>
				  </li>
				  <li>
					<a href="{$base}/fr/" title="French">fr</a>
				  </li>
				  <li>
					<a href="{$base}/it/" title="Italian">it</a>
				  </li>
				  <li>
					<a href="{$base}/ja/" title="Japanese">ja</a>
				  </li>
				  <li class="last-child">
					<a href="{$base}/ru/" title="Russian">ru</a>
				  </li>
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="MIRROR">
			  <form action="{$cgibase}/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="MIRRORSEL">Mirror</label></h2>
				  <select id="MIRRORSEL" name="goto">
					  <xsl:call-template name="html-index-mirrors-options-list">
					    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
					  </xsl:call-template>
				  </select>
				</div> <!-- unnamed -->
				<input type="submit" value="Go" />
			  </form>
			</div> <!-- MIRROR -->

			<div id="FRONTSHORTCUTS">
			  <div id="FRONTSHORTCUTSCONTENT" class="txtshortcuts">
				  <h2>SHORTCUTS</h2>
				  <ul id="FRONTSHORTCUTSLIST">
					<li>
					  <a href="{$base}/community/mailinglists.html" title="Mailing Lists">Mailing Lists</a>
					</li>
					<li>
					  <a href="{$base}/send-pr.html" title="Report a Bug">Report a Bug</a>
					</li>
					<li>
					  <a href="{$base}/doc/en_US.ISO8859-1/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/index.html" title="Handbook">Handbook</a>
					</li>
					<li>
					  <a href="http://www.freebsdfoundation.org/" title="Foundation">Foundation</a>
					</li>
					<li>
					  <a href="{$base}/ports/index.html" title="Ports">Ports</a>
					</li>

				  </ul>
			  </div> <!-- FRONTSHORTCUTSCONTENT -->
			</div> <!-- FRONTSHORTCUTS -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div><b style="display: none">.</b></div></div>
			    <div class="frontnewcontent">
			      <a href="{$base}/projects/newbies.html">New to FreeBSD?</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- FEATURERIGHT -->
				
            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="FRONTNEMSCONTAINER">
            	<div id="FRONTNEWS">
            	   <div id="FRONTNEWSCONTENT" class="txtnewsevent">
			<h2>LATEST NEWS</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="{$base}/news/newsflash.html" title="More News">More News</a>
				  </li>
				  <li class="last-child">
					<a href="{$base}/news/news.rdf" title="News RSS Feed"><img class="rssimage" src="{$base}/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTEVENTS">
		   <div id="FRONTEVENTSCONTENT" class="txtnewsevent">

			<h2>UPCOMING EVENTS</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
				<xsl:with-param name="curdate.xml" select="$curdate.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="{$base}/events/" title="More Events">More Events</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTMEDIA">
		   <div id="FRONTMEDIACONTENT" class="txtnewsevent">

			<h2>IN THE MEDIA</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="{$base}/news/press.html" title="More Media">More Media</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
            	</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="FRONTSECURITY">
		   <div id="FRONTSECURITYCONTENT" class="txtnewsevent">

			<h2>SECURITY ADVISORIES</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="{$base}/security/" title="More Security Advisories">More</a>
				  </li>
				  <li class="last-child">
					<a href="{$base}/security/advisories.rdf" title="Security Advisories RSS Feed"><img class="rssimage" src="{$base}/layout/images/ico_rss.png" width="27" height="12" alt="Security Advisories RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>ERRATA NOTICES</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			</xsl:call-template>

			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTSECURITYCONTENT -->
            	</div> <!-- FRONTSECURITY -->

		<br class="clearboth" />

            </div> <!-- FRONTNEMSCONTAINER -->
          </div> <!-- FRONTMAIN -->
        </div> <!-- FRONTCONTAINER -->

      </div> <!-- CONTENT -->
      <div id="FOOTER">
        <xsl:copy-of select="$copyright"/><br />
        <xsl:copy-of select="$date"/>
      </div> <!-- FOOTER -->
    </div> <!-- CONTAINER -->
   </div> <!-- CONTAINERWRAP -->

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
