<!--
Stylesheet to convert DocBook Slides XML files into OpenOffice presentations.

Copyright(c) 2005 Murray Stokely.  All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED.  IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
SUCH DAMAGE.

$FreeBSD$
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
 xmlns:office="http://openoffice.org/2000/office"
 xmlns:text="http://openoffice.org/2000/text"
 xmlns:draw="http://openoffice.org/2000/drawing"
 xmlns:form="http://openoffice.org/2000/form"
 xmlns:xlink="http://www.w3.org/1999/xlink"
 xmlns:svg="http://www.w3.org/2000/svg"
 xmlns:presentation="http://openoffice.org/2000/presentation">

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$Id: BSDi.xsl,v 1.1 2005-08-29 02:15:24 murray Exp $'"/>

  <xsl:output type="xml" encoding="iso-8859-1" indent="yes" />
  <xsl:include href="include.xsl"/>

<!-- Want this output:
<!DOCTYPE office:document-content PUBLIC "-//OpenOffice.org//DTD OfficeDocument 1.0//EN" "office.dtd">
-->

  <xsl:template match="slides">
<office:document-content
xmlns:office="http://openoffice.org/2000/office"
xmlns:style="http://openoffice.org/2000/style"
xmlns:text="http://openoffice.org/2000/text"
xmlns:table="http://openoffice.org/2000/table"
xmlns:draw="http://openoffice.org/2000/drawing"
xmlns:fo="http://www.w3.org/1999/XSL/Format"
xmlns:number="http://openoffice.org/2000/datastyle"
xmlns:chart="http://openoffice.org/2000/chart"
xmlns:dr3d="http://openoffice.org/2000/dr3d"
xmlns:math="http://www.w3.org/1998/Math/MathML"
xmlns:form="http://openoffice.org/2000/form"
xmlns:script="http://openoffice.org/2000/script"
office:class="presentation" office:version="1.0">
<office:script/>

