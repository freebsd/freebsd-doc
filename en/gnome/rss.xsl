<!-- $FreeBSD: www/en/gnome/rss.xsl,v 1.2 2002/11/24 08:43:31 marcus Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdf1="http://my.netscape.com/rdf/simple/0.9/"
		version="1.0">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/en/gnome/rss.xsl,v 1.2 2002/11/24 08:43:31 marcus Exp $'"/>
  <xsl:variable name="title" select="'FreeBSD GNOME Project News System'"/>

  <xsl:output type="xml" />

  <xsl:template match="/">
    <rdf:RDF
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns="http://my.netscape.com/rdf/simple/0.9/">

      <channel>
        <title>FreeBSD GNOME Project News</title>
	<link>http://www.FreeBSD.org/gnome</link>
	<description>FreeBSD GNOME News System</description>
      </channel>

      <xsl:for-each select="descendant::event[position() &lt;= 10]">
      <item>
	<title>
        <xsl:choose>
	  <xsl:when test="count(child::title)">
            <xsl:value-of select="title"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="p"/>
	  </xsl:otherwise>
	</xsl:choose>
	</title>
	<link>http://www.FreeBSD.org/gnome/newsflash#<xsl:call-template name="generate-event-anchor"/></link>
      </item>
      </xsl:for-each>
   </rdf:RDF>
</xsl:template>
</xsl:stylesheet>
