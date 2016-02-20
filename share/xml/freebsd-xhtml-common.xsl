<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
                     "http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
		xmlns:str="http://exslt.org/strings"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db"
		extension-element-prefixes="str">

  <!-- Include the common customizations -->
  <xsl:import href="freebsd-common.xsl"/>

  <!-- Include customized XHTML titlepage -->
  <xsl:import href="freebsd-xhtml-titlepage.xsl"/>

  <!-- Redefine variables, and replace templates as necessary here -->

  <xsl:param name="chunker.output.encoding" select="'&doc.html.charset;'"/>
  <xsl:param name="use.id.as.filename" select="1"/>
  <xsl:param name="html.stylesheet" select="'docbook.css'"/>
  <xsl:param name="link.mailto.url" select="'mailto:doc@FreeBSD.org'"/>
  <xsl:param name="callout.graphics.path" select="'./imagelib/callouts/'"/>
  <xsl:param name="citerefentry.link" select="1"/>
  <xsl:param name="admon.style"/>
  <xsl:param name="make.year.ranges" select="1"/>
  <xsl:param name="make.single.year.ranges" select="1"/>
  <xsl:param name="docbook.css.source" select="''"/>
  <xsl:param name="generate.manifest" select="1"/>
  <xsl:param name="generate.meta.abstract" select="1"/>
  <xsl:param name="html.longdesc" select="0"/>

  <xsl:param name="make.valid.html" select="1"/>
  <xsl:param name="html.cleanup" select="1"/>
  <xsl:param name="make.clean.html" select="1"/>
  <xsl:param name="docformatnav" select="0"/>

  <xsl:param name="local.l10n.xml" select="document('')"/>
  <i18n xmlns="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0" language="en">
      <l:gentext key="Lastmodified" text="Last modified"/>
      <l:gentext key="on" text="on"/>
    </l:l10n>
  </i18n>

  <xsl:template name="user.head.content">
    <script type="text/javascript" src="/layout/js/google.js" />
  </xsl:template>

  <xsl:template name="user.footer.navigation">
    <p align="center"><small>All FreeBSD documents are available for download
    at <a href="http://ftp.FreeBSD.org/pub/FreeBSD/doc/">http://ftp.FreeBSD.org/pub/FreeBSD/doc/</a></small></p>

    <p align="center"><small>Questions that are not answered by the
    <a href="http://www.FreeBSD.org/docs.html">documentation</a> may be
    sent to &lt;<a href="mailto:freebsd-questions@FreeBSD.org">freebsd-questions@FreeBSD.org</a>&gt;.<br/>
    Send questions about this document to &lt;<a href="mailto:freebsd-doc@FreeBSD.org">freebsd-doc@FreeBSD.org</a>&gt;.</small></p>
  </xsl:template>

  <xsl:template name="docformatnav">
    <xsl:variable name="single.fname">
      <xsl:choose>
        <xsl:when test="/db:book">book.html</xsl:when>
        <xsl:when test="/db:article">article.html</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <div class="docformatnavi">
      [
      <xsl:choose>
	<xsl:when test="$html.chunk = 0">
	  <a href="index.html">&docnavi.split-html;</a>
	</xsl:when>
	<xsl:otherwise>
	  &docnavi.split-html;
	</xsl:otherwise>
      </xsl:choose>
      /
      <xsl:choose>
	<xsl:when test="$html.chunk = 0">
	  &docnavi.single-html;
	</xsl:when>
	<xsl:otherwise>
	  <a href="{$single.fname}">&docnavi.single-html;</a>
	</xsl:otherwise>
      </xsl:choose>
      ]
    </div>
  </xsl:template>

  <xsl:template match="db:package">
    <xsl:variable name="url" select="concat('http://www.freebsd.org/cgi/url.cgi?ports/', ., '/pkg-descr')"/>

    <a class="package" href="{$url}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <!-- Customization to allow role="nolink" -->
  <xsl:template match="db:email">
    <xsl:call-template name="inline.monoseq">
      <xsl:with-param name="content">
	<xsl:if test="not($email.delimiters.enabled = 0)">
	  <xsl:text>&lt;</xsl:text>
	</xsl:if>
	<xsl:choose>
	  <xsl:when test="@role='nolink'">
	    <xsl:apply-templates/>
	  </xsl:when>

	  <xsl:otherwise>
	    <a>
	      <xsl:apply-templates select="." mode="common.html.attributes"/>
	      <xsl:attribute name="href">
		<xsl:text>mailto:</xsl:text>
		<xsl:value-of select="."/>
	      </xsl:attribute>
	      <xsl:apply-templates/>
	    </a>
	  </xsl:otherwise>
	</xsl:choose>
	<xsl:if test="not($email.delimiters.enabled = 0)">
	  <xsl:text>&gt;</xsl:text>
	</xsl:if>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- Add title class to emitted hX -->
  <xsl:template match="db:bridgehead">
    <xsl:variable name="container" select="(ancestor::appendix|ancestor::article|ancestor::bibliography|
      ancestor::chapter|ancestor::glossary|ancestor::glossdiv|ancestor::index|ancestor::partintro|
      ancestor::preface|ancestor::refsect1|ancestor::refsect2|ancestor::refsect3|ancestor::sect1|
      ancestor::sect2|ancestor::sect3|ancestor::sect4|ancestor::sect5|ancestor::section|ancestor::setindex|
      ancestor::simplesect)[last()]"/>

    <xsl:variable name="clevel">
      <xsl:choose>
        <xsl:when test="local-name($container) = 'appendix'
	  or local-name($container) = 'chapter'
	  or local-name($container) = 'article'
	  or local-name($container) = 'bibliography'
	  or local-name($container) = 'glossary'
	  or local-name($container) = 'index'
	  or local-name($container) = 'partintro'
	  or local-name($container) = 'preface'
	  or local-name($container) = 'setindex'">1</xsl:when>
        <xsl:when test="local-name($container) = 'glossdiv'">
          <xsl:value-of select="count(ancestor::glossdiv)+1"/>
        </xsl:when>
        <xsl:when test="local-name($container) = 'sect1'
	  or local-name($container) = 'sect2'
	  or local-name($container) = 'sect3'
	  or local-name($container) = 'sect4'
	  or local-name($container) = 'sect5'
	  or local-name($container) = 'refsect1'
	  or local-name($container) = 'refsect2'
	  or local-name($container) = 'refsect3'
	  or local-name($container) = 'section'
	  or local-name($container) = 'simplesect'">
          <xsl:variable name="slevel">
            <xsl:call-template name="section.level">
              <xsl:with-param name="node" select="$container"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:value-of select="$slevel + 1"/>
        </xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- HTML H level is one higher than section level -->
    <xsl:variable name="hlevel">
      <xsl:choose>
        <xsl:when test="@renderas = 'sect1'">2</xsl:when>
        <xsl:when test="@renderas = 'sect2'">3</xsl:when>
        <xsl:when test="@renderas = 'sect3'">4</xsl:when>
        <xsl:when test="@renderas = 'sect4'">5</xsl:when>
        <xsl:when test="@renderas = 'sect5'">6</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$clevel + 1"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:element name="h{$hlevel}" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="class">title</xsl:attribute>
      <xsl:call-template name="anchor">
        <xsl:with-param name="conditional" select="0"/>
      </xsl:call-template>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="svnref.genlink">
    <xsl:param name="rev" select="."/>
    <xsl:param name="repo" select="'base'"/>

    <a>
      <xsl:attribute name="href">
	<xsl:call-template name="svnweb.link">
	  <xsl:with-param name="repo" select="$repo"/>
	  <xsl:with-param name="rev" select="$rev"/>
	</xsl:call-template>
      </xsl:attribute>

      <span class="svnref">
	<xsl:value-of select="$rev"/>
      </span>
    </a>
  </xsl:template>

  <xsl:template name="generate.citerefentry.link">
    <xsl:text>http://www.FreeBSD.org/cgi/man.cgi?query=</xsl:text>
    <xsl:value-of select="db:refentrytitle"/>
    <xsl:text>&amp;sektion=</xsl:text>
    <xsl:value-of select="db:manvolnum"/>
    <xsl:text>&amp;manpath=FreeBSD+&rel.current;-RELEASE+and+Ports</xsl:text>
  </xsl:template>

  <xsl:template name="nongraphical.admonition">
    <div>
      <xsl:call-template name="common.html.attributes">
        <xsl:with-param name="inherit" select="1"/>
      </xsl:call-template>
      <xsl:if test="$admon.style">
        <xsl:attribute name="style">
          <xsl:value-of select="$admon.style"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="$admon.textlabel != 0 or title or info/title">
        <h3 class="admontitle">
          <xsl:call-template name="anchor"/>
          <xsl:apply-templates select="." mode="object.title.markup"/>
	  <xsl:text>: </xsl:text>
        </h3>
      </xsl:if>

      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template name="chapter.authorgroup">
    <span class="authorgroup">
      <xsl:call-template name="freebsd.authorgroup"/>
    </span>
  </xsl:template>

  <xsl:template name="section.authorgroup">
    <span class="authorgroup">
      <xsl:call-template name="freebsd.authorgroup"/>
    </span>
  </xsl:template>

  <xsl:template name="chapter.author">
    <xsl:call-template name="freebsd.author"/>
  </xsl:template>

  <xsl:template name="section.author">
    <xsl:call-template name="freebsd.author"/>
  </xsl:template>

  <xsl:template name="titlepage.releaseinfo">
    <xsl:variable name="rev" select="str:split(., ' ')[3]"/>

    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'Revision'"/>
    </xsl:call-template>
    <xsl:text>:</xsl:text>
    <xsl:call-template name="gentext.space"/>
    <xsl:call-template name="svnref.genlink">
      <xsl:with-param name="repo" select="'doc'"/>
      <xsl:with-param name="rev" select="$rev"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Hook in format navigation at the end of the titlepage -->
  <xsl:template name="book.titlepage.separator">
    <xsl:if test="not($docformatnav = 0)">
      <xsl:call-template name="docformatnav" />
    </xsl:if>

    <hr/>
  </xsl:template>

  <xsl:template name="article.titlepage.separator">
    <xsl:if test="not($docformatnav = 0)">
      <xsl:call-template name="docformatnav" />
    </xsl:if>

    <hr/>
  </xsl:template>
</xsl:stylesheet>