<office:automatic-styles>
<style:style style:name="dp1" style:family="drawing-page">
<style:properties presentation:background-visible="true" presentation:background-objects-visible="true"/>
</style:style>
<style:style style:name="gr1" style:family="graphics">
<style:properties draw:size-protect="true"/>
</style:style>
<style:style style:name="pr1" style:family="presentation" style:parent-style-name="BSDi - Template-title">
<style:properties draw:fill-color="#ffffff" draw:auto-grow-width="true" fo:min-height="2.793cm"/>
</style:style>
<style:style style:name="pr2" style:family="presentation" style:parent-style-name="BSDi - Template-subtitle">
<style:properties draw:fill-color="#ffffff" draw:auto-grow-width="true" fo:min-height="13.23cm"/>
</style:style>
<style:style style:name="pr3" style:family="presentation" style:parent-style-name="BSDi - Template-notes">
<style:properties draw:fill-color="#ffffff" draw:auto-grow-width="true" fo:min-height="10.588cm"/>
</style:style>
<style:style style:name="pr4" style:family="presentation" style:parent-style-name="BSDi - Template-outline1">
<style:properties draw:stroke="none" draw:fill="none" draw:fill-color="#ffffff" draw:auto-grow-width="true" fo:min-height="13.23cm"/>
</style:style>
<style:style style:name="pr5" style:family="presentation" style:parent-style-name="BSDi - Template-title">
<style:properties draw:fill-color="#ffffff" draw:auto-grow-width="true" fo:min-height="2.999cm"/>
</style:style>
<style:style style:name="pr6" style:family="presentation" style:parent-style-name="BSDi - Template-notes">
<style:properties draw:fill-color="#ffffff" fo:min-height="10.588cm"/>
</style:style>
<style:style style:name="pr7" style:family="presentation" style:parent-style-name="BSDi - Template-title">
<style:properties draw:fill-color="#ffffff" draw:auto-grow-width="true" fo:min-height="2.852cm"/>
</style:style>
<style:style style:name="pr8" style:family="presentation" style:parent-style-name="BSDi - Template-title">
<style:properties draw:fill-color="#ffffff" draw:auto-grow-width="true" fo:min-height="2.954cm"/>
</style:style>
<style:style style:name="pr9" style:family="presentation" style:parent-style-name="BSDi - Template-title">
<style:properties draw:fill-color="#ffffff" draw:auto-grow-width="true" fo:min-height="3.033cm"/>
</style:style>
<style:style style:name="pr10" style:family="presentation" style:parent-style-name="BSDi - Template-title">
<style:properties draw:fill-color="#ffffff" draw:auto-grow-width="true" fo:min-height="3.024cm"/>
</style:style>
<style:style style:name="pr11" style:family="presentation" style:parent-style-name="BSDi - Template-outline1" style:list-style-name="L4">
<style:properties draw:stroke="none" draw:fill="none" draw:fill-color="#ffffff" draw:auto-grow-width="true" fo:min-height="13.23cm"/>
</style:style>
<style:style style:name="P1" style:family="paragraph">
<style:properties fo:margin-left="0cm" fo:margin-right="0cm" fo:text-align="end" fo:text-indent="0cm"/>
</style:style>
<style:style style:name="P2" style:family="paragraph">
<style:properties fo:color="#ffff00" fo:font-family="Arial" style:font-family-generic="swiss" style:font-pitch="variable" fo:font-size="32pt" fo:text-shadow="1pt 1pt"/>
</style:style>
<style:style style:name="P3" style:family="paragraph">
<style:properties fo:margin-left="1.2cm" fo:margin-right="0cm" fo:text-align="center" fo:text-indent="-0.6cm"/>
</style:style>
<style:style style:name="P4" style:family="paragraph"/>
<style:style style:name="P5" style:family="paragraph">
<style:properties fo:margin-left="1.2cm" fo:margin-right="0cm" fo:text-indent="-0.9cm"/>
</style:style>
<style:style style:name="P6" style:family="paragraph">
<style:properties fo:margin-left="1.2cm" fo:margin-right="0cm" fo:text-align="start" fo:text-indent="-0.9cm"/>
</style:style>
<style:style style:name="P7" style:family="paragraph">
<style:properties fo:margin-left="2.4cm" fo:margin-right="0cm" fo:margin-top="0cm" fo:margin-bottom="0.4cm" fo:font-size="28pt" fo:text-indent="-0.8cm"/>
</style:style>
<style:style style:name="P8" style:family="paragraph">
<style:properties fo:font-family="&apos;Times New Roman&apos;" style:font-family-generic="roman" style:font-pitch="variable"/>
</style:style>
<style:style style:name="P9" style:family="paragraph">
<style:properties fo:color="#ffff00" fo:font-family="Arial" style:font-family-generic="swiss" style:font-pitch="variable" fo:text-shadow="1pt 1pt" fo:text-align="end"/>
</style:style>
<style:style style:name="P10" style:family="paragraph">
<style:properties fo:font-family="&apos;Times New Roman&apos;" style:font-family-generic="roman" style:font-pitch="variable" fo:font-size="28pt"/>
</style:style>
<style:style style:name="P11" style:family="paragraph">
<style:properties fo:margin-left="2.4cm" fo:margin-right="0cm" fo:text-indent="-0.8cm"/>
</style:style>
<style:style style:name="P12" style:family="paragraph">
<style:properties fo:margin-left="0cm" fo:margin-right="0cm" fo:text-align="end" text:enable-numbering="false" fo:text-indent="0cm"/>
</style:style>
<style:style style:name="P13" style:family="paragraph">
<style:properties fo:color="#ffff00" fo:font-family="Arial" style:font-family-generic="swiss" style:font-pitch="variable" fo:text-shadow="1pt 1pt" fo:text-align="end" text:enable-numbering="false"/>
</style:style>
<style:style style:name="P14" style:family="paragraph">
<style:properties fo:font-family="&apos;Times New Roman&apos;" style:font-family-generic="roman" style:font-pitch="variable" fo:text-align="start"/>
</style:style>
<style:style style:name="P15" style:family="paragraph">
<style:properties fo:margin-left="0.508cm" fo:margin-right="0cm" fo:text-align="start" text:enable-numbering="false" fo:text-indent="0cm"/>
</style:style>
<style:style style:name="P16" style:family="paragraph">
<style:properties fo:margin-left="0.508cm" fo:margin-right="0cm" fo:font-family="&apos;Times New Roman&apos;" style:font-family-generic="roman" style:font-pitch="variable" fo:font-size="26pt" fo:text-align="start" fo:text-indent="0cm"/>
</style:style>
<style:style style:name="P17" style:family="paragraph">
<style:properties fo:color="#ffff00" style:text-outline="false" fo:font-family="Arial" style:font-family-generic="swiss" style:font-pitch="variable" fo:text-shadow="1pt 1pt" fo:text-align="end"/>
</style:style>
<style:style style:name="T1" style:family="text">
<style:properties fo:color="#ffff00" fo:font-family="Arial" style:font-family-generic="swiss" style:font-pitch="variable" fo:font-size="32pt" fo:text-shadow="1pt 1pt"/>
</style:style>
<style:style style:name="T2" style:family="text">
<style:properties fo:color="#ffff00" fo:font-family="Arial" style:font-family-generic="swiss" style:font-pitch="variable" fo:font-size="20pt" fo:text-shadow="1pt 1pt"/>
</style:style>
<style:style style:name="T3" style:family="text">
<style:properties fo:font-family="&apos;Times New Roman&apos;" style:font-family-generic="roman" style:font-pitch="variable" fo:font-size="44pt" fo:text-shadow="1pt 1pt"/>
</style:style>
<style:style style:name="T4" style:family="text">
<style:properties fo:font-family="&apos;Times New Roman&apos;" style:font-family-generic="roman" style:font-pitch="variable" fo:font-size="26pt"/>
</style:style>
<style:style style:name="T5" style:family="text">
<style:properties fo:color="#2300dc" fo:font-family="&apos;Times New Roman&apos;" style:font-family-generic="roman" style:font-pitch="variable" fo:font-size="26pt"/>
</style:style>
<style:style style:name="T6" style:family="text">
<style:properties fo:font-family="&apos;Times New Roman&apos;" style:font-family-generic="roman" style:font-pitch="variable"/>
</style:style>
<style:style style:name="T7" style:family="text">
<style:properties fo:color="#ffff00" fo:font-family="Arial" style:font-family-generic="swiss" style:font-pitch="variable" fo:text-shadow="1pt 1pt"/>
</style:style>
<style:style style:name="T8" style:family="text">
<style:properties fo:font-family="&apos;Times New Roman&apos;" style:font-family-generic="roman" style:font-pitch="variable" fo:font-size="28pt"/>
</style:style>
<style:style style:name="T9" style:family="text">
<style:properties fo:color="#2323dc" fo:font-family="&apos;Times New Roman&apos;" style:font-family-generic="roman" style:font-pitch="variable" fo:font-size="26pt"/>
</style:style>
<style:style style:name="T10" style:family="text">
<style:properties fo:color="#ffff00" style:text-outline="false" fo:font-family="Arial" style:font-family-generic="swiss" style:font-pitch="variable" fo:text-shadow="1pt 1pt"/>
</style:style>
<style:style style:name="T11" style:family="text">
<style:properties fo:color="#2323dc" fo:font-family="&apos;Times New Roman&apos;" style:font-family-generic="roman" style:font-pitch="variable"/>
</style:style>
<text:list-style style:name="L1">
<text:list-level-style-bullet text:level="1" text:bullet-char="">
<style:properties fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="2" text:bullet-char="">
<style:properties text:space-before="1cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="3" text:bullet-char="">
<style:properties text:space-before="2cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="4" text:bullet-char="">
<style:properties text:space-before="3cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="5" text:bullet-char="">
<style:properties text:space-before="4cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="6" text:bullet-char="">
<style:properties text:space-before="5cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="7" text:bullet-char="">
<style:properties text:space-before="6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="8" text:bullet-char="">
<style:properties text:space-before="7cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="9" text:bullet-char="">
<style:properties text:space-before="8cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="10" text:bullet-char="">
<style:properties text:space-before="9cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
</text:list-style>
<text:list-style style:name="L2">
<text:list-level-style-bullet text:level="1" text:bullet-char="●">
<style:properties text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="2" text:bullet-char="●">
<style:properties text:space-before="0.6cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="3" text:bullet-char="●">
<style:properties text:space-before="1.2cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="4" text:bullet-char="●">
<style:properties text:space-before="1.8cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="5" text:bullet-char="●">
<style:properties text:space-before="2.4cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="6" text:bullet-char="●">
<style:properties text:space-before="3cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="7" text:bullet-char="●">
<style:properties text:space-before="3.6cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="8" text:bullet-char="●">
<style:properties text:space-before="4.2cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="9" text:bullet-char="●">
<style:properties text:space-before="4.8cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
</text:list-style>
<text:list-style style:name="L3">
<text:list-level-style-bullet text:level="1" text:bullet-char="●">
<style:properties text:space-before="0.3cm" text:min-label-width="0.9cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="2" text:bullet-char="–">
<style:properties text:space-before="1.6cm" text:min-label-width="0.8cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="75%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="3" text:bullet-char="●">
<style:properties text:space-before="3cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="4" text:bullet-char="–">
<style:properties text:space-before="4.2cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="75%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="5" text:bullet-char="●">
<style:properties text:space-before="5.4cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="6" text:bullet-char="●">
<style:properties text:space-before="6.6cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="7" text:bullet-char="●">
<style:properties text:space-before="7.8cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="8" text:bullet-char="●">
<style:properties text:space-before="9cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="9" text:bullet-char="●">
<style:properties text:space-before="10.2cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
</text:list-style>
<text:list-style style:name="L4">
<text:list-level-style-bullet text:level="1" text:bullet-char="●">
<style:properties text:space-before="0.508cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="2" text:bullet-char="–">
<style:properties text:space-before="1.6cm" text:min-label-width="0.8cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="75%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="3" text:bullet-char="●">
<style:properties text:space-before="3cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="4" text:bullet-char="–">
<style:properties text:space-before="4.2cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="75%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="5" text:bullet-char="●">
<style:properties text:space-before="5.4cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="6" text:bullet-char="●">
<style:properties text:space-before="6.6cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="7" text:bullet-char="●">
<style:properties text:space-before="7.8cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="8" text:bullet-char="●">
<style:properties text:space-before="9cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
<text:list-level-style-bullet text:level="9" text:bullet-char="●">
<style:properties text:space-before="10.2cm" text:min-label-width="0.6cm" fo:font-family="StarSymbol" style:font-charset="x-symbol" fo:color="#000000" fo:font-size="45%"/>
</text:list-level-style-bullet>
</text:list-style>
</office:automatic-styles>

