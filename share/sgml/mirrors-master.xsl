<?xml version="1.0" encoding="iso-8859-1"?>
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output type="xml" encoding="iso-8859-1"
	      omit-xml-declaration="yes"
	      indent="yes"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="proto" select="''" />
  <xsl:param name="target" select="''" />

  <xsl:param name="mirrors-docbook-country-anchor-id" select="translate($target, '/.', '--')" />

  <!--
     templates available:

        * "mirrors-docbook-contact"
        * "mirrors-docbook-country-index-all"
        * "mirrors-docbook-variablelist"
        * "mirrors-docbook-itemizedlist"
  -->

  <xsl:template match="/mirrors">
    <xsl:choose>
      <xsl:when test="$target = 'handbook/mirrors/chapter.sgml'">
	<xsl:call-template name="mirrors-docbook-country-index-all" />
	<xsl:call-template name="mirrors-docbook-variablelist" />
      </xsl:when>
      <xsl:when test="$target = 'handbook/eresources/chapter.sgml'">
	<xsl:call-template name="mirrors-docbook-country-index-all" />
	<xsl:call-template name="mirrors-docbook-itemizedlist" />
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="'*** processing error ***'" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- template: "mirrors-docbook-contact" -->

  <xsl:template name="mirrors-docbook-contact">
    <xsl:param name="email" select="'someone@somewhere'"/>

    <para>In case of problems, please contact the hostmaster
      <email><xsl:value-of select="$email" /></email> for this domain.</para>
  </xsl:template>

  <!-- template: "mirrors-docbook-country-index-all" -->

  <xsl:template name="mirrors-docbook-country-index-all">
    <para>
      <xsl:for-each select="entry[country/@role = 'primary' and
	                    (url[contains(@proto, $proto)] or host[contains(@proto, $proto)])]">
	<xsl:call-template name="mirrors-docbook-country-index" />
      </xsl:for-each>

      <xsl:for-each select="entry[country/@role != 'primary' and
	                    (url[contains(@proto, $proto)] or host[contains(@proto, $proto)])]">
	<xsl:sort select="country" />

	<xsl:call-template name="mirrors-docbook-country-index" />
      </xsl:for-each>
    </para>
  </xsl:template>

  <xsl:template name="mirrors-docbook-country-index">
    <link>
      <xsl:attribute name="linkend">
	<xsl:value-of select="concat($mirrors-docbook-country-anchor-id, '-', @id, '-', $proto)" />
      </xsl:attribute>
      <xsl:value-of select="country" />
    </link>
    <xsl:choose>
      <xsl:when test='position() = last()'><xsl:text>.</xsl:text></xsl:when>
      <xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- template: "mirrors-docbook-variablelist" -->

  <xsl:template name="mirrors-docbook-variablelist">
    <variablelist>
      <xsl:for-each select="entry[country/@role = 'primary' and
	                    (url[contains(@proto, $proto)] or host[contains(@proto, $proto)])]">
	<xsl:call-template name="mirrors-docbook-variablelist-entry" />
      </xsl:for-each>

      <xsl:for-each select="entry[country/@role != 'primary' and
	                    (url[contains(@proto, $proto)] or host[contains(@proto, $proto)])]">
	<xsl:sort select="country" />

	<xsl:call-template name="mirrors-docbook-variablelist-entry" />
      </xsl:for-each>
    </variablelist>
  </xsl:template>

  <xsl:template name="mirrors-docbook-variablelist-entry">
    <varlistentry>
      <term>
	<anchor>
	  <xsl:attribute name="id">
	    <xsl:value-of select="concat($mirrors-docbook-country-anchor-id, '-', @id, '-', $proto)" />
	  </xsl:attribute>
	</anchor>
	<xsl:value-of select="country" />
      </term>

      <listitem>
	<xsl:if test="$proto = 'ftp' and email">
	  <xsl:call-template name="mirrors-docbook-contact">
	    <xsl:with-param name="email" select="email" />
	  </xsl:call-template>
	</xsl:if>

	<itemizedlist>
	  <xsl:for-each select="child::*[contains(@proto, $proto)]">
	    <listitem>
	      <para>
		<xsl:choose>
		  <xsl:when test="self::url">
		    <ulink>
		      <xsl:attribute name="url"><xsl:value-of select="." /></xsl:attribute>
		    </ulink>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:value-of select="." />
		  </xsl:otherwise>
		</xsl:choose>
	      </para>
	    </listitem>
	  </xsl:for-each>
	</itemizedlist>
      </listitem>
    </varlistentry>
  </xsl:template>

  <!-- template: "mirrors-docbook-itemizedlist" -->

  <xsl:template name="mirrors-docbook-itemizedlist">
    <itemizedlist>
      <xsl:for-each select="entry[country/@role = 'primary' and
	                    (url[contains(@proto, $proto)] or host[contains(@proto, $proto)])]">
	<xsl:call-template name="mirrors-docbook-itemizedlist-listitem" />
      </xsl:for-each>

      <xsl:for-each select="entry[country/@role != 'primary' and
	                    (url[contains(@proto, $proto)] or host[contains(@proto, $proto)])]">
        <xsl:sort select="country" />

	<xsl:call-template name="mirrors-docbook-itemizedlist-listitem" />
      </xsl:for-each>
    </itemizedlist>
  </xsl:template>

  <xsl:template name="mirrors-docbook-itemizedlist-listitem">
    <listitem>
      <anchor>
	<xsl:attribute name="id">
	  <xsl:value-of select="concat($mirrors-docbook-country-anchor-id, '-', @id, '-', $proto)" />
	</xsl:attribute>
      </anchor>

      <para><xsl:value-of select="country" /></para>

      <itemizedlist>
	<xsl:for-each select="child::*[contains(@proto, $proto) and contains(@type, 'www')]">
	  <xsl:if test="self::url">
	    <listitem>
	      <para>
		<ulink>
		  <xsl:attribute name="url"><xsl:value-of select="." /></xsl:attribute>
		  <xsl:value-of select="." />
		</ulink>
	      </para>
	    </listitem>
	  </xsl:if>
	</xsl:for-each>
      </itemizedlist>
    </listitem>
  </xsl:template>
</xsl:stylesheet>
