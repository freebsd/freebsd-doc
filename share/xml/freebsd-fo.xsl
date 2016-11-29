<?xml version='1.0'?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:db="http://docbook.org/ns/docbook"
		exclude-result-prefixes="db"
		version="1.0">

  <!-- Pull in the base stylesheets -->
  <xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/fo/docbook.xsl"/>

  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/freebsd-common.xsl"/>

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/freebsd-common.xsl"/>
  <!-- Include customized FO titlepage -->
  <xsl:import href="freebsd-fo-titlepage.xsl"/>

  <!-- The localization layer is the same preference level of this file -->
  <xsl:include href="http://www.FreeBSD.org/XML/lang/share/xml/freebsd-fo.xsl"/>

  <xsl:param name="print">0</xsl:param>

  <xsl:variable name="link.color">
    <xsl:choose>
      <xsl:when test="$print = 1">black</xsl:when>
      <xsl:otherwise>blue</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!--
	FO-SPECIFIC PARAMETER SETTINGS
  -->

  <!-- We use FOP -->
  <xsl:param name="fop1.extensions" select="1"/>

  <!-- Paper settings -->
  <xsl:param name="paper.type">A4</xsl:param>
  <xsl:param name="double.sided" select="1"/>
  <xsl:param name="force.blank.pages" select="1"/>

  <!-- Page margins and spacing -->
  <xsl:param name="page.margin.bottom">2cm</xsl:param>
  <xsl:param name="page.margin.inner">3cm</xsl:param>
  <xsl:param name="page.margin.outer">2.5cm</xsl:param>
  <xsl:param name="page.margin.top">2.13cm</xsl:param>
  <xsl:param name="body.margin.bottom">1cm</xsl:param>
  <xsl:param name="body.margin.top">1.0cm</xsl:param>
  <xsl:param name="body.margin.inner">0</xsl:param>
  <xsl:param name="body.margin.outer">0</xsl:param>
  <xsl:param name="body.start.indent">0</xsl:param>
  <xsl:param name="body.end.indent">0</xsl:param>
  <xsl:param name="region.after.extent">2cm</xsl:param>
  <xsl:param name="region.before.extent">2.2cm</xsl:param>

  <!-- Headers and footers -->
  <xsl:param name="headers.on.blank.pages" select="0"/>
  <xsl:param name="footers.on.blank.pages" select="0"/>
  <xsl:param name="footer.rule" select="0"/>
  <xsl:param name="header.column.widths">500 1 500</xsl:param>
  <xsl:param name="footer.column.widths">500 1 500</xsl:param>

  <!-- Sections and numbering -->
  <xsl:param name="section.autolabel" select="1"/>
  <xsl:param name="section.autolabel.max.depth" select="5"/>
  <xsl:param name="section.label.includes.component.label" select="1"/>
  <xsl:param name="bibliography.numbered" select="1"/>
  <xsl:param name="formal.title.placement">
    figure after
    example before
    equation after
    table before
    procedure before</xsl:param>

  <!-- Admonitions -->
  <xsl:param name="admon.graphics" select="1"/>
  <xsl:param name="admon.graphics.path">/usr/local/share/xsl/docbook-ns/images/</xsl:param>
  <xsl:param name="admon.graphics.extension">.svg</xsl:param>

  <!-- Tables -->
  <xsl:param name="default.table.frame">hsides</xsl:param>
  <xsl:param name="default.table.rules">rows</xsl:param>

  <!-- Lists -->
  <xsl:param name="variablelist.as.blocks" select="1"/>

  <!-- Q & A -->
  <xsl:param name="qanda.defaultlabel">qanda</xsl:param>

  <!-- Graphics -->
  <xsl:param name="callout.graphics.path">imagelib/callouts/</xsl:param>
  <xsl:param name="callout.graphics.extension">.png</xsl:param>
  <xsl:param name="default.image.width">300px</xsl:param>
  <xsl:template name="image.scalefit">1</xsl:template>

  <!-- Hyphenation -->
  <xsl:param name="hyphenate">true</xsl:param>
  <xsl:param name="hyphenate.verbatim" select="1"/>
  <xsl:param name="hyphenate.verbatim.characters"> </xsl:param>

  <!-- Base Fonts -->
  <xsl:param name="body.font.master">9.5</xsl:param>
  <xsl:param name="body.font.family">Gentium Plus</xsl:param>
  <xsl:param name="sans.font.family">Droid Sans</xsl:param>
  <xsl:param name="title.font.family">Droid Sans</xsl:param>
  <xsl:param name="monospace.font.family">DejaVu Sans Mono</xsl:param>

  <!-- Linking -->
  <xsl:param name="ulink.show" select="$print"/>
  <xsl:param name="ulink.footnotes" select="$print"/>
  <xsl:param name="email.mailto.enabled">
    <xsl:choose>
      <xsl:when test="$print = 1">0</xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <!-- Property sets -->
  <xsl:attribute-set name="chapter.title.properties">
  <xsl:attribute name="font-size">24pt</xsl:attribute>
  <xsl:attribute name="space-before">6pt</xsl:attribute>
  <xsl:attribute name="space-after">36pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level1.properties">
  <xsl:attribute name="font-size">14pt</xsl:attribute>
  <xsl:attribute name="space-before">24pt</xsl:attribute>
  <xsl:attribute name="space-after">12pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level2.properties">
  <xsl:attribute name="font-size">11pt</xsl:attribute>
  <xsl:attribute name="space-before">12pt</xsl:attribute>
  <xsl:attribute name="space-after">6pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level3.properties">
  <xsl:attribute name="font-size">10pt</xsl:attribute>
  <xsl:attribute name="space-before">6pt</xsl:attribute>
  <xsl:attribute name="space-after">3pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.properties">
  <xsl:attribute name="font-family">
  <xsl:value-of select="$title.fontset"></xsl:value-of>
  </xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
  <xsl:attribute name="text-align">start</xsl:attribute>
  <xsl:attribute name="start-indent"><xsl:value-of select="$title.margin.left"></xsl:value-of></xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.properties">
  <xsl:attribute name="font-size">9.5pt</xsl:attribute>
  <xsl:attribute name="line-height">12pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="normal.para.spacing">
  <xsl:attribute name="space-before">12pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="abstract.title.properties">
  <xsl:attribute name="font-size">
  <xsl:value-of select="$body.font.master * 2.0736"></xsl:value-of>
  <xsl:text>pt</xsl:text>
  </xsl:attribute>
  <xsl:attribute name="text-align">left</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="abstract.properties">
  <xsl:attribute name="margin-left">0</xsl:attribute>
  <xsl:attribute name="margin-right">0</xsl:attribute>
  <xsl:attribute name="padding-left">0</xsl:attribute>
  <xsl:attribute name="padding-right">0</xsl:attribute>
  </xsl:attribute-set>

