<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Commercial Vendors">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:param name="basename" select="'none'" />
  <xsl:param name="sort" select="'none'" />

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.sidewrap">
    &nav.support;
  </xsl:template>

  <xsl:template name="process.contentwrap">
		<xsl:for-each select="/entries">
		<xsl:call-template name="html-commercial-preface" />

		<xsl:call-template name="html-commercial-listing" />
		</xsl:for-each>
  </xsl:template>

  <xsl:template name="html-commercial-preface">
    <p>The power, flexibility, and reliability of FreeBSD attract
      a wide variety of users and vendors. Here you will find
      vendors offering commercial products and/or services for
      FreeBSD.</p>

    <p>For your convenience, we have divided our growing
      commercial listing into several sections. If your company
      supports a FreeBSD related product, service, consulting, or support that should
      be added to this page, please fill out a
      <a href="https://www.FreeBSD.org/support/bugreports.html">problem report</a> in
      category Documentation->Website.  Submissions should contain a medium-sized
      paragraph in length, describing your company.  Please note that the inclusion
      of vendors in our list does not signify our endorsement of their products or
      services by the FreeBSD Project.</p>

    <h2><xsl:value-of select="$pagename" /></h2>

    <xsl:if test="$basename = 'software.html' or $basename = 'consult.html'">
      <p>This file has been divided into sub-categories for your
        convenience.  The following shortcuts will take you to the
        proper gallery entries.</p>
    </xsl:if>
  </xsl:template>

  <xsl:template name="html-commercial-listing">
    <xsl:choose>
      <xsl:when test="$sort = 'bycat'">
	<xsl:for-each select="/entries/categories/category/@id">
	  <xsl:variable name="id" select="." />

	  <h3><xsl:value-of select="/entries/categories/category[@id = $id]" /></h3>

	  <ul>
	    <xsl:for-each select="/entries/entry[@category = $id]">
	      <xsl:sort select="name"/>

	      <li><xsl:element name="a">
		  <xsl:attribute name="href">
		    <xsl:value-of select='concat($basename, "#", @id)' />
		  </xsl:attribute>
		  <xsl:value-of select="name"/>
		</xsl:element></li>
	    </xsl:for-each>
	  </ul>
	</xsl:for-each>
      </xsl:when>

      <xsl:otherwise>
	<dl>
	  <xsl:for-each select="/entries/entry">
	    <xsl:sort select="translate(name, $uppercase, $lowercase)" order="ascending"/>

	    <dt><xsl:element name="a">
		<xsl:attribute name="name">
		  <xsl:value-of select='@id' />
		</xsl:attribute>

		<xsl:attribute name="href">
		  <xsl:value-of select='url' />
		</xsl:attribute>

		<xsl:value-of select="name"/>
	      </xsl:element></dt>

	    <dd><xsl:apply-templates select="description/child::node()" mode="copy.html"/></dd>
	  </xsl:for-each>
	</dl>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
