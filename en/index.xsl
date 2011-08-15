<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>

<!-- $FreeBSD: www/en/index.xsl,v 1.172 2011/06/12 08:45:47 simon Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

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

  <xsl:output type="html" encoding="&xml.encoding;"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title>&title;</title>
	<meta name="description" content="The FreeBSD Project"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Ports,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="&base;/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="&base;/favicon.ico" type="image/x-icon"/>
<!--
	FOR TRANSLATORS:

	Do not translate the "Normal Text" and "Large Text" attributes in the
	following two lines.  They are not literal texts but JavaScript
	parameters.  Changing them will result in rendering errors.
-->
    <link rel="stylesheet" media="screen" href="&base;/layout/css/fixed.css?20060509" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="&base;/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="&base;/layout/js/styleswitcher.js"></script>
    <script type="text/javascript" src="&base;/layout/js/google.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Project News" href="&base;/news/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Security Advisories" href="&base;/security/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD GNOME Project News" href="&base;/gnome/rss.xml" />

	<!-- Formatted to be easy to spam harvest, please do not reformat. -->
	<xsl:comment>
        Spamtrap, do not email:
        &lt;a href="mailto:bruscar@freebsd.org"&gt;bruscar@freebsd.org&lt;/a&gt;
	</xsl:comment>
      </head>

      <body>

   <div id="CONTAINERWRAP">
    <div id="CONTAINER">
      &header2;
      <div id="CONTENT">

        <div id="FRONTCONTAINER">
          <div id="FRONTMAIN">
            <div id="FRONTFEATURECONTAINER">

		<div id="FRONTFEATURELEFT">
			<div id="FRONTFEATURECONTENT">
				<h1>
				  Based on BSD &unix;
				</h1>

				<p>FreeBSD&reg; is an advanced
				  operating system for modern server,
				  desktop, and embedded computer <a
				  href="&base;/platforms/">platforms</a>.
				  FreeBSD's code base has undergone
				  over thirty years of continuous
				  development, improvement, and
				  optimization.  It is developed and
				  maintained by a <a
				  href="&base;/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">large
				  team of individuals</a>.  FreeBSD
				  provides advanced networking,
				  impressive security features, and
				  world class performance and is used
				  by some of the world's <a
				  href="&base;/doc/en_US.ISO8859-1/books/handbook/nutshell.html#INTRODUCTION-NUTSHELL-USERS">busiest
				  web sites</a> and most pervasive
				  embedded networking and storage
				  devices.</p>

                                  <div
				  id="TXTFRONTFEATURELINK"> &#187;<a
				  href="&base;/about.html"
				  title="Learn More">Learn More</a>

				  </div> <!-- TXTFRONTFEATURELINK -->
			  </div> <!-- FRONTFEATURECONTENT -->
		  </div> <!-- FRONTFEATURELEFT -->

		<div id="FRONTFEATUREMIDDLE">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">Get FreeBSD Now</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
				  <h2><a href="&base;/releases/">LATEST RELEASES</a></h2>
				  <ul id="FRONTRELEASESLIST">
					<li>
					  <a href="&u.rel.announce;">Production Release &rel.current;</a>
					</li>
					<li>
					  <a href="&u.rel2.announce;">Production (Legacy) Release &rel2.current;</a>
					</li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">Upcoming Release
				            &betarel.current; - &betarel.vers;</a>
					</li>
			    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">Upcoming Release
				            &betarel2.current; - &betarel2.vers;</a>
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
					<a href="&base;/de/" title="German">de</a>
				  </li>
				  <li>
					<a href="&base;/" title="English">en</a>
				  </li>
				  <li>
					<a href="&base;/es/" title="Spanish">es</a>
				  </li>
				  <li>
					<a href="&base;/fr/" title="French">fr</a>
				  </li>
				  <li>
					<a href="&base;/hu/" title="Hungarian">hu</a>
				  </li>
				  <li>
					<a href="&base;/it/" title="Italian">it</a>
				  </li>
				  <li>
					<a href="&base;/ja/" title="Japanese">ja</a>
				  </li>
				  <li>
					<a href="&base;/nl/" title="Dutch">nl</a>
				  </li>
				  <li>
					<a href="&base;/ru/" title="Russian">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&base;/zh_CN/" title="Chinese (Simplified)">zh_CN</a>
				  </li>
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="MIRROR">
			  <form action="&cgibase;/mirror.cgi" method="get">
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
					  <a href="&base;/community/mailinglists.html" title="Mailing Lists">Mailing Lists</a>
					</li>
					<li>
					  <a href="&base;/support/bugreports.html" title="Report a Bug">Report a Bug</a>
					</li>
					<li>
					  <a href="&base;/doc/en_US.ISO8859-1/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="&base;/doc/en_US.ISO8859-1/books/handbook/index.html" title="Handbook">Handbook</a>
					</li>
					<li>
					  <a href="&base;/ports/index.html" title="Ports">Ports</a>
					</li>

				  </ul>
			  </div> <!-- FRONTSHORTCUTSCONTENT -->
			</div> <!-- FRONTSHORTCUTS -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div><b style="display: none">.</b></div></div>
			    <div class="frontnewcontent">
			      <a href="&base;/projects/newbies.html">New to FreeBSD?</a>
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
					<a href="&base;/news/newsflash.html" title="More News">More News</a>
				  </li>
				  <li class="last-child">
					<a href="&base;/news/rss.xml" title="News RSS Feed"><img class="rssimage" src="&base;/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
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
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&base;/events/" title="More Events">More Events</a>
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
					<a href="&base;/news/press.html" title="More Media">More Media</a>
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
					<a href="&base;/security/advisories.html" title="More Security Advisories">More</a>
				  </li>
				  <li class="last-child">
					<a href="&base;/security/rss.xml" title="Security Advisories RSS Feed"><img class="rssimage" src="&base;/layout/images/ico_rss.png" width="27" height="12" alt="Security Advisories RSS Feed" /></a>
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

			  <div>
			    	<ul class="newseventslist">
				  <li class="first-child">
				    <a href="&base;/security/notices.html" title="More Errata Notices">More</a>
				  </li>
				  <li class="last-child">
				    <a href="&base;/security/errata.xml" title="Errata Notices RSS Feed"><img class="rssimage" src="&base;/layout/images/ico_rss.png" width="27" height="12" alt="Errata Notices RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTSECURITYCONTENT -->
            	</div> <!-- FRONTSECURITY -->

		<br class="clearboth" />

            </div> <!-- FRONTNEMSCONTAINER -->
          </div> <!-- FRONTMAIN -->
        </div> <!-- FRONTCONTAINER -->

      </div> <!-- CONTENT -->
      <div id="FOOTER">
	&copyright;

	The mark FreeBSD is a registered trademark of The FreeBSD
	Foundation and is used by The FreeBSD Project with the
	permission of <a
	  href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">The
	FreeBSD Foundation</a>.

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
