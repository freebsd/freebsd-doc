<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
		xmlns:str="http://exslt.org/strings"
		extension-element-prefixes="str"
                exclude-result-prefixes="#default">

  <!-- Include the common customizations -->
  <xsl:include href="freebsd-common.xsl"/>

  <!-- Include customized XHTML titlepage -->
  <xsl:include href="freebsd-xhtml-titlepage.xsl"/>

  <!-- Redefine variables, and replace templates as necessary here -->

  <xsl:param name="use.id.as.filename" select="1"/>
  <xsl:param name="html.stylesheet" select="'docbook.css'"/>
  <xsl:param name="link.mailto.url" select="'doc@FreeBSD.org'"/>
  <xsl:param name="callout.graphics.path" select="'./imagelib/callouts/'"/>
  <xsl:param name="citerefentry.link" select="1"/>
  <xsl:param name="admon.style"/>
  <xsl:param name="make.year.ranges" select="1"/>
  <xsl:param name="make.single.year.ranges" select="1"/>

  <xsl:param name="make.valid.html" select="1"/>
  <xsl:param name="html.cleanup" select="1"/>

  <xsl:template name="user.footer.navigation">
    <p align="center"><small>This, and other documents, can be downloaded
    from <a href="ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/">ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/</a></small></p>

    <p align="center"><small>For questions about FreeBSD, read the
    <a href="http://www.FreeBSD.org/docs.html">documentation</a> before
    contacting &lt;<a href="mailto:questions@FreeBSD.org">questions@FreeBSD.org</a>&gt;.<br/>
    For questions about this documentation, e-mail &lt;<a href="mailto:doc@FreeBSD.org">doc@FreeBSD.org</a>&gt;.</small></p>
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

  <xsl:template match="svnref">
    <xsl:call-template name="svnref.genlink"/>
  </xsl:template>

  <xsl:template name="generate.citerefentry.link">
    <xsl:text>http://www.FreeBSD.org/cgi/man.cgi?query=</xsl:text>
    <xsl:value-of select="refentrytitle"/>
    <xsl:text>&#38;amp;sektion=</xsl:text>
    <xsl:value-of select="manvolnum"/>
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

  <xsl:template name="freebsd.authorgroup">
    <span class="authorgroup">

      <!-- XXX: our docs use a quirky semantics for this -->
      <xsl:if test="(contrib|author/contrib)[1]">
	<xsl:apply-templates select="(contrib|author/contrib)[1]"/>
      </xsl:if>

      <xsl:for-each select="author">
	<xsl:apply-templates select="."/>

	<xsl:choose>
	  <xsl:when test="position() &lt; (last() - 1)">
	    <xsl:text>, </xsl:text>
	  </xsl:when>

	  <xsl:when test="position() = (last() - 1)">
	    <xsl:call-template name="gentext.space"/>
	    <xsl:call-template name="gentext">
	      <xsl:with-param name="key" select="'and'"/>
	    </xsl:call-template>
	    <xsl:call-template name="gentext.space"/>
	  </xsl:when>
	</xsl:choose>
      </xsl:for-each>
      <xsl:text>. </xsl:text>
    </span>
  </xsl:template>

  <xsl:template match="contrib">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template name="freebsd.author">
    <xsl:if test="contrib">
      <xsl:apply-templates select="contrib"/>
      <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:apply-templates select="*[not(self::contrib)]"/>
  </xsl:template>

  <xsl:template name="chapter.authorgroup">
    <xsl:call-template name="freebsd.authorgroup"/>
  </xsl:template>

  <xsl:template name="section.authorgroup">
    <xsl:call-template name="freebsd.authorgroup"/>
  </xsl:template>

  <xsl:template name="chapter.author">
    <xsl:call-template name="freebsd.author"/>
  </xsl:template>

  <xsl:template name="section.author">
    <xsl:call-template name="freebsd.author"/>
  </xsl:template>

  <xsl:template name="titlepage.releaseinfo">
    <xsl:variable name="rev" select="str:split(., ' ')[3]"/>

    Current Revision:
    <xsl:call-template name="svnref.genlink">
      <xsl:with-param name="repo" select="'doc'"/>
      <xsl:with-param name="rev" select="$rev"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="titlepage.pubdate">
    <xsl:variable name="pubdate">
      <xsl:choose>
	<xsl:when test="contains(., '$FreeBSD')">
	  <xsl:value-of select="str:split(., ' ')[4]"/> by <xsl:value-of select="str:split(., ' ')[6]"/>
	</xsl:when>

	<xsl:otherwise>
	  <xsl:value-of select="."/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    Last modified on <xsl:value-of select="$pubdate"/>.
  </xsl:template>
</xsl:stylesheet>
