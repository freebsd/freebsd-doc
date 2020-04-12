<?xml version="1.0" encoding="iso-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Quarterly Status Report">
]>

<!-- $FreeBSD$ -->

<!-- Standard header material -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <!-- Sort only reports strictly older than 2019q4 -->
  <xsl:variable name="manual-sorting-condition" select="/report/date/year &gt; 2019 or (/report/date/year = 2019 and /report/date/month = '10-12')"/>

  <xsl:template name="process.sidewrap">
    &nav.about;
  </xsl:template>

  <xsl:template name="process.contentwrap">
	<!-- Process all the <sections>, in order -->
	<xsl:apply-templates select="report/section"/>

	<hr/>

	<!-- Generate a table of contents, sorted if needed -->
	<xsl:for-each select="report/category">
	  <!-- category title and link -->
	  <h3><a><xsl:attribute name="href">#<xsl:value-of
	    select="translate(normalize-space(description),' ', '-')"/></xsl:attribute>
	    <xsl:value-of select="description"/></a></h3>
	  <xsl:variable name="cat-short" select="name"/>
	  <ul>
	    <xsl:choose>
	      <xsl:when test="$manual-sorting-condition">
	        <xsl:for-each select="//project[@cat=$cat-short and @summary]">
	          <li><a><xsl:attribute name="href">#<xsl:value-of
	          select="translate(normalize-space(title), ' ',
	          '-')"/></xsl:attribute><xsl:value-of select="title"/></a>
	          </li>
	        </xsl:for-each>
	      </xsl:when>
	      <xsl:otherwise>
	        <xsl:for-each select="//project[@cat=$cat-short and @summary]">
  	          <xsl:sort select="translate(title, $lowercase, $uppercase)"/>
	          <li><a><xsl:attribute name="href">#<xsl:value-of
	          select="translate(normalize-space(title), ' ',
	          '-')"/></xsl:attribute><xsl:value-of select="title"/></a>
	           </li>
	        </xsl:for-each>
	      </xsl:otherwise>
	    </xsl:choose>

	    <xsl:choose>
	      <xsl:when test="$manual-sorting-condition">
	        <xsl:for-each select="//project[@cat=$cat-short and not(@summary)]">
	          <li><a><xsl:attribute name="href">#<xsl:value-of
	          select="translate(normalize-space(title), ' ',
	          '-')"/></xsl:attribute><xsl:value-of select="title"/></a>
	          </li>
	        </xsl:for-each>
	      </xsl:when>
	      <xsl:otherwise>
	        <xsl:for-each select="//project[@cat=$cat-short and not(@summary)]">
  	          <xsl:sort select="translate(title, $lowercase, $uppercase)"/>
	          <li><a><xsl:attribute name="href">#<xsl:value-of
    	          select="translate(normalize-space(title), ' ',
	          '-')"/></xsl:attribute><xsl:value-of select="title"/></a>
	          </li>
	        </xsl:for-each>
	      </xsl:otherwise>
	    </xsl:choose>
	  </ul>
	</xsl:for-each>
	<ul>
	    <xsl:choose>
	      <xsl:when test="$manual-sorting-condition">
	        <xsl:for-each select="//project[not(@cat)]">
	          <li><a><xsl:attribute name="href">#<xsl:value-of
	          select="translate(normalize-space(title), ' ',
	          '-')"/></xsl:attribute><xsl:value-of select="title"/></a>
	          </li>
	        </xsl:for-each>
	      </xsl:when>
	      <xsl:otherwise>
   	        <xsl:for-each select="//project[not(@cat)]">
  	          <xsl:sort select="translate(title, $lowercase, $uppercase)"/>
	          <li><a><xsl:attribute name="href">#<xsl:value-of
	          select="translate(normalize-space(title), ' ',
	          '-')"/></xsl:attribute><xsl:value-of select="title"/></a>
	          </li>
	        </xsl:for-each>
	      </xsl:otherwise>
	    </xsl:choose>
	</ul>

	<hr/>

	<!-- For each category, process the corresponding projects and sort
	     them by title if needed, so they will be listed in the same
	     order as they are in the table of contents -->
	<xsl:choose>
	    <xsl:when test="report/category">
		<xsl:for-each select="report/category">

		<!-- category title -->
		<br/><h1><a>
		  <xsl:attribute name="name"><xsl:value-of select="translate(normalize-space(description), ' ', '-')"/></xsl:attribute>
		  <xsl:attribute name="href">#<xsl:value-of select="translate(normalize-space(description), ' ', '-')"/></xsl:attribute>
		  <xsl:value-of select="description"/></a></h1>
		  <!-- per-category intro text, if present -->
		  <xsl:apply-templates select="p" mode="copy.html"/><br/>

		<xsl:variable name="cat-short" select="name"/>
  	        <xsl:choose>
	          <xsl:when test="$manual-sorting-condition">
	    	    <xsl:apply-templates select="//project[@cat=$cat-short]"/>
 	          </xsl:when>
	          <xsl:otherwise>
	  	    <xsl:apply-templates select="//project[@cat=$cat-short]">
		    <xsl:sort select="translate(title, $lowercase, $uppercase)"/>
		    </xsl:apply-templates>
 	          </xsl:otherwise>
	        </xsl:choose>
		</xsl:for-each>

	    </xsl:when>
	    <xsl:otherwise>

	      <xsl:choose>
 	        <xsl:when test="$manual-sorting-condition">
		  <xsl:apply-templates select="report/project"/>
	        </xsl:when>
	        <xsl:otherwise>
		  <xsl:apply-templates select="report/project">
		  <xsl:sort select="translate(title, $lowercase, $uppercase)"/>
		  </xsl:apply-templates>
	        </xsl:otherwise>
	      </xsl:choose>

	    </xsl:otherwise>
	</xsl:choose>

	<!-- Standard footer -->
	<a href="../news.html">News Home</a> | <a href="status.html">Status Home</a>
  </xsl:template>

  <!-- Everything that follows are templates for the rest of the content -->

  <!-- A section creates a header, and copies in all the <p> elements from
       itself -->
  <xsl:template match="section">
    <h1><xsl:value-of select="title"/></h1>

    <xsl:apply-templates select="p" mode="copy.html"/>
  </xsl:template>

  <!-- A project creates a header, and then process the three components of
       a project report (links, contact details, project body) in turn -->
  <xsl:template match="project">
    <h2>
    <xsl:if test="icon">
      <xsl:variable name="icon">
	<xsl:value-of select="icon"/>
      </xsl:variable>

      <xsl:element name="img">
	<xsl:attribute name="src">
	  <xsl:value-of select="concat('./images/', $icon)"/>
	</xsl:attribute>
	<xsl:attribute name="style">
	  <xsl:text>display: inline</xsl:text>
	</xsl:attribute>
      </xsl:element>
    </xsl:if>
    <a>
	<xsl:attribute name="name"><xsl:value-of
	  select="translate(normalize-space(title), ' ', '-')"/></xsl:attribute>
	  <xsl:attribute name="href">#<xsl:value-of
	  select="translate(normalize-space(title), ' ', '-')"/></xsl:attribute>
	  <xsl:value-of select="title"/></a></h2>

    <xsl:apply-templates select="links"/>

    <xsl:apply-templates select="contact"/>

    <xsl:apply-templates select="body"/>

    <xsl:if test="sponsor">
      <xsl:variable name="sponsors">
	<xsl:for-each select="sponsor">
	  <xsl:value-of select="normalize-space()"/>
	  <xsl:choose>
	    <xsl:when test="position() = last()">.</xsl:when>
	    <xsl:when test="position() = (last() - 1)">, and </xsl:when>
	    <xsl:when test="position() &lt; (last() - 1)">, </xsl:when>
	    <xsl:otherwise>.</xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </xsl:variable>

      <p>This project was sponsored by <xsl:value-of select="$sponsors"/></p>
    </xsl:if>

    <xsl:if test="partialsponsor">
      <xsl:variable name="partialsponsors">
	<xsl:for-each select="partialsponsor">
	  <xsl:value-of select="normalize-space()"/>
	  <xsl:choose>
	    <xsl:when test="position() = last()">.</xsl:when>
	    <xsl:when test="position() = (last() - 1)">, and </xsl:when>
	    <xsl:when test="position() &lt; (last() - 1)">, </xsl:when>
	    <xsl:otherwise>.</xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </xsl:variable>

      <p>This project was sponsored in part by <xsl:value-of select="$partialsponsors"/></p>
    </xsl:if>

    <xsl:apply-templates select="help"/>

    <hr/>
  </xsl:template>

  <!-- Create a paragraph to hold the contact information.  Iterate over
       each <person> element, copying their data in.  All but the last
       person has a terminating <br> in the output. -->
  <xsl:template match="contact">
    <p>
      <xsl:for-each select="person">
	Contact: <xsl:value-of select="name"/> &lt;<a>
	  <xsl:attribute name="href">mailto:<xsl:value-of select="email"/></xsl:attribute><xsl:value-of select="email"/></a>&gt;
	<xsl:if test="position() != last()"><br/></xsl:if>
      </xsl:for-each>
    </p>
  </xsl:template>

  <!-- Create a table to hold the link information.  Iterate over each
       <url> element, adding a row to hold the description and URL.
       Both work as links. -->
  <xsl:template match="links">
    <table title="Links" style="white-space: nowrap;">
      <tr>
	<td>Links</td>
      </tr>
      <xsl:for-each select="url">
	<tr>
	  <td>
	    <a href="{@href}" title="{@href}">
	      <xsl:value-of select="normalize-space()"/>
	    </a>
	  </td>
	  <td>
	    URL: <a href="{@href}">
	      <xsl:attribute name="title">
		<xsl:value-of select="normalize-space()"/>
	      </xsl:attribute>
	      <xsl:value-of select="@href"/>
	    </a>
	  </td>
	</tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <!-- Body is a doddle.  Since it contains HTML we just copy in all the
       child elements. -->
  <xsl:template match="body">
    <xsl:apply-templates select="child::node()" mode="copy.html"/>
  </xsl:template>

  <xsl:template match="help">
    <h3>Open tasks:</h3>
    <ol>
      <xsl:for-each select="task">
	<li><xsl:apply-templates select="child::node()" mode="copy.html"/></li>
      </xsl:for-each>
    </ol>
  </xsl:template>
</xsl:stylesheet>
