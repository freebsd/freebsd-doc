<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/en/news/newsflash.xsl,v 1.10 2004/01/12 21:26:59 hrs Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>


  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="title" select="'FreeBSD News Flash'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>
  
  <xsl:output type="html" encoding="iso-8859-1"/>

  <xsl:template match="news">
    <html>
      
      <xsl:copy-of select="$header1"/>

      <body xsl:use-attribute-sets="att.body">

	<xsl:copy-of select="$header2"/>

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
	
	<xsl:apply-templates select="descendant::month"/>
	
	<p>Older announcements:
	  <a href="2002/index.html">2002</a>,
	  <a href="2001/index.html">2001</a>,
	  <a href="2000/index.html">2000</a>,
	  <a href="1999/index.html">1999</a>,
	  <a href="1998/index.html">1998</a>,
	  <a href="1997/index.html">1997</a>,
	  <a href="1996/index.html">1996</a></p>
	
	<xsl:copy-of select="$newshome"/>
	<xsl:copy-of select="$footer"/>
      </body>
    </html>
  </xsl:template>

  <!-- Everything that follows are templates for the rest of the content -->
  
  <xsl:template match="month">
    <h1>
      <xsl:call-template name="transtable-lookup">
	<xsl:with-param name="word-group" select="'number-month'" />
	<xsl:with-param name="word">
	  <xsl:value-of select="name"/>
	</xsl:with-param>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:value-of select="ancestor::year/name"/></h1>

    <ul>
      <xsl:apply-templates select="descendant::day"/>
    </ul>
  </xsl:template>

  <xsl:template match="day">
    <xsl:apply-templates select="event"/>
  </xsl:template>

  <xsl:template match="event">
    <li><p><a>
	  <xsl:attribute name="name">
	    <xsl:call-template name="generate-event-anchor"/>
	  </xsl:attribute>
	</a>

	<b><xsl:value-of select="ancestor::day/name"/>
	  <xsl:text> </xsl:text>
	  <xsl:call-template name="transtable-lookup">
	    <xsl:with-param name="word-group" select="'number-month'" />
	    <xsl:with-param name="word">
	      <xsl:value-of select="ancestor::month/name"/>
	    </xsl:with-param>
	  </xsl:call-template>
	  <xsl:text>, </xsl:text>
	  <xsl:value-of select="ancestor::year/name"/>:</b><xsl:text> </xsl:text>
	<xsl:apply-templates select="p"/>
	</p>

    </li>
  </xsl:template>

  <xsl:template match="date"/>    <!-- Deliberately left blank -->

  <!-- When the href attribute contains a '$base', expand it to the current
       value of the $base variable. -->

  <!-- All your $base are belong to us.  Ho ho ho -->
  <xsl:template match="a">
    <a><xsl:attribute name="href">
	<xsl:choose>
	  <xsl:when test="contains(@href, '$base')">
	    <xsl:value-of select="concat(substring-before(@href, '$base'), $base, substring-after(@href, '$base'))"/>
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