<office:body>

<draw:page draw:name="page1"
draw:style-name="dp1"
draw:id="1" draw:master-page-name="BSDi Template"
presentation:presentation-page-layout-name="AL1T0"
xlink:href="./openoffice.xsl" xlink:type="simple"
xlink:show="replace" xlink:actuate="onRequest">

  <xsl:apply-templates select="slidesinfo"/>

</draw:page>


<xsl:apply-templates select="foilgroup|foil"/>

</office:body>
</office:document-content>

</xsl:template>

<xsl:template match="slidesinfo">

<office:forms form:automatic-focus="false" form:apply-design-mode="true">
<form:form form:name="Standard" form:command-type="table" form:service-name="com.sun.star.form.component.Form" office:target-frame="" xlink:href="">
<form:properties>
<form:property form:property-name="MaxRows" form:property-type="int">
<form:property-value>0</form:property-value>
</form:property>
<form:property form:property-name="URL" form:property-type="string">
<form:property-value/>
</form:property>
<form:property form:property-name="UpdateCatalogName" form:property-type="string">
<form:property-value/>
</form:property>
<form:property form:property-name="UpdateSchemaName" form:property-type="string">
<form:property-value/>
</form:property>
<form:property form:property-name="UpdateTableName" form:property-type="string">
<form:property-value/>
</form:property>
</form:properties>
<form:control form:name="CommandButton1" form:service-name="com.sun.star.form.component.CommandButton" form:id="control1">
<form:button form:label="BSDi - WellsFargo.sdd" form:button-type="url" office:target-frame="" xlink:href="./BSDi%20-%20WellsFargo.sdd" form:image-data="">
<form:properties>
<form:property form:property-name="DefaultControl" form:property-type="string">
<form:property-value>stardiv.one.form.control.CommandButton</form:property-value>
</form:property>
<form:property form:property-name="DispatchURLInternal" form:property-type="boolean">
<form:property-value>true</form:property-value>
</form:property>
</form:properties>
</form:button>
</form:control>
</form:form>
</office:forms>

  <!-- apply template to display conference name and date in upper
       left corner. -->

