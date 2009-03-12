<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "The &os; list of projects and ideas for volunteers">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.developers "INCLUDE">
<!ENTITY % developers SYSTEM "../../developers.sgml"> %developers;
]>

<!-- $FreeBSD: www/en/projects/ideas/ideas.xsl,v 1.12 2009/03/06 04:41:39 brooks Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:param name="ideas.xml" select="'ideas.xml'" />

  <xsl:output type="html" encoding="&xml.encoding;"/>

  <xsl:template match="ideas">
    <html>
      &header1;
      <body>

	<div id="CONTAINERWRAP">
	  <div id="CONTAINER">
	    &header2;

	    <div id="CONTENT">
              <div id="SIDEWRAP">
                &nav;
              </div> <!-- SIDEWRAP -->

	      <div id="CONTENTWRAP">
		&header3;
<h2>Introduction</h2>

<p>The &os; project has hundreds of active developers spread all over the
  world, and many of them have their own parts of the source-tree that they
  work on.  However, there are always a lot of new interesting projects and
  ideas that need to be investigated and evaluated, and this is where the
  &os; project relies on heroic efforts from volunteers.  The following
  list of possible projects is in no way complete, but it should serve as a
  nice starting point for volunteers who would like to become committers in
  the future.</p>

<p>Please note that we cannot guarantee that your work will be included in the
  &os; source tree.  This is because people tend to disagree about specifics
  in the implementation of new features or functionality.  However, if you can
  find a developer who is interested in your work, and you can get him or her
  to review it, then you are pretty far on your way to get your code into the
  &os; source tree.</p>

<p>If you have any non-technical questions about this list, please contact <a
  href="mailto:netchild@FreeBSD.org">&a.netchild;</a> and <a
  href="mailto:joel@FreeBSD.org">&a.joel;</a>.  Technical questions
  should be directed to the Technical contact for each project, or to the <a
  href="mailto:hackers@FreeBSD.org">hackers mailinglist</a>.</p>

<a name="p-projects"></a>
<h2>Projects at FreeBSD.org</h2>
<p>A number of specific project ideas may be found on this page, but you can
  find many further ideas by visiting the <a
  href="../projects.html">&os; Development Projects page</a>.  Some of the
  most prominent projects are:</p>
<ul>
  <li><a href="../acpi/index.html">The &os; ACPI Project</a></li>
  <li><a href="http://wiki.freebsd.org/Bsnmp">BSNMP Project</a></li>
  <li><a href="../busdma/index.html">busdma and SMPng driver conversion
    Project</a></li>
  <li><a href="../c99/index.html">C99 and POSIX Conformance Project</a></li>
  <li><a href="../bigdisk/index.html">Large data storage in the &os;
    operating system</a></li>
  <li><a href="http://wiki.freebsd.org/linux-kernel">Linuxulator</a></li>
  <li><a href="http://wiki.freebsd.org/Networking">Networking</a></li>
  <li><a href="../netperf/index.html">Network Performance Project</a></li>
  <li><a href="http://wiki.freebsd.org/SMPTODO">SMPTODO</a></li>
  <li><a href="http://www.TrustedBSD.org/">TrustedBSD Project</a> and <a
    href="http://wiki.FreeBSD.org/TrustedBSDTODO/">TrustedBSD TODO
    list.</a></li>
</ul>
<p>Do not forget to have a look at the other projects too or by viewing some
  of the recent <a href="&base;/news/status">Developer Status Reports.</a></p>

<hr />

  <!-- Table of Contents, with ideas grouped by categories and one
       line titles listed with a link to teh full project description
       below. -->

    <xsl:for-each select="document($ideas.xml)//descendant::category">
      <h3><xsl:value-of select="title"/></h3>

      <ul>
      <xsl:for-each select="idea">
        <li><xsl:element name="a">
	      <xsl:attribute name="href">
		#p-<xsl:value-of select="@id" />
	      </xsl:attribute>
	      <xsl:value-of select="title" />
            </xsl:element>
         <xsl:text>&#160;</xsl:text>
         <xsl:if test="@class='soc'"><em>(Summer of Code)</em></xsl:if>
         <xsl:if test="@class='soc2007'"><em>(Summer of Code 2007)</em></xsl:if>
         <xsl:if test="@class='soc2008'"><em>(Summer of Code 2008)</em></xsl:if>
         </li>
      </xsl:for-each>
      </ul>
    </xsl:for-each>

    <hr />

    <!-- The body of each idea, grouped by category. -->

    <xsl:for-each select="document($ideas.xml)//descendant::category[child::idea]">
      <h2><xsl:value-of select="title"/> Projects</h2>

      <xsl:for-each select="idea">
      <xsl:element name="a">
	      <xsl:attribute name="name">
		p-<xsl:value-of select="@id" />
	      </xsl:attribute>
      </xsl:element>

      <h3><xsl:value-of select="title" /></h3>
      <xsl:if test="@class='soc2008'"><em>Part of Summer of Code 2008</em></xsl:if>
      <xsl:if test="@class='soc2007'"><em>Part of Summer of Code 2007</em></xsl:if>
      <xsl:if test="@class='soc'"><em>Suggested Summer of Code 2009 project idea</em></xsl:if>

      <xsl:copy-of select="desc" />

    <hr />
      </xsl:for-each>
    </xsl:for-each>


<a name="p-tc"></a>
<h2>Technical contacts</h2>
<p>If you are interested in working on a project not explicitly
  mentioned above, you may want to contact one of the potential
  technical contacts below:</p>
<ul>
  <li><strong>ACPI</strong>:
    <a href="mailto:njl@FreeBSD.org">&a.njl;</a>,
    <a href="mailto:bruno@FreeBSD.org">&a.bruno;</a>.</li>
  <li><strong>File systems</strong>:
    <a href="mailto:scottl@FreeBSD.org">&a.scottl;</a>,
    <a href="mailto:alfred@FreeBSD.org">&a.alfred;</a>.</li>
  <li><strong>GEOM</strong>:
    <a href="mailto:pjd@FreeBSD.org">&a.pjd;</a>,
    <a href="mailto:phk@FreeBSD.org">&a.phk;</a>.</li>
  <li><strong>Networking</strong>:
    <a href="mailto:alfred@FreeBSD.org">&a.alfred;</a>,
    <a href="mailto:brooks@FreeBSD.org">&a.brooks;</a>,
    <a href="mailto:rwatson@FreeBSD.org">&a.rwatson;</a>,
    <a href="mailto:sam@FreeBSD.org">&a.sam;</a>.</li>
  <li><strong>Release Engineering / Integration</strong>:
    <a href="mailto:re@FreeBSD.org">Release Engineering Team</a>.</li>
  <li><strong>Sound</strong>:
    <a href="mailto:ariff@FreeBSD.org">&a.ariff;</a>.</li>
  <li><strong>TrustedBSD / Security</strong>:
    <a href="mailto:rwatson@FreeBSD.org">&a.rwatson;</a>.</li>
</ul>
<p>Additionally, there are a lot of interesting <a
  href="&base;/doc/en_US.ISO8859-1/books/handbook/eresources.html#ERESOURCES-MAIL">mailing
  lists</a> that can be used when searching information about specific
  subjects.</p>

<hr />


	      </div> <!-- CONTENTWRAP -->
	      <br class="clearboth" />
	    </div> <!-- CONTENT -->

            <div id="FOOTER">
               &copyright;<br />
               &date;
            </div> <!-- FOOTER -->
        </div> <!-- CONTAINER -->
   </div> <!-- CONTAINERWRAP -->

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
