<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "..">
<!ENTITY title "Commercial Vendors">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.support "INCLUDE">
]>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:param name="basename" select="'none'" />
  <xsl:param name="sort" select="'none'" />

  <xsl:variable name="uc" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="lc" select="'abcdefghijklmnopqrstuvwxyz'"/>

  <xsl:output method="xml" encoding="&xml.encoding;"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

  <xsl:template match="/entries">
    <html>
      &header1;
      <body>
	<div id="containerwrap">
	  <div id="container">
	    &header2;

	    <div id="content">
              <div id="SIDEWRAP">
                &nav;
              </div> <!-- SIDEWRAP -->

	      <div id="contentwrap">
		&header3;

		<xsl:call-template name="html-commercial-preface" />

		<xsl:call-template name="html-commercial-listing" />

	      </div> <!-- contentwrap -->

	      <br class="clearboth" />

	    </div> <!-- content -->

            <div id="FOOTER">
	      &copyright;<br />
	      &date;
            </div> <!-- FOOTER -->

	  </div> <!-- container -->
	</div> <!-- containerwrap -->
      </body>
    </html>
  </xsl:template>

  <xsl:template name="html-commercial-preface">
    <p>The power, flexibility, and reliability of FreeBSD attract
      a wide variety of users and vendors. Here you will find
      vendors offering commercial products and/or services for
      FreeBSD.</p>

    <p>For your convenience, we have divided our growing
      commercial listing into several sections. If your company
      supports a FreeBSD-compatible product or service that should
      be added to this page, please fill out a
      <a href="http://www.FreeBSD.org/send-pr.html">problem report</a> for
      category www.  Submissions should be in HTML and a medium-sized
      paragraph in length.</p>

    <xsl:choose>
      <xsl:when test="$basename = 'software.html'">
	<h2>Software Vendors</h2>

	<p>This file has been divided into sub-categories for your
	  convenience.	The following shortcuts will take you to the
	  proper gallery entries.</p>

      </xsl:when>
      <xsl:when test="$basename = 'consult.html'">
	<h2>Consulting Services</h2>

	<p>This file has been divided into sub-categories for your convenience.
	  The following shortcuts will take you to the proper gallery entries.</p>
      </xsl:when>
      <xsl:otherwise>
	<h2><xsl:value-of select="$pagename" /></h2>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="html-commercial-listing">
    <xsl:choose>
      <xsl:when test="$sort = 'bycat'">
	<xsl:for-each select="/entries/categories/category/@id">
	  <xsl:param name="id" select="." />

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
	    <xsl:sort select="translate(name, $uc, $lc)" order="ascending"/>

	    <dt><xsl:element name="a">
		<xsl:attribute name="name">
		  <xsl:value-of select='@id' />
		</xsl:attribute>

		<xsl:attribute name="href">
		  <xsl:value-of select='url' />
		</xsl:attribute>

		<xsl:value-of select="name"/>
	      </xsl:element></dt>

	    <dd><xsl:copy-of select="description/child::node()" /></dd>
	  </xsl:for-each>
	</dl>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