<draw:text-box presentation:style-name="pr1" draw:text-style-name="P2" draw:layer="layout" svg:width="16.349cm" svg:height="2.794cm" svg:x="9.69cm" svg:y="0.265cm" presentation:class="title" presentation:user-transformed="true">
<text:p text:style-name="P1">
<text:span text:style-name="T1"><xsl:apply-templates select="conference"/></text:span>
<text:span text:style-name="T1">
<text:line-break/>
</text:span>
<text:span text:style-name="T2"><xsl:apply-templates select="pubdate"/></text:span>
</text:p>
</draw:text-box>

<draw:text-box presentation:style-name="pr2" draw:text-style-name="P3" draw:layer="layout" svg:width="23.912cm" svg:height="13.231cm" svg:x="2.058cm" svg:y="5.838cm" presentation:class="subtitle">
<text:unordered-list text:style-name="L2">
<text:list-item>
<text:unordered-list>
<text:list-item>
<text:p text:style-name="P3">
<text:span text:style-name="T3">
  <xsl:apply-templates select="title"/>
</text:span>
</text:p>
</text:list-item>
</text:unordered-list>
</text:list-item>
</text:unordered-list>
<text:unordered-list text:style-name="L2">
<text:list-item>
<text:unordered-list>
<text:list-item>
<text:p text:style-name="P3"/>
</text:list-item>
</text:unordered-list>
</text:list-item>
</text:unordered-list>
<text:unordered-list text:style-name="L2">
<text:list-item>
<text:unordered-list>
<text:list-item>
<text:p text:style-name="P3">
<text:span text:style-name="T4">
  <xsl:apply-templates select="author"/>

