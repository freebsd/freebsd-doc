<?xml version="1.0" encoding="EUC-JP" ?>

<!-- $FreeBSD: www/ja/includes.xsl,v 1.13 2003/06/10 20:45:06 hrs Exp $ -->
<!-- Original revision: 1.15 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="enbase" select='concat ($base, "/..")'/>

  <xsl:variable name="i.daemon">
    <img src="{$base}/gifs/daemon.gif" alt="" align="left" width="80" height="76"/>
  </xsl:variable>

  <xsl:variable name="i.new">
    <img src="{$base}/gifs/new.gif" alt="[New!]" width="28" height="11"/>
  </xsl:variable>

  <xsl:variable name="copyright">
    <a href="{$base}/copyright/index.html">Copyright</a> &#169; 1995-2003 the FreeBSD Project.  All rights reserved.
  </xsl:variable>

  <!-- Often used trademarks -->
  <xsl:variable name="unix" select="'UNIX&#174;'"/>
  <xsl:variable name="java" select="'Java&#8482;'"/>
  <xsl:variable name="jdk" select="'JDK&#8482;'"/>

  <xsl:variable name="email" select="'freebsd-questions'"/>
  <xsl:variable name="author">
    <a>
      <xsl:attribute name="href">
	<xsl:value-of select="concat($base, '/mailto.html')"/>
      </xsl:attribute>
      <xsl:value-of select="$email"/>@FreeBSD.org</a><br/><xsl:copy-of select="$copyright"/>
  </xsl:variable>

  <xsl:variable name="home">
    <a href="{$base}/index.html"><img src="{$base}/gifs/home.gif" alt="FreeBSD Home Page" border="0" align="right" width="101" height="33"/></a>
  </xsl:variable>

  <xsl:variable name="header1">
    <head>
      <title><xsl:value-of select="$title"/></title>

      <meta http-equiv="Content-Type" content="text/html; charset=EUC-JP"/>
      <meta name="MSSmartTagsPreventParsing" content="TRUE"/>
    </head>
  </xsl:variable>

  <xsl:attribute-set name="att.body">
    <xsl:attribute name="text">#000000</xsl:attribute>
    <xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
    <xsl:attribute name="alink">#FFCC33</xsl:attribute>
  </xsl:attribute-set>

  <xsl:variable name="header2">
    <img src="{$base}/../gifs/bar.gif" alt="メニュー" width="565" 
	 height="33" border="0" usemap="#bar"/>
      
    <h1 align="left"><font color="#660000"><xsl:value-of select="$title"/></font></h1>

    <br clear="all"/>

    <map name="bar">
      <area shape="rect" coords="1,1,111,31" 
	    href="{$base}/index.html" alt="トップページ"/>
      <area shape="rect" coords="112,11,196,31" 
	    href="{$base}/ports/index.html" alt="アプリケーション"/>
      <area shape="rect" coords="196,12,257,33" 
	      href="{$base}/support.html" alt="サポート"/>
      <area shape="rect" coords="256,12,365,33" 
	    href="{$base}/docs.html" alt="ドキュメント"/> 
      <area shape="rect" coords="366,13,424,32" 
	    href="{$base}/commercial/commercial.html" alt="ベンダ"/>
      <area shape="rect" coords="425,16,475,32" 
	      href="{$base}/search/search.html" alt="検索"/>
      <area shape="rect" coords="477,16,516,33" 
	    href="{$base}/search/index-site.html" alt="索引"/>
      <area shape="rect" coords="516,15,562,33" 
	    href="{$base}/index.html" alt="トップページ"/>
	<area shape="rect" coords="0,0,564,32" 
	      href="{$base}/index.html" alt="トップページ"/>
    </map>
  </xsl:variable>

  <xsl:variable name="footer">
    <hr noshade="noshade"/>
    <address><xsl:copy-of select="$author"/><br/>
      <xsl:copy-of select="$date"/><br/>
      (日本語訳に関するお問い合わせは
      <a href="http://www.jp.FreeBSD.org/ml.html#doc-jp">doc-jp@jp.FreeBSD.org</a>
      までお願いします)
    </address>
  </xsl:variable>
  
  <xsl:variable name="rel.current" select='"5.1"'/>
  <xsl:variable name="u.rel.notes">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel.announce">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel.errata">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/errata.html</xsl:variable>

  <xsl:variable name="u.rel.hardware">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/hardware.html</xsl:variable>

  <xsl:variable name="u.rel.early">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel.current"/>R/early-adopter.html</xsl:variable>
  
  <xsl:variable name="rel2.current" select='"4.8"'/>
  <xsl:variable name="u.rel2.notes">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/relnotes.html</xsl:variable>

  <xsl:variable name="u.rel2.announce">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/announce.html</xsl:variable>
  <xsl:variable name="u.rel2.errata">
    <xsl:value-of select="$base"/>/releases/<xsl:value-of select="$rel2.current"/>R/errata.html</xsl:variable>
  <xsl:variable name="u.rel2.hardware">
    <xsl:value-of select="$enbase"/>/releases/<xsl:value-of select="$rel2.current"/>R/hardware.html</xsl:variable>
  <!-- 2002/01/02:hrs - when the translation is finished, $enbase should be "$base" -->

</xsl:stylesheet>
