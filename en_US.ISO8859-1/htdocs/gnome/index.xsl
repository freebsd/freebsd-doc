<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/xml/xslt10-freebsd.dtd" [
<!ENTITY base "..">
<!ENTITY title "The FreeBSD GNOME Project">
]>
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdf1="http://my.netscape.com/rdf/simple/0.9/"
		xmlns="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="rdf rdf1" version="1.0">

  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/xml/xhtml.xsl"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.content">
              <div id="sidewrap">
                &nav.gnome;
              </div> <!-- SIDEWRAP -->

	      <div id="contentwrap">
		<div id="rightwrap">
		  <div class="rightnav">

		    <h2>FreeBSD GNOME News</h2>

		    <p>Latest update:
		      <xsl:value-of
			select="descendant::month[position() = 1]/name"/>
		      <xsl:text> </xsl:text>
		      <xsl:value-of
			select="descendant::day[position() = 1]/name"/>,
		      <xsl:text> </xsl:text>
		      <xsl:value-of
			select="descendant::year[position() = 1]/name"/></p>
		    <ul>

		      <!-- Pull in the 10 most recent news items -->
		      <xsl:for-each select="descendant::event[position() &lt;= 10]">
			<li><a>
			    <xsl:attribute name="href">
			      newsflash.html#<xsl:call-template name="generate-event-anchor"/>
			    </xsl:attribute>
			    <xsl:choose>
			      <xsl:when test="count(child::title)">
				<xsl:value-of select="title"/><br/>
			      </xsl:when>
			      <xsl:otherwise>
				<xsl:apply-templates select="p" mode="copy.html"/><br/>
			      </xsl:otherwise>
			    </xsl:choose>
			  </a></li>
		      </xsl:for-each>
		      <li><a href="newsflash.html">More...</a></li>
		    </ul>
		  </div> <!-- rightnav -->

		  <br />

		  <div class="rightnav">

		    <h2>GNOME Project News</h2>
<!-- XXX: (1) does not work at the moment
          (2) should we really copy over GNOME news?

		    <ul>
		      <xsl:for-each select="document('http://gnomedesktop.org/node/feed')/rss/channel/*[name() = 'item'][position() &lt; 10]">
			<li><a>
			    <xsl:attribute name="href">
			      <xsl:value-of select="link"/>
			    </xsl:attribute>
			    <xsl:value-of select="title"/><br/>
			  </a></li>
		      </xsl:for-each>
		      <li><a>
			  <xsl:for-each select="document('http://gnomedesktop.org/backend.php')/rss/*[name() = 'channel'][position() = 1]">
			    <xsl:attribute name="href">
			      <xsl:value-of select="link"/>
			    </xsl:attribute>More...
			  </xsl:for-each>
			</a></li>
		    </ul>
-->
                  </div> <!-- rightnav -->
                </div> <!-- rightwrap -->

		<h1>&title;</h1>

		<h2>What is GNOME?</h2>

		<img src="&base;/gnome/images/gnome.png" align="right"
                   border="0" alt="GNOME Logo"/>

	       		<p>GNOME is a complete graphical desktop for X,
	       	   including everything from a window manager to
	       	   web browsers, audio players, office programs, and
	       	   more.</p>

		       <p>The &os; GNOME Project is a team of devoted
			 developers and users that manage the
			 integration of GNOME and &os;.</p>

		<h2>How to install GNOME</h2>

		<p>The easiest way to install GNOME is to install either of
		the following ports:</p>
		<ul>
			<li>x11/gnome2 (the full desktop)</li>
			<li>x11/gnome2-lite (the minimum desktop environment)</li>
		</ul>

		<p>And, as desired, one or all of:</p>
		<ul>
			<li>x11/gnome2-fifth-toe (common applications)</li>
			<li>x11/gnome2-power-tools (tools/toys for power users)</li>
			<li>editors/gnome2-office (office productivity)</li>
			<li>devel/gnome2-hacker-tools (development tools)</li>
		</ul>

		<h2>Upgrading to GNOME 2.32?</h2>

		<p>If you are upgrading from GNOME 2.30 to GNOME 2.32, read the
		  <a href="docs/faq232.html">Upgrade FAQ</a> for upgrade
		  instructions.</p>

              <h2>State of the port</h2>

	      <p>GNOME for &os; is currently fully supported on
		8.4, 8-STABLE, 9.1, 9.2, and 9-STABLE, 10.0 and 10-STABLE while
                11.0-CURRENT is provided on a best effort basis.
		Work is being done to replace Gnome 2 with Mate and Gnome3.  
		There is still <a href="docs/volunteer.html">plenty left to be done</a>!</p>

	      <h2>One stop solution shop!</h2>

	      <p>GNOME is simple and easy to build using the &os; ports system, but
	        sometimes things simply go wrong. If GNOME -- or anything that uses
		GNOME libraries -- is not building the way it should, simply run the
		<a href="/gnome/gnomelogalyzer.sh">gnomelogalyzer.sh</a>
		tool from the directory of the failed port, and let the gnomelogalyzer
		figure out what's wrong and how to fix it!</p>

		<h2>Resources</h2>
		<ul>
		  <li><a href="http://www.gnome.org/">GNOME Project</a></li>
		  <li><a href="http://developer.gnome.org">GNOME development platform</a></li>
		  <li><a href="http://gnomedesktop.org">FootNotes</a></li>
		  <li><a href="http://www.gnomejournal.org">GNOME Journal</a></li>
		  <li><a href="http://www.gnomefiles.org">GNOME Files</a></li>
		  <li><a href="http://planet.gnome.org">Planet GNOME (blogs)</a></li>
		</ul>

		<h2>Related Projects</h2>
		<ul>
		  <li><a href="http://www.kde.org/">KDE Project</a></li>
		  <li><a href="http://freebsd.kde.org/">KDE on FreeBSD</a></li>
		  <li><a href="http://www.opengroup.org/desktop/">CDE (commercial)</a></li>
		</ul>

		<a id="search" name="search"></a>
		<form action="http://freebsd.rambler.ru/srch" method="get">
		  <p>Search the freebsd-gnome mailing list archives:</p>
		  <input type="text" name="words" size="25"/>
		  <input type="hidden" name="rubric" value="122" />
		  <input type="submit" value="Search"/>
		</form>

	  	</div> <!-- contentwrap -->

	      <br class="clearboth" />
  </xsl:template>
</xsl:stylesheet>