</text:span>
</text:p>
</text:list-item>
</text:unordered-list>
</text:list-item>
</text:unordered-list>
<text:unordered-list text:style-name="L2">
<text:list-item>
<text:unordered-list>
<text:list-item>
<text:p text:style-name="P3">
<text:span text:style-name="T4">&lt;</text:span>
<text:span text:style-name="T5">

<xsl:variable name="slidesinfo-email" select="author/email"/>

<text:a xlink:href="mailto:{$slidesinfo-email}"><xsl:value-of select="$slidesinfo-email"/></text:a>
</text:span>
<text:span text:style-name="T4">&gt;</text:span>
</text:p>
</text:list-item>
</text:unordered-list>
</text:list-item>
</text:unordered-list>
</draw:text-box>

<draw:control draw:style-name="standard" draw:text-style-name="P4" draw:layer="layout" svg:width="4cm" svg:height="1cm" svg:x="-5.934cm" svg:y="20.979cm" form:id="control1"/>
<presentation:notes>
<draw:page-thumbnail draw:style-name="gr1" draw:layer="layout" svg:width="12.717cm" svg:height="9.538cm" svg:x="4.436cm" svg:y="2.791cm" draw:page-number="1" presentation:class="page"/>
<draw:text-box presentation:style-name="pr3" draw:layer="layout" svg:width="15.021cm" svg:height="10.589cm" svg:x="3.292cm" svg:y="13.255cm" presentation:class="notes" presentation:placeholder="true"/>
</presentation:notes>

