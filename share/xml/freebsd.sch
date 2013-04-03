<?xml version="1.0" encoding="iso-8859-1"?>

<!-- $FreeBSD$ -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <pattern name="Check file reference validity">
    <rule context="//imagedata|//graphic">
      <report test="contains(@fileref, '.')">Image reference (<xsl:value-of select="@fileref"/>) cannot have an extension; the proper format is inferred by the output type to generate.</report>
      <report test="@format">Image reference (<xsl:value-of select="@fileref"/>) format must not be specified; it is inferred by the output type to generate.</report>
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
</schema>
