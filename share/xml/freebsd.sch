<?xml version="1.0" encoding="iso-8859-1"?>

<!-- $FreeBSD$ -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <ns prefix="db" uri="http://docbook.org/ns/docbook"/>

  <pattern name="Check file reference validity">
    <rule context="//db:imagedata|//db:graphic">
      <report test="contains(@fileref, '.')">Image reference (<xsl:value-of select="@fileref"/>) cannot have an extension; the proper format is inferred by the output type to generate.</report>
      <report test="@format">Image reference (<xsl:value-of select="@fileref"/>) format must not be specified; it is inferred by the output type to generate.</report>
    </rule>
  </pattern>

<!-- XXX: temporarily turned off
  <pattern name="Check filenames">
    <rule context="//db:filename">
      <report test="@role = 'directory'">Filename (<xsl:value-of select="."/>) has role="directory"; use class="directory"</report>
      <report test="@role = 'package'">Filename (<xsl:value-of select="."/>) has role="package"; use the package element</report>
      <report test="@role = 'port'">Filename (<xsl:value-of select="."/>) has role="port"; use the package element with role="port"</report>
      <report test="@role != 'directory' and @role != 'package' and role != 'port'">Filename (<xsl:value-of select="."/>) has role attribute set; consider a properly set class attribute</report>
    </rule>
  </pattern>
-->

<!-- XXX: temporarily turned off
  <pattern name="Check cross-reference validity">
    <rule context="//db:link">
      <assert test="* or normalize-space()">Link (<xsl:value-of select="@linkend"/>) element must have a content; or use xref to auto-generate the linking text.</assert>
    </rule>
  </pattern>
-->

  <pattern name="Check callout validity">
    <rule context="/">
<!-- XXX
      <report test="//db:screenco">Callouts with screenco are not supported; use screen and co instead.</report>
-->
      <report test="//db:programlistingco">Callouts with programlistingco are not supported; use programlisting and co instead.</report>
      <report test="//db:graphicco">Callouts on graphics are not supported.</report>
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

  <pattern name="Check titles">
    <rule context="//db:book|//db:article|//db:chapter|//db:section|//db:sect1|//db:sect2|//db:sect3|//db:sect4|//db:sect5">
      <assert test="db:title or db:info/db:title">There must be a title either in the doc component (<xsl:value-of select="@xml:id"/>) or in the info element.</assert>
      <report test="db:title and db:info/db:title">There must be exactly one title for a doc component (<xsl:value-of select="@xml:id"/>).</report>
    </rule>
  </pattern>

  <pattern name="Check tables">
    <rule context="//db:entry">
      <report test="@colname and @spanname">You cannot use both colname and spanname attributes on table entries.</report>
    </rule>
  </pattern>

  <pattern name="Check indexes">
    <rule context="//db:indexterm">
      <report test="../db:question">Indexterm (<xsl:value-of select="./db:primary"/>) is not allowed directly in question, place it into a concrete paragraph (in section <xsl:value-of select="(ancestor::db:sect5[last()]|ancestor::db:sect4[last()]|ancestor::db:sect3[last()]|ancestor::db:sect2[last()]|ancestor::db:sect1[last()]|ancestor::db:chapter[last()])[last()]/@xml:id"/>).</report>
      <report test="../db:answer">Indexterm (<xsl:value-of select="./db:primary"/>) is not allowed directly in answer, place it into a concrete paragraph (in section <xsl:value-of select="(ancestor::db:sect5[last()]|ancestor::db:sect4[last()]|ancestor::db:sect3[last()]|ancestor::db:sect2[last()]|ancestor::db:sect1[last()]|ancestor::db:chapter[last()])[last()]/@xml:id"/>).</report>
      <report test="../db:listitem">Indexterm (<xsl:value-of select="./dbprimary"/>) is not allowed directly in listitem, place it into a concrete paragraph (in section <xsl:value-of select="(ancestor::db:sect5[last()]|ancestor::db:sect4[last()]|ancestor::db:sect3[last()]|ancestor::db:sect2[last()]|ancestor::db:sect1[last()]|ancestor::db:chapter[last()])[last()]/@xml:id"/>).</report>
    </rule>
  </pattern>

<!--
	Backported constraints from DocBook 5.0
