<?xml version='1.0' encoding='utf-8'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

  <!-- Pull in the CJK-specific stylesheet -->
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/freebsd-fo-cjk.xsl"/>

  <!--
	CHINESE-SPECIFIC PARAMETERS
  -->

  <xsl:param name="local.l10n.xml" select="document('')"/>

  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="zh_cn">
      <l:context name="title-numbered">
	<l:template name="appendix" text="附录 %n. %t"/>
	<l:template name="article/appendix" text="%n. %t"/>
	<l:template name="bridgehead" text="%n. %t"/>
	<l:template name="chapter" text="第 %n 章 %t"/>
	<l:template name="part" text="部分 %n. %t"/>
	<l:template name="sect1" text="%n. %t"/>
	<l:template name="sect2" text="%n. %t"/>
	<l:template name="sect3" text="%n. %t"/>
	<l:template name="sect4" text="%n. %t"/>
	<l:template name="sect5" text="%n. %t"/>
	<l:template name="section" text="%n. %t"/>
	<l:template name="simplesect" text="%t"/>
	<l:template name="topic" text="%t" lang="en"/>
      </l:context>
      <l:context name="title">
	<l:template name="appendix" text="附录 %n. %t"/>
	<l:template name="chapter" text="第 %n 章 %t"/>
	<l:template name="equation" text="公式 %n. %t"/>
	<l:template name="example" text="例 %n. %t"/>
	<l:template name="figure" text="图 %n. %t"/>
	<l:template name="part" text="第 %n 部分 %t"/>
	<l:template name="procedure.formal" text="过程 %n. %t"/>
	<l:template name="productionset.formal" text="产品 %n"/>
	<l:template name="table" text="表 %n. %t"/>
       </l:context>
      <l:context name="xref">
	<l:template name="answer" text="答： %n"/>
	<l:template name="qandaentry" text="问： %n"/>
	<l:template name="question" text="问： %n"/>
	<l:template name="olink.document.citation" text=" in %o"/>
	<l:template name="olink.page.citation" text=" (page %p)"/>
	<l:template name="page.citation" text=" [%p]"/>
	<l:template name="page" text="(第 %p 页)"/>
	<l:template name="docname" text=" 在 %o"/>
	<l:template name="docnamelong" text=" 在文档标题 %o"/>
	<l:template name="pageabbrev" text="(第 %p 页)"/>
	<l:template name="Page" text="第 %p 页"/>
      </l:context>
      <l:context name="xref-number">
	<l:template name="answer" text="答： %n"/>
	<l:template name="appendix" text="附录 %n"/>
	<l:template name="bridgehead" text="第 %n 节"/>
	<l:template name="chapter" text="第 %n 章"/>
	<l:template name="equation" text="公式 %n"/>
	<l:template name="example" text="例 %n"/>
	<l:template name="figure" text="图 %n"/>
	<l:template name="part" text="第 %n 部分"/>
	<l:template name="procedure" text="过程 %n"/>
	<l:template name="productionset" text="产品 %n"/>
	<l:template name="qandadiv" text="答问集 %n"/>
	<l:template name="qandaentry" text="问： %n"/>
	<l:template name="question" text="问： %n"/>
	<l:template name="sect1" text="第 %n 节"/>
	<l:template name="sect2" text="第 %n 节"/>
	<l:template name="sect3" text="第 %n 节"/>
	<l:template name="sect4" text="第 %n 节"/>
	<l:template name="sect5" text="第 %n 节"/>
	<l:template name="section" text="第 %n 节"/>
	<l:template name="table" text="表 %n"/>
      </l:context>
      <l:context name="xref-number-and-title">
	<l:template name="appendix" text="附录 %n, %t"/>
	<l:template name="bridgehead" text="第 %n 节 “%t”"/>
	<l:template name="chapter" text="第 %n 章 %t"/>
	<l:template name="equation" text="公式 %n “%t”"/>
	<l:template name="example" text="例 %n “%t”"/>
	<l:template name="figure" text="图 %n “%t”"/>
	<l:template name="part" text="第 %n 部分 “%t”"/>
	<l:template name="procedure" text="过程 %n, “%t”"/>
	<l:template name="productionset" text="产品 %n, “%t”"/>
	<l:template name="qandadiv" text="答问集 %n, “%t”"/>
	<l:template name="sect1" text="第 %n 节 “%t”"/>
	<l:template name="sect2" text="第 %n 节 “%t”"/>
	<l:template name="sect3" text="第 %n 节 “%t”"/>
	<l:template name="sect4" text="第 %n 节 “%t”"/>
	<l:template name="sect5" text="第 %n 节 “%t”"/>
	<l:template name="section" text="第 %n 节 “%t”"/>
	<l:template name="table" text="表 %n “%t”"/>
      </l:context>
    </l:l10n>
  </l:i18n>

  <!-- Base fonts -->
  <xsl:param name="body.font.family">Gentium Plus, AR PL SungtiL GB</xsl:param>
  <xsl:param name="sans.font.family">Droid Sans, AR PL KaitiM GB</xsl:param>
  <xsl:param name="title.font.family">Droid Sans, Droid Sans Fallback</xsl:param>
  <xsl:param name="monospace.font.family">Droid Sans Mono, Droid Sans Fallback</xsl:param>

</xsl:stylesheet>
