<?xml version="1.0" encoding="iso-8859-1"?>

<!-- $FreeBSD$ -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <pattern name="Check file reference validity">
    <rule context="//imagedata|//graphic">
      <report test="contains(@fileref, '.')">Image reference (<xsl:value-of select="@fileref"/>) cannot have an extension; the proper format is inferred by the output type to generate.</report>
      <report test="@format">Image reference (<xsl:value-of select="@fileref"/>) format must not be specified; it is inferred by the output type to generate.</report>
    </rule>
  </pattern>

  <pattern name="Check filenames">
    <rule context="//filename">
      <report test="@role = 'directory'">Filename (<xsl:value-of select="."/>) has role="directory"; use class="directory"</report>
    </rule>
  </pattern>

  <pattern name="Check cross-reference validity">
    <rule context="//link">
      <assert test="* or normalize-space()">Link (<xsl:value-of select="@linkend"/>) element must have a content; or use xref to auto-generate the linking text.</assert>
    </rule>
  </pattern>

  <pattern name="Check callout validity">
    <rule context="/">
      <report test="//screenco">Callouts with screenco are not supported; use screen and co instead.</report>
      <report test="//programlistingco">Callouts with programlistingco are not supported; use programlisting and co instead.</report>
      <report test="//graphicco">Callouts on graphics are not supported.</report>
    </rule>
  </pattern>

  <pattern name="Check profiling attributes">
    <rule context="//*/@edition">
      <assert test="(. = 'online') or (. = 'print')">Invalid edition value (<xsl:value-of select="."/>); must be either 'online' or "print".</assert>
    </rule>
    <rule context="//*/@os">
      <assert test="(. = 'freebsd8') or (. = 'freebsd9') or (. = 'freebsd10')">Invalid os value (<xsl:value-of select="."/>); must be either 'freebsd8', 'freebsd9' or 'freebsd10'.</assert>
    </rule>
  </pattern>

  <pattern name="Check title">
    <rule context="//book">
      <assert test="title or bookinfo/title">There must be a title either in book or in bookinfo.</assert>
    </rule>
    <rule context="//article">
      <assert test="title or articleinfo/title">There must be a title either in article or in articleinfo.</assert>
    </rule>
    <rule context="//chapter">
      <assert test="title or chapterinfo/title">There must be a title either in chapter (<xsl:value-of select="@id"/>) or in chapterinfo.</assert>
    </rule>
    <rule context="//sect1">
      <assert test="title or sect1info/title">There must be a title either in sect1 (<xsl:value-of select="@id"/>) or in sect1info.</assert>
    </rule>
    <rule context="//sect2">
      <assert test="title or sect2info/title">There must be a title either in sect2 (<xsl:value-of select="@id"/>) or in sect2info.</assert>
    </rule>
    <rule context="//sect3">
      <assert test="title or sect3info/title">There must be a title either in sect3 (<xsl:value-of select="@id"/>) or in sect3info.</assert>
    </rule>
  </pattern>

  <pattern name="Check table entries">
    <rule context="//entry">
      <report test="@colname and @spanname">You cannot use both colname and spanname attributes on table entries.</report>
    </rule>
  </pattern>

<!--
	Backported constraints from DocBook 5.0
