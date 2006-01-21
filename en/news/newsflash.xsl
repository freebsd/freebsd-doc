<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/en/news/newsflash.xsl,v 1.15 2005/11/30 19:59:32 pav Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>
  <xsl:variable name="section" select="'about'"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="title" select="'FreeBSD News Flash'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:param name="news.project.xml-master" select="'none'" />
  <xsl:param name="news.project.xml" select="'none'" />
  
  <xsl:output type="html" encoding="iso-8859-1"/>

  <xsl:template match="news">
    <html>
      
      <xsl:copy-of select="$header1"/>

      <body>

  <div id="CONTAINERWRAP">
    <div id="CONTAINER">

	<xsl:copy-of select="$header2"/>

	<div id="CONTENT">

	      <xsl:copy-of select="$sidenav"/>

	      <div id="CONTENTWRAP">
	      
	      <xsl:copy-of select="$header3"/>

	<!-- Notice how entity references in SGML become variable references
	     in the stylesheet, and that the syntax for referring to variables
	     inside an attribute is "{$variable}".

	     This is just dis-similar enough to Perl and the shell that you
	     end up writing ${variable} all the time, and then scratch your 
	     head wondering why the stylesheet isn't working.-->

	<!-- Also notice that because this is now XML and not SGML, empty
             elements, like IMG, must have a trailing "/" just inside the 
   	     closing angle bracket, like this " ... />" -->
	<img src="{$base}/gifs/news.jpg" align="right" border="0" width="193"
	     height="144" alt="FreeBSD News"/>

	<p>FreeBSD is a rapidly developing operating system.  Keeping up on
	  the latest developments can be a chore!  To keep on top of things,
	  be sure and check this page periodically.  Also, you may wish to
	  subscribe to the 
	  <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/eresources.html#ERESOURCES-MAIL">freebsd-announce
	    mailing list</a> or the <a href="news.rdf">RSS feed</a>.</p>

        <p>The following projects have their own news pages, which should
          be checked for project specific updates.</p>

        <ul>
          <li><a href="{$base}/java/newsflash.html"><xsl:value-of select="$java"/> on FreeBSD</a></li>
          <li><a href="http://freebsd.kde.org/">KDE on FreeBSD</a></li>
          <li><a href="{$base}/gnome/newsflash.html">GNOME on FreeBSD</a></li>
        </ul>
	  
	<p>For a detailed description of past, present, and future releases,
	  see the <strong><a href="{$base}/releases/index.html">Release
	      Information</a></strong> page.</p>
	
	<p>For FreeBSD Security Advisories, please refer to the 
	  <a href="{$base}/security/#adv">Security Information</a> page.</p>
	
	<xsl:call-template name="html-news-list-newsflash">
          <xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
	  <xsl:with-param name="news.project.xml" select="$news.project.xml" />
	</xsl:call-template>

        <xsl:call-template name="html-news-make-olditems-list" />

	<xsl:copy-of select="$newshome"/>
	
	  	</div> <!-- CONTENTWRAP -->
		<br class="clearboth" />
	
	</div> <!-- CONTENT -->
	
	<xsl:copy-of select="$footer"/>
	
        </div> <!-- CONTAINER -->
   </div> <!-- CONTAINERWRAP -->
	
      </body>
    </html>
  </xsl:template>

  <!-- When the href attribute contains a '$base' or '$enbase', expand it
       to the current value of the $base or $enbase variable. -->

  <!-- All your $base or $enbase are belong to us.  Ho ho ho -->
  <xsl:template match="a">
    <a><xsl:attribute name="href">
	<xsl:choose>
	  <xsl:when test="contains(@href, '$base')">
	    <xsl:value-of select="concat(substring-before(@href, '$base'), $base, substring-after(@href, '$base'))"/>
	  </xsl:when>
	  <xsl:when test="contains(@href, '$enbase')">
	    <xsl:value-of select="concat(substring-before(@href, '$enbase'), $enbase, substring-after(@href, '$enbase'))"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@href"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
</xsl:stylesheet>
