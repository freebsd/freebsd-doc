<?xml version="1.0"?>
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output type="xml" encoding="iso-8859-1"
	      omit-xml-declaration="yes"
	      indent="yes"/>
  <!--
    Notes for translators:

    "transtable" and "contact" are available for localized documents.
    Redefining these templates in the language dependent directory, you
    can generate the results in the specific language.	For example,
    please see ja_JP.eucJP/share/sgml/mirrors.xsl.
  -->

  <xsl:template name="transtable">
    <xsl:param name="name" />

    <!-- null for English version -->
    <xsl:value-of select="$name" />
  </xsl:template>

  <xsl:template name="contact">
    <xsl:param name="email" value="'someone@somewhere'"/>

    <para>In case of problems, please contact the hostmaster
      <email><xsl:value-of select="$email" /></email> for this domain.</para>
  </xsl:template>

  <xsl:template match="/mirrors">
    <para>
      <xsl:for-each select="entry[url[contains(@proto, $proto)] or host[contains(@proto, $proto)]]">
	<link>
	  <xsl:attribute name="linkend">
	    <xsl:value-of select="concat(@id, '-', $proto)" />
	  </xsl:attribute>
	  <xsl:call-template name="transtable">
	    <xsl:with-param name="name" select="country" />
	  </xsl:call-template>
	</link>
	<xsl:choose>
	  <xsl:when test='position() = last()'><xsl:text>.</xsl:text></xsl:when>
	  <xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise>
	</xsl:choose>
      </xsl:for-each>
    </para>

    <variablelist>
      <xsl:for-each select="entry[url[contains(@proto, $proto)] or host[contains(@proto, $proto)]]">
	<varlistentry>
	  <term>
	    <anchor>
	      <xsl:attribute name="id">
		<xsl:value-of select="concat(@id, '-', $proto)" />
	      </xsl:attribute>
	    </anchor>
	    <xsl:call-template name="transtable">
	      <xsl:with-param name="name" select="country" />
	    </xsl:call-template>
	  </term>

	  <listitem>
	    <xsl:if test="$proto = 'ftp' and email">
	      <xsl:call-template name="contact">
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
      </xsl:for-each>
    </variablelist>
  </xsl:template>
</xsl:stylesheet>
