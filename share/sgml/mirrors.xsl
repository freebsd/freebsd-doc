<?xml version="1.0"?>
<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output type="xml" encoding="iso-8859-1"
	      omit-xml-declaration="yes"
	      indent="yes"/>

  <xsl:template match="/mirrors">
    <para>
      <xsl:for-each select="entry[url[contains(@proto, $proto)] or host[contains(@proto, $proto)]]">
       <link><xsl:attribute name="linkend"><xsl:value-of select="concat(@id, '-', $proto)" /></xsl:attribute>
	  <xsl:value-of select="country" /></link>
       <xsl:choose>
	 <xsl:when test='position() = last()'><xsl:text>.</xsl:text></xsl:when>
	 <xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise>
       </xsl:choose>
    </xsl:for-each>
    </para>

    <variablelist>
      <xsl:for-each select="entry[url[contains(@proto, $proto)] or host[contains(@proto, $proto)]]">
	<varlistentry>
	  <term><anchor><xsl:attribute name="id"><xsl:value-of select="concat(@id, '-', $proto)" /></xsl:attribute>
	      </anchor><xsl:value-of select="country" /></term>

	  <listitem>
	    <xsl:if test="$proto = 'ftp' and email">
	      <para>In case of problems, please contact the hostmaster
		<email><xsl:value-of select="email" /></email> for this domain.</para>
	    </xsl:if>

	    <itemizedlist>
	       <xsl:for-each select="child::*[contains(@proto, $proto)]">
		 <listitem>
		   <para>
		     <xsl:choose>
		       <xsl:when test="self::url">
			 <ulink><xsl:attribute name="url"><xsl:value-of select="." /></xsl:attribute>
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
