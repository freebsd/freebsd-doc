<?xml version="1.0"?>

<!-- Copyright (c) 2003 Josef El-Rayes <josef@FreeBSD.org>
     All rights reserved.

     Redistribution and use in source and binary forms, with or without
     modification, are permitted provided that the following conditions
     are met:
     1. Redistributions of source code must retain the above copyright
	notice, this list of conditions and the following disclaimer.
     2. Redistributions in binary form must reproduce the above copyright
	notice, this list of conditions and the following disclaimer in the
	documentation and/or other materials provided with the distribution.

     THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
     ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
     IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
     ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
     FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
     DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
     OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
     LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
     OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
     SUCH DAMAGE.

     $FreeBSD$
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">

  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>
  <xsl:variable name="email" select="'freebsd-www'"/>
  <xsl:variable name="title" select="'Commercial Vendors'"/>

  <xsl:output method="xml" encoding="iso-8859-1"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

  <xsl:template match="entries">
    <html>
      <xsl:copy-of select="$header1"/>

      <body xsl:use-attribute-sets="att.body">
	<xsl:copy-of select="$header2"/>

	<p>The power, flexibility, and reliability of FreeBSD attract a wide
	  variety of users and vendors.	 Here you will find vendors offering
	  commercial products and/or services for FreeBSD.</p>

	<p>For your convenience, we have divided our growing commercial listing
	  into several sections.  If your company supports a FreeBSD-compatible
	  product or service that should be added to this page, please send
	  email to <a href="mailto:www@FreeBSD.org">www@FreeBSD.org</a>
	  and let us know!  Submissions should be in HTML and a medium-sized
	  paragraph in length.</p>

	<h2>Consulting Services</h2>

	<p>This file has been divided into sub-categories for your convenience.
	  The following shortcuts will take you to the proper gallery entries.</p>

	<h3>Africa</h3>
	<xsl:for-each select="entry[@continent='africa']">
	  <xsl:sort select="name"/>
	  <xsl:call-template name="entry"/>
	</xsl:for-each>

	<h3>Asia</h3>
	<xsl:for-each select="entry[@continent='asia']">
	  <xsl:sort select="name"/>
	  <xsl:call-template name="entry"/>
	</xsl:for-each>

	<h3>Australia</h3>
	<xsl:for-each select="entry[@continent='australia']">
	  <xsl:sort select="name"/>
	  <xsl:call-template name="entry"/>
	</xsl:for-each>

	<h3>Europe</h3>
	<xsl:for-each select="entry[@continent='europe']">
	  <xsl:sort select="name"/>
	  <xsl:call-template name="entry"/>
	</xsl:for-each>

	<h3>New Zealand</h3>
	<xsl:for-each select="entry[@continent='nzealand']">
	  <xsl:sort select="name"/>
	  <xsl:call-template name="entry"/>
	</xsl:for-each>

	<h3>North America</h3>
	<xsl:for-each select="entry[@continent='namerica']">
	  <xsl:sort select="name"/>
	  <xsl:call-template name="entry"/>
	</xsl:for-each>

	<h3>South America</h3>
	<xsl:for-each select="entry[@continent='samerica']">
	  <xsl:sort select="name"/>
	  <xsl:call-template name="entry"/>
	</xsl:for-each>
	<xsl:copy-of select="$footer"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="entry">
    <li><a href="consult.html#{@id}">
      <xsl:value-of select="name"/>
    </a></li>
  </xsl:template>
</xsl:stylesheet>
