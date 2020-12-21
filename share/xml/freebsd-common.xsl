<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:str="http://exslt.org/strings"
                extension-element-prefixes="str"
                exclude-result-prefixes="db"
                version='1.0'>

  <!-- Global customisation -->

  <!-- Generate link for revnumber -->
  <xsl:template match="db:revnumber">
    <xsl:call-template name="svnref.genlink"/>
  </xsl:template>

  <!-- Generate link for githash -->
  <xsl:template match="db:githash">
    <xsl:call-template name="gitref.genlink"/>
  </xsl:template>

  <!-- Redefine variables, and replace templates as necessary here -->
  <xsl:template match="db:buildtarget|db:command">
    <xsl:call-template name="inline.monoseq"/>
  </xsl:template>

  <xsl:template name="svnweb.link">
    <xsl:param name="repo" select="'base'"/>
    <xsl:param name="rev"/>

    <xsl:value-of select="concat('https://svnweb.freebsd.org/changeset/',
      $repo, '/', $rev)"/>
  </xsl:template>

  <xsl:template name="cgit.link">
    <xsl:param name="repo" select="'src'"/>
    <xsl:param name="rev"/>

    <xsl:value-of select="concat('https://cgit.freebsd.org/', $repo, '/commit/?id=',
      $rev)"/>
  </xsl:template>

  <xsl:param name="toc.section.depth" select="1"/>
  <xsl:param name="section.autolabel" select="1"/>
  <xsl:param name="section.label.includes.component.label" select="1"/>

  <xsl:param name="graphic.default.extension">png</xsl:param>

  <!-- No links in TOC -->
  <xsl:template match="db:citerefentry" mode="no.anchor.mode">
    <xsl:apply-templates select="*" mode="no.anchor.mode"/>
  </xsl:template>

  <!-- No links in TOC -->
  <xsl:template match="db:refentrytitle" mode="no.anchor.mode">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="db:contrib">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template name="titlepage.pubdate">
    <xsl:variable name="pubdate">
      <xsl:value-of select="$latestrevision.timestamp"/>
    </xsl:variable>

    <xsl:variable name="committer">
      <xsl:value-of select="$latestrevision.committer"/>
    </xsl:variable>

    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'Lastmodified'"/>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'on'"/>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    <xsl:value-of select="$pubdate"/>
    <xsl:if test="$committer">
      <xsl:call-template name="gentext.space"/>
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'by'"/>
      </xsl:call-template>
      <xsl:call-template name="gentext.space"/>
      <xsl:value-of select="$committer"/>
    </xsl:if>
    <xsl:text>.</xsl:text>
  </xsl:template>

  <xsl:template name="gitref.genlink"/>

  <xsl:template name="titlepage.releaseinfo">
    <xsl:variable name="rev" select="$latestrevision.number"/>

    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'Revision'"/>
    </xsl:call-template>
    <xsl:text>:</xsl:text>
    <xsl:call-template name="gentext.space"/>
    <xsl:call-template name="gitref.genlink">
      <xsl:with-param name="repo" select="'doc'"/>
      <xsl:with-param name="rev" select="$rev"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="freebsd.authorgroup">
      <!-- XXX: our docs use a quirky semantics for this -->
      <xsl:if test="(db:contrib|db:author/db:contrib)[1]">
        <xsl:apply-templates select="(db:contrib|db:author/db:contrib)[1]"/>
      </xsl:if>

      <xsl:for-each select="db:author">
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
  </xsl:template>

  <xsl:template match="db:contrib">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template name="freebsd.author">
    <xsl:if test="contrib">
      <xsl:apply-templates select="db:contrib"/>
      <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:apply-templates select="*[not(self::db:contrib)]"/>
  </xsl:template>

  <xsl:param name="callout.graphics.number.limit">30</xsl:param>
</xsl:stylesheet>