<xsl:attribute-set name="toc.margin.properties">
  <xsl:attribute name="margin-left">
    <xsl:value-of select="'0'"/>
  </xsl:attribute>
  <xsl:attribute name="margin-right">
    <xsl:value-of select="'0'"/>
  </xsl:attribute>
  <xsl:attribute name="padding-left">
    <xsl:value-of select="'0'"/>
  </xsl:attribute>
  <xsl:attribute name="padding-right">
    <xsl:value-of select="'0'"/>
  </xsl:attribute>
</xsl:attribute-set>

  <xsl:attribute-set name="monospace.properties">
  <xsl:attribute name="font-family">
  <xsl:value-of select="$monospace.font.family"></xsl:value-of>
  </xsl:attribute>
  <xsl:attribute name="font-size">8pt</xsl:attribute>
  <xsl:attribute name="letter-spacing">-0.3pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="monospace.verbatim.properties">
  <xsl:attribute name="font-size">8pt</xsl:attribute>
  <xsl:attribute name="line-height">10pt</xsl:attribute>
  <xsl:attribute name="space-before">12pt</xsl:attribute>
  <xsl:attribute name="space-after">0</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="white-space-collapse">false</xsl:attribute>
  <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
  <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
  <xsl:attribute name="text-align">start</xsl:attribute>
  <xsl:attribute name="background-color">rgb(192,192,192)</xsl:attribute>
  <xsl:attribute name="wrap-option">wrap</xsl:attribute>
  <xsl:attribute name="hyphenation-character">&#x21BA;</xsl:attribute>
  <xsl:attribute name="padding-right">3pt</xsl:attribute>
  <xsl:attribute name="padding-top">1pt</xsl:attribute>
  <xsl:attribute name="padding-left">3pt</xsl:attribute>
  <xsl:attribute name="padding-bottom">1pt</xsl:attribute>
  <xsl:attribute name="margin-right">0pt</xsl:attribute>
  <xsl:attribute name="margin-left">0pt</xsl:attribute>
  <xsl:attribute name="letter-spacing">0pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.caption.properties">
  <xsl:attribute name="font-size">8pt</xsl:attribute>
  <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
  <xsl:attribute name="line-height">13pt</xsl:attribute>
  <xsl:attribute name="space-before">12pt</xsl:attribute>
  <xsl:attribute name="space-after">3pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.table.properties">
  <xsl:attribute name="font-size">9.5pt</xsl:attribute>
  <xsl:attribute name="border-before-width.conditionality">retain</xsl:attribute>
  <xsl:attribute name="border-collapse">collapse</xsl:attribute>
  <xsl:attribute name="margin-top">0</xsl:attribute>
  <xsl:attribute name="margin-bottom">0</xsl:attribute>
  <xsl:attribute name="margin-left">0</xsl:attribute>
  <xsl:attribute name="margin-right">0</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="formal.title.properties" use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="font-size">8pt</xsl:attribute>
  <xsl:attribute name="font-weight">normal</xsl:attribute>
  <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
  <xsl:attribute name="line-height">13pt</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="graphical.admonition.properties">
  <xsl:attribute name="border-style">solid</xsl:attribute>
  <xsl:attribute name="border-width">1px</xsl:attribute>
  <xsl:attribute name="margin-right">0</xsl:attribute>
  <xsl:attribute name="margin-top">12pt</xsl:attribute>
  <xsl:attribute name="margin-left">0</xsl:attribute>
  <xsl:attribute name="margin-bottom">12pt</xsl:attribute>
  <xsl:attribute name="padding-right">0.5cm</xsl:attribute>
  <xsl:attribute name="padding-top">0.5cm</xsl:attribute>
  <xsl:attribute name="padding-left">0.5cm</xsl:attribute>
  <xsl:attribute name="padding-bottom">0.5cm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="list.item.spacing">
  <xsl:attribute name="space-before">6pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="list.block.spacing">
  <xsl:attribute name="space-before">6pt</xsl:attribute>
  <xsl:attribute name="space-after">6pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="list.block.properties">
  <xsl:attribute name="provisional-label-separation">0.2em</xsl:attribute>
  <xsl:attribute name="provisional-distance-between-starts">1.5em</xsl:attribute>
  <xsl:attribute name="line-height">12pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="example.properties" use-attribute-sets="formal.object.properties">
  <xsl:attribute name="keep-together.within-column">auto</xsl:attribute>
  <xsl:attribute name="border-style">solid</xsl:attribute>
  <xsl:attribute name="border-width">1px</xsl:attribute>
  <xsl:attribute name="margin-right">0</xsl:attribute>
  <xsl:attribute name="margin-top">12pt</xsl:attribute>
  <xsl:attribute name="margin-left">0</xsl:attribute>
  <xsl:attribute name="margin-bottom">12pt</xsl:attribute>
  <xsl:attribute name="padding-right">0.5cm</xsl:attribute>
  <xsl:attribute name="padding-top">0.3cm</xsl:attribute>
  <xsl:attribute name="padding-left">0.5cm</xsl:attribute>
  <xsl:attribute name="padding-bottom">0.5cm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="xref.properties">
    <xsl:attribute name="color">
      <xsl:value-of select="$link.color"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <!--
	FO-SPECIFIC TEMPLATE CUSTOMIZATIONS
  -->

  <!-- Gray background for headers of HTML tables -->
  <xsl:template match="db:thead" mode="htmlTable">
    <fo:table-header start-indent="0pt" end-indent="0pt"
      background-color="rgb(192,192,192)">
      <xsl:apply-templates mode="htmlTable"/>
    </fo:table-header>
  </xsl:template>

  <!-- Gray background for headers of CALS tables -->
  <xsl:template match="db:thead">
    <xsl:variable name="tgroup" select="parent::*"/>

    <fo:table-header start-indent="0pt" end-indent="0pt" background-color="rgb(192,192,192)">
      <xsl:choose>
	<!-- Use recursion if @morerows is used -->
	<xsl:when test="db:row/db:entry/@morerows|db:row/db:entrytbl/@morerows">
	  <xsl:apply-templates select="db:row[1]">
	    <xsl:with-param name="spans">
	      <xsl:call-template name="blank.spans">
		<xsl:with-param name="cols" select="../@cols"/>
	      </xsl:call-template>
	    </xsl:with-param>
	    <xsl:with-param name="browserows" select="'recurse'"/>
	  </xsl:apply-templates>
	</xsl:when>

	<xsl:otherwise>
	  <xsl:apply-templates select="db:row">
	    <xsl:with-param name="spans">
	      <xsl:call-template name="blank.spans">
		<xsl:with-param name="cols" select="../@cols"/>
	      </xsl:call-template>
	    </xsl:with-param>
	    <xsl:with-param name="browserows" select="'loop'" />
	  </xsl:apply-templates>
	</xsl:otherwise>
      </xsl:choose>
    </fo:table-header>
  </xsl:template>

  <xsl:template match="db:guibutton">
    <fo:inline background-color="rgb(192,192,192)">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <!-- Adjust spacing according to where the title is placed -->
  <xsl:template name="formal.object.heading">
    <xsl:param name="object" select="."/>
    <xsl:param name="placement" select="'before'"/>

    <fo:block xsl:use-attribute-sets="formal.title.properties">
      <xsl:choose>
	<xsl:when test="$placement = 'before' and local-name($object) != 'example'">
	  <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	  <xsl:attribute name="space-before.minimum">12pt</xsl:attribute>
	  <xsl:attribute name="space-before.optimum">12pt</xsl:attribute>
	  <xsl:attribute name="space-before.maximum">12pt</xsl:attribute>
	  <xsl:attribute name="space-after.minimum">0</xsl:attribute>
	  <xsl:attribute name="space-after.optimum">0</xsl:attribute>
	  <xsl:attribute name="space-after.maximum">0</xsl:attribute>
	</xsl:when>

	<xsl:when test="$placement = 'after'">
	  <xsl:attribute name="keep-with-previous.within-column">always</xsl:attribute>
	  <xsl:attribute name="space-before.minimum">0</xsl:attribute>
	  <xsl:attribute name="space-before.optimum">0</xsl:attribute>
	  <xsl:attribute name="space-before.maximum">0</xsl:attribute>
	  <xsl:attribute name="space-after.minimum">12pt</xsl:attribute>
	  <xsl:attribute name="space-after.optimum">12pt</xsl:attribute>
	  <xsl:attribute name="space-after.maximum">12pt</xsl:attribute>
	</xsl:when>

	<xsl:otherwise>
	  <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	  <xsl:attribute name="font-weight">bold</xsl:attribute>
	  <xsl:attribute name="font-size">14pt</xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="$object" mode="object.title.markup">
	<xsl:with-param name="allow-anchors" select="1"/>
      </xsl:apply-templates>
    </fo:block>
  </xsl:template>

  <xsl:template match="db:citerefentry">
    <xsl:variable name="xhref">
      <xsl:text>http://www.FreeBSD.org/cgi/man.cgi?query=</xsl:text>
      <xsl:value-of select="db:refentrytitle"/>
      <xsl:text>&amp;sektion=</xsl:text>
      <xsl:value-of select="db:manvolnum"/>
      <xsl:text>&amp;manpath=freebsd-release-ports</xsl:text>
    </xsl:variable>

    <fo:basic-link external-destination="url({$xhref})">
      <fo:inline color="{$link.color}">
	<xsl:value-of select="concat(db:refentrytitle, '(', db:manvolnum, ')')"/>
      </fo:inline>
    </fo:basic-link>
  </xsl:template>

  <xsl:template match="db:package">
    <xsl:variable name="xhref" select="concat('http://www.freebsd.org/cgi/url.cgi?ports/', ., '/pkg-descr')"/>

    <fo:basic-link external-destination="url({$xhref})">
      <fo:inline color="{$link.color}">
	<xsl:apply-templates/>
      </fo:inline>
    </fo:basic-link>
  </xsl:template>