-->

   <pattern name="Glossary 'firstterm' type constraint">
      <rule context="firstterm[@linkend]">
         <assert test="name(//*[@id=current()/@linkend]) = 'glossentry'">@linkend on firstterm must point to a glossentry.</assert>
      </rule>
   </pattern>

   <pattern name="Footnote reference type constraint">
      <rule context="footnoteref">
         <assert test="name(//*[@id=current()/@linkend]) = 'footnote'">@linkend on footnoteref must point to a footnote.</assert>
      </rule>
   </pattern>

   <pattern name="Glossary 'glossterm' type constraint">
      <rule context="glossterm[@linkend]">
         <assert test="name(//*[@id=current()/@linkend]) = 'glossentry'">@linkend on glossterm must point to a glossentry.</assert>
      </rule>
   </pattern>

   <pattern name="Synopsis fragment type constraint">
      <rule context="synopfragmentref">
         <assert test="name(//*[@id=current()/@linkend]) = 'synopfragment'">@linkend on synopfragmentref must point to a synopfragment.</assert>
      </rule>
   </pattern>

   <pattern name="Glosssary 'see' type constraint">
      <rule context="glosssee[@otherterm]">
         <assert test="name(//*[@id=current()/@otherterm]) = 'glossentry'">@otherterm on glosssee must point to a glossentry.</assert>
      </rule>
   </pattern>

   <pattern name="Glossary 'seealso' type constraint">
      <rule context="glossseealso[@otherterm]">
         <assert test="name(//*[@id=current()/@otherterm]) = 'glossentry'">@otherterm on glossseealso must point to a glossentry.</assert>
      </rule>
   </pattern>

   <pattern name="Glossary term definition constraint">
      <rule context="termdef">
         <assert test="count(firstterm) = 1">A termdef must contain exactly one firstterm</assert>
      </rule>
   </pattern>

   <pattern name="Cardinality of segments and titles">
      <rule context="seglistitem">
         <assert test="count(seg) = count(../segtitle)">The number of seg elements must be the same as the number of segtitle elements in the parent segmentedlist</assert>
      </rule>
   </pattern>

   <pattern name="Element exclusion">
      <rule context="annotation">
         <assert test="not(.//annotation)">annotation must not occur in the descendants of annotation</assert>
      </rule>
      <rule context="caution">
         <assert test="not(.//caution)">caution must not occur in the descendants of caution</assert>
         <assert test="not(.//important)">important must not occur in the descendants of caution</assert>
         <assert test="not(.//note)">note must not occur in the descendants of caution</assert>
         <assert test="not(.//tip)">tip must not occur in the descendants of caution</assert>
         <assert test="not(.//warning)">warning must not occur in the descendants of caution</assert>
      </rule>
      <rule context="important">
         <assert test="not(.//caution)">caution must not occur in the descendants of important</assert>
         <assert test="not(.//important)">important must not occur in the descendants of important</assert>
         <assert test="not(.//note)">note must not occur in the descendants of important</assert>
         <assert test="not(.//tip)">tip must not occur in the descendants of important</assert>
         <assert test="not(.//warning)">warning must not occur in the descendants of important</assert>
      </rule>
      <rule context="note">
         <assert test="not(.//caution)">caution must not occur in the descendants of note</assert>
         <assert test="not(.//important)">important must not occur in the descendants of note</assert>
         <assert test="not(.//note)">note must not occur in the descendants of note</assert>
         <assert test="not(.//tip)">tip must not occur in the descendants of note</assert>
         <assert test="not(.//warning)">warning must not occur in the descendants of note</assert>
      </rule>
      <rule context="tip">
         <assert test="not(.//caution)">caution must not occur in the descendants of tip</assert>
         <assert test="not(.//important)">important must not occur in the descendants of tip</assert>
         <assert test="not(.//note)">note must not occur in the descendants of tip</assert>
         <assert test="not(.//tip)">tip must not occur in the descendants of tip</assert>
         <assert test="not(.//warning)">warning must not occur in the descendants of tip</assert>
      </rule>
      <rule context="warning">
         <assert test="not(.//caution)">caution must not occur in the descendants of warning</assert>
         <assert test="not(.//important)">important must not occur in the descendants of warning</assert>
         <assert test="not(.//note)">note must not occur in the descendants of warning</assert>
         <assert test="not(.//tip)">tip must not occur in the descendants of warning</assert>
         <assert test="not(.//warning)">warning must not occur in the descendants of warning</assert>
      </rule>
      <rule context="caption">
         <assert test="not(.//caution)">caution must not occur in the descendants of caption</assert>
         <assert test="not(.//equation)">equation must not occur in the descendants of caption</assert>
         <assert test="not(.//example)">example must not occur in the descendants of caption</assert>
         <assert test="not(.//figure)">figure must not occur in the descendants of caption</assert>
         <assert test="not(.//important)">important must not occur in the descendants of caption</assert>
         <assert test="not(.//note)">note must not occur in the descendants of caption</assert>
         <assert test="not(.//sidebar)">sidebar must not occur in the descendants of caption</assert>
         <assert test="not(.//table)">table must not occur in the descendants of caption</assert>
         <assert test="not(.//task)">task must not occur in the descendants of caption</assert>
         <assert test="not(.//tip)">tip must not occur in the descendants of caption</assert>
         <assert test="not(.//warning)">warning must not occur in the descendants of caption</assert>
      </rule>
      <rule context="equation">
         <assert test="not(.//caution)">caution must not occur in the descendants of equation</assert>
         <assert test="not(.//equation)">equation must not occur in the descendants of equation</assert>
         <assert test="not(.//example)">example must not occur in the descendants of equation</assert>
         <assert test="not(.//figure)">figure must not occur in the descendants of equation</assert>
         <assert test="not(.//important)">important must not occur in the descendants of equation</assert>
         <assert test="not(.//note)">note must not occur in the descendants of equation</assert>
         <assert test="not(.//table)">table must not occur in the descendants of equation</assert>
         <assert test="not(.//tip)">tip must not occur in the descendants of equation</assert>
         <assert test="not(.//warning)">warning must not occur in the descendants of equation</assert>
      </rule>
      <rule context="example">
         <assert test="not(.//caution)">caution must not occur in the descendants of example</assert>
         <assert test="not(.//equation)">equation must not occur in the descendants of example</assert>
         <assert test="not(.//example)">example must not occur in the descendants of example</assert>
         <assert test="not(.//figure)">figure must not occur in the descendants of example</assert>
         <assert test="not(.//important)">important must not occur in the descendants of example</assert>
         <assert test="not(.//note)">note must not occur in the descendants of example</assert>
         <assert test="not(.//table)">table must not occur in the descendants of example</assert>
         <assert test="not(.//tip)">tip must not occur in the descendants of example</assert>
         <assert test="not(.//warning)">warning must not occur in the descendants of example</assert>
      </rule>
      <rule context="figure">
         <assert test="not(.//caution)">caution must not occur in the descendants of figure</assert>
         <assert test="not(.//equation)">equation must not occur in the descendants of figure</assert>
         <assert test="not(.//example)">example must not occur in the descendants of figure</assert>
         <assert test="not(.//figure)">figure must not occur in the descendants of figure</assert>
         <assert test="not(.//important)">important must not occur in the descendants of figure</assert>
         <assert test="not(.//note)">note must not occur in the descendants of figure</assert>
         <assert test="not(.//table)">table must not occur in the descendants of figure</assert>
         <assert test="not(.//tip)">tip must not occur in the descendants of figure</assert>
         <assert test="not(.//warning)">warning must not occur in the descendants of figure</assert>
      </rule>
      <rule context="table">
         <assert test="not(.//caution)">caution must not occur in the descendants of table</assert>
         <assert test="not(.//equation)">equation must not occur in the descendants of table</assert>
         <assert test="not(.//example)">example must not occur in the descendants of table</assert>
         <assert test="not(.//figure)">figure must not occur in the descendants of table</assert>
         <assert test="not(.//important)">important must not occur in the descendants of table</assert>
         <assert test="not(.//informaltable)">informaltable must not occur in the descendants of table</assert>
         <assert test="not(.//note)">note must not occur in the descendants of table</assert>
         <assert test="not(.//tip)">tip must not occur in the descendants of table</assert>
         <assert test="not(.//warning)">warning must not occur in the descendants of table</assert>
      </rule>
      <rule context="footnote">
         <assert test="not(.//caution)">caution must not occur in the descendants of footnote</assert>
         <assert test="not(.//epigraph)">epigraph must not occur in the descendants of footnote</assert>
         <assert test="not(.//equation)">equation must not occur in the descendants of footnote</assert>
         <assert test="not(.//example)">example must not occur in the descendants of footnote</assert>
         <assert test="not(.//figure)">figure must not occur in the descendants of footnote</assert>
         <assert test="not(.//footnote)">footnote must not occur in the descendants of footnote</assert>
         <assert test="not(.//important)">important must not occur in the descendants of footnote</assert>
         <assert test="not(.//indexterm)">indexterm must not occur in the descendants of footnote</assert>
         <assert test="not(.//note)">note must not occur in the descendants of footnote</assert>
         <assert test="not(.//sidebar)">sidebar must not occur in the descendants of footnote</assert>
         <assert test="not(.//table)">table must not occur in the descendants of footnote</assert>
         <assert test="not(.//task)">task must not occur in the descendants of footnote</assert>
         <assert test="not(.//tip)">tip must not occur in the descendants of footnote</assert>
         <assert test="not(.//warning)">warning must not occur in the descendants of footnote</assert>
      </rule>
      <rule context="sidebar">
         <assert test="not(.//sidebar)">sidebar must not occur in the descendants of sidebar</assert>
      </rule>
   </pattern>
</schema>
