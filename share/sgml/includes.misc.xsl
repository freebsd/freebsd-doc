<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- Often used trademarks -->
  <xsl:variable name="unix" select="'UNIX&#174;'"/>
  <xsl:variable name="java" select="'Java&#8482;'"/>
  <xsl:variable name="jdk" select="'JDK&#8482;'"/>
  <xsl:variable name="posix" select="'POSIX&#174;'"/>

  <!-- template: "html-index-mirrors-options-list"
       generates mirror sites list in index.html -->

  <xsl:template name="html-index-mirrors-options-list">
    <xsl:param name="mirrors.xml" select="''" />

    <xsl:for-each select="document($mirrors.xml)/mirrors/entry[country/@role != 'primary' and
                          url[contains(@proto, 'httpv6') and contains(@type, 'www')]]">
      <xsl:sort select="country" />

      <xsl:for-each select="url[contains(@proto, 'httpv6') and contains(@type, 'www')]">
	<option><xsl:attribute name="value"><xsl:value-of select="." /></xsl:attribute>
	  <xsl:choose>
	    <xsl:when test="last() = 1">
	      <xsl:value-of select="concat('IPv6 ', ../country)" />
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="concat('IPv6 ', ../country, '/', position())" />
	    </xsl:otherwise>
	  </xsl:choose>
	</option>
      </xsl:for-each>
    </xsl:for-each>

    <xsl:for-each select="document($mirrors.xml)/mirrors/entry[country/@role != 'primary' and
                          url[contains(@proto, 'http') and contains(@type, 'www')]]">
      <xsl:sort select="country" />

      <xsl:for-each select="url[contains(@proto, 'http') and contains(@type, 'www')]">
	<option><xsl:attribute name="value"><xsl:value-of select="." /></xsl:attribute>
	  <xsl:choose>
	    <xsl:when test="last() = 1">
	      <xsl:value-of select="../country" />
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="concat(../country, '/', position())" />
	    </xsl:otherwise>
	  </xsl:choose>
	</option>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