<!-- Customize header content -->
<xsl:template name="header.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

  <fo:block>
    <xsl:choose>
      <xsl:when test="$pageclass = 'lot' and $sequence='odd' and $position='left' ">
	<xsl:call-template name="gentext">
	  <xsl:with-param name="key" select="$gentext-key"/>
	</xsl:call-template>
      </xsl:when>

      <xsl:when test="$pageclass = 'lot' and $sequence='even' and $position='right' ">
	<xsl:call-template name="gentext">
	  <xsl:with-param name="key" select="$gentext-key"/>
	</xsl:call-template>
      </xsl:when>

      <xsl:when test="$pageclass = 'back' and $sequence='odd' and $position='left' ">
	<xsl:apply-templates select="."  mode="object.title.markup"/>
      </xsl:when>

      <xsl:when test="$pageclass = 'back' and $sequence='even' and $position='right' ">
	<xsl:apply-templates select="."  mode="object.title.markup"/>
      </xsl:when>

      <xsl:when test="$pageclass = 'index' and $sequence='odd' and $position='left' ">
	<xsl:call-template name="gentext">
	  <xsl:with-param name="key" select="$gentext-key"/>
	</xsl:call-template>
      </xsl:when>

      <xsl:when test="$pageclass = 'index' and $sequence='even' and $position='right' ">
	<xsl:call-template name="gentext">
	  <xsl:with-param name="key" select="$gentext-key"/>
	</xsl:call-template>
      </xsl:when>

      <xsl:when test="$sequence='odd' and $position='left'">
	<xsl:if test="$pageclass != 'titlepage'">
	  <xsl:apply-templates select="."  mode="object.title.markup"/>
	</xsl:if>
      </xsl:when>

      <xsl:when test="$sequence='even' and $position='right'">
	<xsl:if test="$pageclass != 'titlepage'">
	  <fo:retrieve-marker
	    retrieve-class-name="section.head.marker"
	    retrieve-position="first-including-carryover"
	    retrieve-boundary="page-sequence"/>
	</xsl:if>
      </xsl:when>
    </xsl:choose>
  </fo:block>
