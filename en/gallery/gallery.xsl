<?xml version="1.0" encoding="ISO-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="title" select="'The FreeBSD Gallery'"/>  
  <xsl:variable name="date" select="'$FreeBSD: www/en/gallery/gallery.xsl,v 1.2 2003/10/23 17:13:43 kensmith Exp $'"/>

  <xsl:output type="html" encoding="iso-8859-1"/>

  <xsl:template match="gallery">
    <html>
      <xsl:copy-of select="$header1"/>
      <body xsl:use-attribute-sets="att.body">
	<xsl:copy-of select="$header2"/>

	<p><b>Because of the hard maintaince and low benefit the gallery pages
	  bring to both the Project and the listed websites, it has been
	  decided to spend the time working on other stuff related to FreeBSD than
	  these pages.  The gallery will be removed in two weeks, no further
	  submissions will be processed.</b></p>

	<p><b>Note:</b> This has no influence on the <a
	  href="../commercial/">Commercial Gallery</a>!
	</p>

	<ul>
	  <li><a href="cgallery.html"><xsl:value-of 
              select="count(//entry[@type='commercial'])"/> commercial
	      organizations</a></li>
	  <li><a href="npgallery.html"><xsl:value-of
              select="count(//entry[@type='nonprofit'])"/> non-profit
              organizations</a></li>
          <li><a href="pgallery.html"><xsl:value-of
              select="count(//entry[@type='personal'])"/> personal 
	      sites</a></li>
	</ul>

	<table width="100%" border="0">
	  <tr>
	    <td align="left"><img src="../gifs/powerlogo.gif" alt=""
				  align="left" border="0"/></td>

	    <td align="left"><img src="../gifs/power-button.gif" alt="" 
				  align="left" border="0"/></td>
	  </tr>

	  <tr>
	    <td align="right"><img src="../gifs/pbfbsd2.gif" width="171" 
				   height="64" border="0"/></td>

	    <td align="right"><img src="../gifs/powerani.gif" width="171"
				   height="64"/></td>

	    <td align="right"><img src="../gifs/fhp_mini.jpg" width="171"
				   height="64"/></td>
	  </tr>
	</table>
	
	<p align="center"><img src="../gifs/banner1.gif" alt="" 
			       width="446" height="63" border="0"/></p>

	<p align="center"><img src="../gifs/banner2.gif" alt="" width="310" 
			       height="63" border="0"/></p>

	<p align="center"><img src="../gifs/banner3.gif" alt="" width="250" 
			       height="35" border="0"/></p>

	<p align="center"><img src="../gifs/banner4.gif" alt="" width="225" 
			       height="46" border="0"/></p>

	<p>The "Powered by FreeBSD" logos above may be 
	  <a href="../gifs/powerlogo.gif">downloaded</a> and displayed on 
	  personal or commercial home pages served by FreeBSD machines. Use of
	  this logo or the likeliness of the <a
	  href="../copyright/daemon.html">BSD Daemons</a> for profitable gain
	  requires the consent of <a href="mailto:taob@risc.org">Brian Tao</a>
	  (creator of the "power" logo) and <a
	  href="mailto:mckusick@mckusick.com">Marshall Kirk McKusick</a>
	  (trademark holder for the BSD Daemon image).</p>

	<xsl:copy-of select="$footer"/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
