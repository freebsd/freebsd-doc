<?xml version="1.0" encoding="iso-8859-1"?>

<!-- $FreeBSD$ -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron">
  <pattern name="Check file reference validity">
    <rule context="//*/@fileref">
      <assert test="contains(., '.')">File reference does not have an extension.</assert>
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
      <assert test="(. = 'online') or (. = 'print')">The edition attribute can only be set to 'online' or "print".</assert>
    </rule>
    <rule context="//*/@os">
      <assert test="(. = 'freebsd8') or (. = 'freebsd9') or (. = 'freebsd10')">The os attribute can only be set to 'freebsd8', 'freebsd9' or 'freebsd10'.</assert>
    </rule>
  </pattern>
</schema>