</xsl:template>

<!-- Customize footer content -->
<xsl:template name="footer.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

  <fo:block>
    <xsl:choose>
      <xsl:when test="$sequence = 'odd' and $position='right'">
	<fo:page-number/>
      </xsl:when>

      <xsl:when test="$sequence = 'even' and $position='left'">
	<fo:page-number/>
      </xsl:when>
    </xsl:choose>
  </fo:block>
</xsl:template>

<!-- Customize header separator -->
<xsl:template name="head.sep.rule">
  <xsl:param name="pageclass"/>
  <xsl:param name="sequence"/>
  <xsl:param name="gentext-key"/>

  <xsl:if test="$header.rule != 0 and $sequence != 'first' and
    $pageclass != 'front' and $pageclass != 'titlepage'">
    <xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
    <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
    <xsl:attribute name="border-bottom-color">black</xsl:attribute>
  </xsl:if>
</xsl:template>

  <!-- FOP hyphenation bug workaround -->
  <xsl:template match="db:anchor">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
    <fo:inline id="{$id}">&#x200b;</fo:inline>
  </xsl:template>

  <!-- Suppress list titles -->
  <xsl:template match="db:title" mode="list.title.mode"/>

  <!-- Soft-hyphen workaround for verbatim hyphenation -->
  <xsl:template name="hyphenate.verbatim">
    <xsl:param name="content"/>
    <xsl:variable name="apos" select='"&apos;"'/>
    <xsl:variable name="head" select="substring($content, 1, 1)"/>
    <xsl:variable name="tail" select="substring($content, 2)"/>
    <xsl:variable name="next" select="substring($tail, 1, 1)"/>
    <xsl:choose>
      <!-- Place soft-hyphen after space or non-breakable space. -->
      <xsl:when test="$next = '&#xA;' or $next = '' or $next = '&quot;' or
	$next = '.' or $next = ',' or $next = '-' or $next = '/' or
	$next = $apos or $next = ':' or $next = '!' or $next = '|' or
	$next = '?' or $next = ')'">
	<xsl:value-of select="$head"/>
      </xsl:when>
      <xsl:when test="($head = ' ' or $head = '&#160;') and $next != '.' and
	$next != '}' and $next != ' ' and $next != '&#160;'">
	<xsl:text>&#160;</xsl:text>
	<xsl:text>&#x00AD;</xsl:text>
      </xsl:when>
      <xsl:when test="$head = '.' and translate($next, '0123456789', '') != ''">
	<xsl:text>.</xsl:text>
	<xsl:text>&#x00AD;</xsl:text>
      </xsl:when>
      <xsl:when test="$hyphenate.verbatim.characters != '' and
	translate($head, $hyphenate.verbatim.characters, '') = '' and
	translate($next, $hyphenate.verbatim.characters, '') != ''">
	<xsl:value-of select="$head"/>
	<xsl:text>&#x00AD;</xsl:text>
      </xsl:when>
      <xsl:when test="$next = '('">
	<xsl:value-of select="$head"/>
	<xsl:text>&#x00AD;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$head"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="$tail">
      <xsl:call-template name="hyphenate.verbatim">
	<xsl:with-param name="content" select="$tail"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