-->

  <pattern name="Glossary 'firstterm' type constraint">
     <rule context="db:firstterm[@linkend]">
        <assert test="local-name(//*[@xml:id=current()/@linkend]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'">@linkend on firstterm must point to a glossentry.</assert>
     </rule>
  </pattern>
  <pattern name="Footnote reference type constraint">
     <rule context="db:footnoteref">
        <assert test="local-name(//*[@xml:id=current()/@linkend]) = 'footnote' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'">@linkend on footnoteref must point to a footnote.</assert>
     </rule>
  </pattern>
  <pattern name="Glossary 'glossterm' type constraint">
     <rule context="db:glossterm[@linkend]">
        <assert test="local-name(//*[@xml:id=current()/@linkend]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'">@linkend on glossterm must point to a glossentry.</assert>
     </rule>
  </pattern>
  <pattern name="Synopsis fragment type constraint">
     <rule context="db:synopfragmentref">
        <assert test="local-name(//*[@xml:id=current()/@linkend]) = 'synopfragment' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'">@linkend on synopfragmentref must point to a synopfragment.</assert>
     </rule>
  </pattern>
  <pattern name="Glosssary 'see' type constraint">
     <rule context="db:glosssee[@otherterm]">
        <assert test="local-name(//*[@xml:id=current()/@otherterm]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@otherterm]) = 'http://docbook.org/ns/docbook'">@otherterm on glosssee must point to a glossentry.</assert>
     </rule>
  </pattern>
  <pattern name="Glossary 'seealso' type constraint">
     <rule context="db:glossseealso[@otherterm]">
        <assert test="local-name(//*[@xml:id=current()/@otherterm]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@otherterm]) = 'http://docbook.org/ns/docbook'">@otherterm on glossseealso must point to a glossentry.</assert>
     </rule>
  </pattern>
  <pattern name="Glossary term definition constraint">
     <rule context="db:termdef">
        <assert test="count(db:firstterm) = 1">A termdef must contain exactly one firstterm</assert>
     </rule>
  </pattern>
  <pattern name="Cardinality of segments and titles">
     <rule context="db:seglistitem">
        <assert test="count(db:seg) = count(../db:segtitle)">The number of seg elements must be the same as the number of segtitle elements in the parent segmentedlist</assert>
     </rule>
  </pattern>
  <pattern name="Root must have version">
     <rule context="/db:para">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:set">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:book">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:dedication">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:acknowledgements">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:colophon">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:appendix">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:chapter">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:part">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:preface">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:section">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:article">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:sect1">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:sect2">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:sect3">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:sect4">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:sect5">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:reference">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:refentry">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:refsection">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:refsect1">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:refsect2">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:refsect3">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:glossary">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:bibliography">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:index">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:setindex">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
     <rule context="/db:toc">
        <assert test="@version">The root element must have a version attribute.</assert>
     </rule>
  </pattern>
  <pattern name="Element exclusion">
     <rule context="db:annotation">
        <assert test="not(.//db:annotation)">annotation must not occur in the descendants of annotation</assert>
     </rule>
     <rule context="db:caution">
        <assert test="not(.//db:caution)">caution must not occur in the descendants of caution</assert>
        <assert test="not(.//db:important)">important must not occur in the descendants of caution</assert>
        <assert test="not(.//db:note)">note must not occur in the descendants of caution</assert>
        <assert test="not(.//db:tip)">tip must not occur in the descendants of caution</assert>
        <assert test="not(.//db:warning)">warning must not occur in the descendants of caution</assert>
     </rule>
     <rule context="db:important">
        <assert test="not(.//db:caution)">caution must not occur in the descendants of important</assert>
        <assert test="not(.//db:important)">important must not occur in the descendants of important</assert>
        <assert test="not(.//db:note)">note must not occur in the descendants of important</assert>
        <assert test="not(.//db:tip)">tip must not occur in the descendants of important</assert>
        <assert test="not(.//db:warning)">warning must not occur in the descendants of important</assert>
     </rule>
     <rule context="db:note">
        <assert test="not(.//db:caution)">caution must not occur in the descendants of note</assert>
        <assert test="not(.//db:important)">important must not occur in the descendants of note</assert>
        <assert test="not(.//db:note)">note must not occur in the descendants of note</assert>
        <assert test="not(.//db:tip)">tip must not occur in the descendants of note</assert>
        <assert test="not(.//db:warning)">warning must not occur in the descendants of note</assert>
     </rule>
     <rule context="db:tip">
        <assert test="not(.//db:caution)">caution must not occur in the descendants of tip</assert>
        <assert test="not(.//db:important)">important must not occur in the descendants of tip</assert>
        <assert test="not(.//db:note)">note must not occur in the descendants of tip</assert>
        <assert test="not(.//db:tip)">tip must not occur in the descendants of tip</assert>
        <assert test="not(.//db:warning)">warning must not occur in the descendants of tip</assert>
     </rule>
     <rule context="db:warning">
        <assert test="not(.//db:caution)">caution must not occur in the descendants of warning</assert>
        <assert test="not(.//db:important)">important must not occur in the descendants of warning</assert>
        <assert test="not(.//db:note)">note must not occur in the descendants of warning</assert>
        <assert test="not(.//db:tip)">tip must not occur in the descendants of warning</assert>
        <assert test="not(.//db:warning)">warning must not occur in the descendants of warning</assert>
     </rule>
     <rule context="db:caption">
        <assert test="not(.//db:caution)">caution must not occur in the descendants of caption</assert>
        <assert test="not(.//db:equation)">equation must not occur in the descendants of caption</assert>
        <assert test="not(.//db:example)">example must not occur in the descendants of caption</assert>
        <assert test="not(.//db:figure)">figure must not occur in the descendants of caption</assert>
        <assert test="not(.//db:important)">important must not occur in the descendants of caption</assert>
        <assert test="not(.//db:note)">note must not occur in the descendants of caption</assert>
        <assert test="not(.//db:sidebar)">sidebar must not occur in the descendants of caption</assert>
        <assert test="not(.//db:table)">table must not occur in the descendants of caption</assert>
        <assert test="not(.//db:task)">task must not occur in the descendants of caption</assert>
        <assert test="not(.//db:tip)">tip must not occur in the descendants of caption</assert>
        <assert test="not(.//db:warning)">warning must not occur in the descendants of caption</assert>
     </rule>
     <rule context="db:equation">
        <assert test="not(.//db:caution)">caution must not occur in the descendants of equation</assert>
        <assert test="not(.//db:equation)">equation must not occur in the descendants of equation</assert>
        <assert test="not(.//db:example)">example must not occur in the descendants of equation</assert>
        <assert test="not(.//db:figure)">figure must not occur in the descendants of equation</assert>
        <assert test="not(.//db:important)">important must not occur in the descendants of equation</assert>
        <assert test="not(.//db:note)">note must not occur in the descendants of equation</assert>
        <assert test="not(.//db:table)">table must not occur in the descendants of equation</assert>
        <assert test="not(.//db:tip)">tip must not occur in the descendants of equation</assert>
        <assert test="not(.//db:warning)">warning must not occur in the descendants of equation</assert>
     </rule>
     <rule context="db:example">
        <assert test="not(.//db:caution)">caution must not occur in the descendants of example</assert>
        <assert test="not(.//db:equation)">equation must not occur in the descendants of example</assert>
        <assert test="not(.//db:example)">example must not occur in the descendants of example</assert>
        <assert test="not(.//db:figure)">figure must not occur in the descendants of example</assert>
        <assert test="not(.//db:important)">important must not occur in the descendants of example</assert>
        <assert test="not(.//db:note)">note must not occur in the descendants of example</assert>
        <assert test="not(.//db:table)">table must not occur in the descendants of example</assert>
        <assert test="not(.//db:tip)">tip must not occur in the descendants of example</assert>
        <assert test="not(.//db:warning)">warning must not occur in the descendants of example</assert>
     </rule>
     <rule context="db:figure">
        <assert test="not(.//db:caution)">caution must not occur in the descendants of figure</assert>
        <assert test="not(.//db:equation)">equation must not occur in the descendants of figure</assert>
        <assert test="not(.//db:example)">example must not occur in the descendants of figure</assert>
        <assert test="not(.//db:figure)">figure must not occur in the descendants of figure</assert>
        <assert test="not(.//db:important)">important must not occur in the descendants of figure</assert>
        <assert test="not(.//db:note)">note must not occur in the descendants of figure</assert>
        <assert test="not(.//db:table)">table must not occur in the descendants of figure</assert>
        <assert test="not(.//db:tip)">tip must not occur in the descendants of figure</assert>
        <assert test="not(.//db:warning)">warning must not occur in the descendants of figure</assert>
     </rule>
     <rule context="db:table">
        <assert test="not(.//db:caution)">caution must not occur in the descendants of table</assert>
        <assert test="not(.//db:equation)">equation must not occur in the descendants of table</assert>
        <assert test="not(.//db:example)">example must not occur in the descendants of table</assert>
        <assert test="not(.//db:figure)">figure must not occur in the descendants of table</assert>
        <assert test="not(.//db:important)">important must not occur in the descendants of table</assert>
        <assert test="not(.//db:informaltable)">informaltable must not occur in the descendants of table</assert>
        <assert test="not(.//db:note)">note must not occur in the descendants of table</assert>
        <assert test="not(.//db:tip)">tip must not occur in the descendants of table</assert>
        <assert test="not(.//db:warning)">warning must not occur in the descendants of table</assert>
     </rule>
     <rule context="db:footnote">
        <assert test="not(.//db:caution)">caution must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:epigraph)">epigraph must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:equation)">equation must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:example)">example must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:figure)">figure must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:footnote)">footnote must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:important)">important must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:indexterm)">indexterm must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:note)">note must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:sidebar)">sidebar must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:table)">table must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:task)">task must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:tip)">tip must not occur in the descendants of footnote</assert>
        <assert test="not(.//db:warning)">warning must not occur in the descendants of footnote</assert>
     </rule>
     <rule context="db:sidebar">
        <assert test="not(.//db:sidebar)">sidebar must not occur in the descendants of sidebar</assert>
     </rule>
  </pattern>
</schema>