</xsl:template>

<xsl:template match="author">
<xsl:apply-templates select="firstname"/>
<xsl:text> </xsl:text>
<xsl:apply-templates select="surname"/>
</xsl:template>

<xsl:template match="foil">
<xsl:variable name="pagenum"><xsl:number value="position()" format="1"/></xsl:variable>
<draw:page draw:style-name="dp1" draw:master-page-name="BSDi - Template" presentation:presentation-page-layout-name="AL2T19" xlink:href="./BSDi%20-%20WellsFargo.sdd#" xlink:type="simple" xlink:show="replace" xlink:actuate="onRequest">
  <xsl:attribute name="draw:name">page<xsl:value-of select="$pagenum"/></xsl:attribute>
  <xsl:attribute name="draw:id"><xsl:value-of select="$pagenum"/></xsl:attribute>

<draw:text-box presentation:style-name="pr4" draw:text-style-name="P8" draw:layer="layout" svg:width="23.912cm" svg:height="13.231cm" svg:x="2.059cm" svg:y="5.805cm" presentation:class="outline" presentation:user-transformed="true">

<xsl:apply-templates select="itemizedlist"/>
<xsl:apply-templates select="para"/>
<xsl:apply-templates select="screen"/>

</draw:text-box>

<draw:text-box presentation:style-name="pr5" draw:text-style-name="P9" draw:layer="layout" svg:width="16.762cm" svg:height="3cm" svg:x="9.209cm" svg:y="0.266cm" presentation:class="title" presentation:user-transformed="true">
<text:p text:style-name="P1">
<text:span text:style-name="T7"><xsl:apply-templates select="title"/></text:span>

</text:p>
</draw:text-box>

<presentation:notes>
<draw:page-thumbnail draw:style-name="gr1" draw:layer="layout" svg:width="12.717cm" svg:height="9.538cm" svg:x="4.436cm" svg:y="2.791cm" draw:page-number="2" presentation:class="page"/>
<draw:text-box presentation:style-name="pr3" draw:layer="layout" svg:width="15.021cm" svg:height="10.589cm" svg:x="3.292cm" svg:y="13.255cm" presentation:class="notes" presentation:placeholder="true"/>
</presentation:notes>
</draw:page>

</xsl:template>

<xsl:template match="itemizedlist">
<text:unordered-list text:style-name="L3">
  <xsl:apply-templates select="listitem"/>
</text:unordered-list>
</xsl:template>

<xsl:template match="listitem">
<xsl:variable name="mystyle"><xsl:choose><xsl:when test="ancestor::listitem">P7</xsl:when>
<xsl:otherwise>P5</xsl:otherwise>
</xsl:choose></xsl:variable>

<text:list-item>
<text:p>
  <xsl:attribute name="text:style-name"><xsl:value-of select="$mystyle"/></xsl:attribute>
<text:span text:style-name="T6">
<xsl:apply-templates select="node()[not(descendant::itemizedlist)]"/>
</text:span>
</text:p>
<xsl:apply-templates select="itemizedlist"/>
</text:list-item>
</xsl:template>

<xsl:template match="ulink">
<text:span text:style-name="T11">
<xsl:choose>
 <xsl:when test="count(child::node())=0">
   <xsl:value-of select="@url"/>
 </xsl:when>
 <xsl:otherwise>
   <xsl:apply-templates/>
 </xsl:otherwise>
</xsl:choose>
</text:span>
</xsl:template>


<xsl:template match="para">
<xsl:choose>
<xsl:when test="parent::foil">
<!-- special treatment if this is toplevel, inside foil. -->
<text:p text:style-name="P5"><xsl:apply-templates/></text:p>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates/>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>