<!--
	TITLEPAGE TEMPLATES
-->

  <xsl:template name="svnref.genlink">
    <xsl:param name="rev" select="."/>
    <xsl:param name="repo" select="'base'"/>
    <xsl:variable name="href">
      <xsl:call-template name="svnweb.link">
	<xsl:with-param name="repo" select="$repo"/>
	<xsl:with-param name="rev" select="$rev"/>
      </xsl:call-template>
    </xsl:variable>

    <fo:basic-link external-destination="url({$href})">
      <fo:inline color="blue">
	<xsl:value-of select="$rev"/>
      </fo:inline>
    </fo:basic-link>
  </xsl:template>

  <xsl:template name="chapter.authorgroup">
    <fo:inline font-style="italic">
      <xsl:call-template name="freebsd.authorgroup"/>
    </fo:inline>
  </xsl:template>

  <xsl:template name="chapter.author">
    <fo:inline font-style="italic">
      <xsl:call-template name="freebsd.author"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="db:title" mode="title.markup">
    <xsl:apply-templates mode="titlepage.mode"/>
  </xsl:template>

  <xsl:template match="db:replaceable" mode="titlepage.mode">
    <fo:inline font-style="italic">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="db:citerefentry" mode="titlepage.mode">
    <xsl:variable name="xhref">
      <xsl:text>http://www.FreeBSD.org/cgi/man.cgi?query=</xsl:text>
      <xsl:value-of select="db:refentrytitle"/>
      <xsl:text>&#38;amp;sektion=</xsl:text>
      <xsl:value-of select="db:manvolnum"/>
    </xsl:variable>

    <fo:basic-link external-destination="url({$xhref})">
      <xsl:value-of select="concat(db:refentrytitle, '(', db:manvolnum, ')')"/>
    </fo:basic-link>
  </xsl:template>

  <xsl:template match="db:filename" mode="titlepage.mode">
    <fo:inline font-family="{$monospace.font.family}">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>
</xsl:stylesheet>
