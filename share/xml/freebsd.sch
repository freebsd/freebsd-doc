<?xml version="1.0" encoding="iso-8859-1"?>

<!-- $FreeBSD$ -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron">
  <pattern name="Check file reference validity">
    <rule context="//*/@fileref">
      <assert test="contains(., '.')">File reference does not have an extension.</assert>
    </rule>
  </pattern>
</schema>
