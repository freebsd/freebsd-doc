<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- $FreeBSD: www/share/sgml/includes.misc.xsl,v 1.6 2004/01/24 12:10:02 hrs Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:param name="leadingmark" select="'&#183; '"/>

  <!-- Often used trademarks -->
  <xsl:variable name="unix" select="'UNIX&#174;'"/>
  <xsl:variable name="java" select="'Java&#8482;'"/>
  <xsl:variable name="jdk" select="'JDK&#8482;'"/>
  <xsl:variable name="posix" select="'POSIX&#174;'"/>

  <!-- for security advisories -->
  <xsl:variable name="ftpbase"
                select="'ftp://ftp.FreeBSD.org/pub/FreeBSD/CERT/advisories/'"/>
  <xsl:variable name="ftpbaseold"
                select="'ftp://ftp.FreeBSD.org/pub/FreeBSD/CERT/advisories/old/'"/>

  <!--
     template name                               used in

     html-list-advisories                        security/mkindex.xsl
     html-list-advisories-putitems               security/mkindex.xsl
     html-list-advisories-release-label          security/mkindex.xsl (for l10n)
     html-index-advisories-items                 index.xsl
     html-index-advisories-items-lastmodified    index.xsl (for i10n)
     html-index-news-project-items               index.xsl
     html-index-news-project-items-lastmodified  index.xsl (for i10n)
     html-index-news-press-items                 index.xsl
     html-index-news-press-items-lastmodified    index.xsl (for i10n)
     html-index-mirrors-options-list             index.xsl
  -->

  <!-- template: "html-list-advisories"
       generate a list of all security advisories -->

  <xsl:template name="html-list-advisories">
    <xsl:param name="advisories.xml" select="'none'" />

    <xsl:for-each select="document($advisories.xml)
                          /descendant::release">

      <xsl:param name="relname" select="string(name)" />
      <xsl:param name="items" select="document($advisories.xml)
                                      //advisory[$relname = string(following::release/name[1])]" />

      <xsl:call-template name="html-list-advisories-putitems">
	<xsl:with-param name="items" select="$items" />
      </xsl:call-template>

      <xsl:call-template name="html-list-advisories-release-label">
	<xsl:with-param name="relname" select="name" />
      </xsl:call-template>
    </xsl:for-each>

    <xsl:call-template name="html-list-advisories-putitems">
      <xsl:with-param name="items" select="document($advisories.xml)
                                           //advisory[not(following::release/name[1])]" />
    </xsl:call-template>
  </xsl:template>

  <!-- template: "html-list-advisories-putitems"
       sub-routine to generate a list -->

  <xsl:template name="html-list-advisories-putitems">
    <xsl:param name="items" select="''" />

    <xsl:if test="$items">
      <ul>
	<xsl:for-each select="$items">
	  <li>
	    <xsl:choose>
	      <xsl:when test="@omithref='yes'">
		<xsl:value-of select="name" />
	      </xsl:when>
	      <xsl:when test="name/@role='old'">
		<a><xsl:attribute name="href">
		    <xsl:value-of select="concat($ftpbaseold, name, '.asc')" />
		  </xsl:attribute>
		  <xsl:value-of select="concat(name, '.asc')" /></a>
	      </xsl:when>
	      <xsl:otherwise>
		<a><xsl:attribute name="href">
		    <xsl:value-of select="concat($ftpbase, name, '.asc')" />
		  </xsl:attribute>
		  <xsl:value-of select="concat(name, '.asc')" /></a>
	      </xsl:otherwise>
	    </xsl:choose>
	  </li>
	</xsl:for-each>
      </ul>
    </xsl:if>
  </xsl:template>

  <!-- template: "html-list-advisories-release-label"
       put label for release -->

  <xsl:template name="html-list-advisories-release-label">
    <xsl:param name="relname" select="'none'" />

    <p><xsl:value-of select="$relname" /> released.</p>
  </xsl:template>

  <!-- template: "html-index-advisories-items"
       pulls in the 10 most recent security advisories -->

  <xsl:template name="html-index-advisories-items">
    <xsl:param name="advisories.xml" select="''" />

    <xsl:for-each select="document($advisories.xml)/descendant::advisory[position() &lt;= 10]">
      <xsl:value-of select="$leadingmark" />
      <xsl:choose>
	<xsl:when test="@omithref = 'yes'">
	  <xsl:value-of select="name"/>
	</xsl:when>
	<xsl:otherwise>
	  <a><xsl:attribute name="href"><xsl:value-of select="concat($ftpbase, name, '.asc')"/></xsl:attribute>
	    <xsl:value-of select="name"/></a>
	</xsl:otherwise>
      </xsl:choose>
      <br/>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-index-advisories-items-lastmodified" -->

  <xsl:template name="html-index-advisories-items-lastmodified">
    <xsl:param name="advisories.xml" select="''" />

    <xsl:call-template name="transtable-lookup">
      <xsl:with-param name="word-group" select="'number-month'" />
      <xsl:with-param name="word">
	<xsl:value-of select="document($advisories.xml)/descendant::month[position() = 1]/name"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:value-of select="document($advisories.xml)/descendant::day[position() = 1]/name"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="document($advisories.xml)/descendant::year[position() = 1]/name"/>
  </xsl:template>

  <!-- template: "html-index-news-project-items"
       pulls in the 10 most recent project items -->

  <xsl:template name="html-index-news-project-items">
    <xsl:param name="news.project.xml" select="''" />

    <xsl:for-each select="document($news.project.xml)/descendant::event[position() &lt;= 10]">
      <xsl:value-of select="$leadingmark" /><a>
	<xsl:attribute name="href">
	  news/newsflash.html#<xsl:call-template name="generate-event-anchor"/>
	</xsl:attribute>
	<xsl:choose>
	  <xsl:when test="count(child::title)">
	    <xsl:value-of select="title"/><br/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="p"/><br/>
	  </xsl:otherwise>
	</xsl:choose>
      </a>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-index-news-project-items-lastmodified" -->

  <xsl:template name="html-index-news-project-items-lastmodified">
    <xsl:param name="news.project.xml" select="''" />

    <xsl:call-template name="transtable-lookup">
      <xsl:with-param name="word-group" select="'number-month'" />
      <xsl:with-param name="word">
	<xsl:value-of select="document($news.project.xml)/descendant::month[position() = 1]/name"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:value-of select="document($news.project.xml)/descendant::day[position() = 1]/name"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="document($news.project.xml)/descendant::year[position() = 1]/name"/>
  </xsl:template>

  <!-- template: "html-index-news-press-items"
       pulls in the 10 most recent press items -->

  <xsl:template name="html-index-news-press-items">
    <xsl:param name="news.press.xml" select="''" />

    <xsl:for-each select="document($news.press.xml)/descendant::story[position() &lt; 10]">
      <xsl:value-of select="$leadingmark" /><a>
	<xsl:attribute name="href">
	  news/press.html#<xsl:call-template name="generate-story-anchor"/>
	</xsl:attribute>
	<xsl:value-of select="name"/>
      </a><br/>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "html-index-news-press-items-lastmodified" -->

  <xsl:template name="html-index-news-press-items-lastmodified">
    <xsl:param name="news.press.xml" select="''" />

    <xsl:call-template name="transtable-lookup">
      <xsl:with-param name="word-group" select="'number-month'" />
      <xsl:with-param name="word">
	<xsl:value-of select="document($news.press.xml)/descendant::month[position() = 1]/name"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:value-of select="document($news.press.xml)/descendant::year[position() = 1]/name"/>
  </xsl:template>

  <!-- template: "html-index-navigation-link-list"
       generates navigation bar in index.html -->

  <xsl:template name="html-index-navigation-link-list">
    <xsl:param name="navigation.xml" select="''" />
    <xsl:for-each select="document($navigation.xml)/navigation/category">
      <p>
	<xsl:if test="@src != ''">
	<a>
	    <xsl:attribute name="href">
	      <xsl:value-of select="@src"/>
	    </xsl:attribute>
	    <font size="+1" color="#990000"><b><xsl:value-of select="@name"/></b></font>
	</a>
	</xsl:if>

	<xsl:if test="not(@src != '')">
	  <font size="+1" color="#990000"><b><xsl:value-of select="@name"/></b></font>
	</xsl:if>
	<br/>
	<small>
	  <xsl:apply-templates select="link"/>
	</small>
      </p>
    </xsl:for-each>
  </xsl:template>

  <!-- template: "link" generates links inside of category -->
  <xsl:template match="link">
    &#183;
    <a>
      <xsl:attribute name="href">
	<xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:value-of select="@name"/></a><br/>
  </xsl:template>

  <!-- template: "html-index-mirrors-options-list"
       generates mirror sites list in index.html -->

  <xsl:template name="html-index-mirrors-options-list">
    <xsl:param name="mirrors.xml" select="''" />

    <xsl:choose>
      <xsl:when test="$mirrors.xml = ''">
	<option value="NONE">
	  **No Data**
	</option>
      </xsl:when>

      <xsl:otherwise>
	<xsl:for-each select="document($mirrors.xml)/mirrors/entry[
                              (not(country/@role) or country/@role != 'primary') and
                              host[@type = 'www']/url[@proto = 'httpv6']]">
	  <xsl:sort select="country/@sortkey" data-type="number" />
	  <xsl:sort select="country" />

	  <xsl:for-each select="host[@type = 'www']/url[@proto = 'httpv6']">
	    <option><xsl:attribute name="value"><xsl:value-of select="." /></xsl:attribute>
	      <xsl:choose>
		<xsl:when test="last() = 1">
		  <xsl:value-of select="concat('IPv6 ', ../../country)" />
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="concat('IPv6 ', ../../country, '/', position())" />
		</xsl:otherwise>
	      </xsl:choose>
	    </option>
	  </xsl:for-each>
	</xsl:for-each>

	<xsl:for-each select="document($mirrors.xml)/mirrors/entry[
                              (not(country/@role) or country/@role != 'primary') and
                              host[@type = 'www']/url[@proto = 'http']]">
	  <xsl:sort select="country/@sortkey" data-type="number" />
	  <xsl:sort select="country" />

	  <xsl:for-each select="host[@type = 'www']/url[@proto = 'http']">
	    <option><xsl:attribute name="value"><xsl:value-of select="." /></xsl:attribute>
	      <xsl:choose>
		<xsl:when test="last() = 1">
		  <xsl:value-of select="../../country" />
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="concat(../../country, '/', position())" />
		</xsl:otherwise>
	      </xsl:choose>
	    </option>
	  </xsl:for-each>
	</xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
