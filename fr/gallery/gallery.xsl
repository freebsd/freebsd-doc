<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- 
   The FreeBSD French Documentation Project
   Original revision: 1.1

   Version francaise : Stephane Legrand <stephane@freebsd-fr.org>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>
  <xsl:variable name="section" select="'about'"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="title" select="'La Galerie FreeBSD'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/fr/gallery/gallery.xsl,v 1.2 2003/12/29 17:23:43 stephane Exp $'"/>

  <xsl:output type="html" encoding="iso-8859-1"/>

  <xsl:template match="gallery">
    <html>
      <xsl:copy-of select="$header1"/>
      
            <body xsl:use-attribute-sets="att.body">
      
        <div id="containerwrap">
          <div id="container">
      
      	<xsl:copy-of select="$header2"/>
      
      	<div id="content">
      
      	      <xsl:copy-of select="$sidenav"/>
      
      	      <div id="contentwrap">
      	      
	      <xsl:copy-of select="$header3"/>

	<p>A travers le monde entier, FreeBSD fait fonctionner des applications
          et des services Internet innovants. Cette galerie expose <xsl:value-of
	  select="count(//entry)"/> organisations et particuliers qui ont utilis&#233; 
          FreeBSD pour r&#233;aliser leurs travaux. Regardez et d&#233;couvrez tout ce que 
          FreeBSD peut faire pour <b>vous</b>.</p>

	<ul>
	  <li><a href="cgallery.html"><xsl:value-of 
              select="count(//entry[@type='commercial'])"/> organisations
              commerciales</a></li>
	  <li><a href="npgallery.html"><xsl:value-of
              select="count(//entry[@type='nonprofit'])"/> organisations
              &#224; but non-lucratif</a></li>
          <li><a href="pgallery.html"><xsl:value-of
              select="count(//entry[@type='personal'])"/> sites
              personnels</a></li>
	</ul>

	<p>Pour voir votre site ajout&#233; &#224; ces listes, remplissez simplement
	  <a href="http://www.FreeBSD.org/cgi/gallery.cgi">ce formulaire</a>.</p>

	<table width="100%" border="0">
	  <tr>
	    <td align="left"><img src="{$enbase}/gifs/powerlogo.gif" alt=""
				  align="left" border="0"/></td>

	    <td align="left"><img src="{$enbase}/gifs/power-button.gif" alt="" 
				  align="left" border="0"/></td>
	  </tr>

	  <tr>
	    <td align="right"><img src="{$enbase}/gifs/pbfbsd2.gif" width="171" 
				   height="64" border="0"/></td>

	    <td align="right"><img src="{$enbase}/gifs/powerani.gif" width="171"
				   height="64"/></td>

	    <td align="right"><img src="{$enbase}/gifs/fhp_mini.jpg" width="171"
				   height="64"/></td>
	  </tr>
	</table>
	
	<p align="center"><img src="{$enbase}/gifs/banner1.gif" alt="" 
			       width="446" height="63" border="0"/></p>

	<p align="center"><img src="{$enbase}/gifs/banner2.gif" alt="" width="310" 
			       height="63" border="0"/></p>

	<p align="center"><img src="{$enbase}/gifs/banner3.gif" alt="" width="250" 
			       height="35" border="0"/></p>

	<p align="center"><img src="{$enbase}/gifs/banner4.gif" alt="" width="225" 
			       height="46" border="0"/></p>

	<p>Les logos "Fonctionne gr&#226;ce &#224; FreeBSD" ("Powered by FreeBSD") visibles ci-dessus peuvent &#234;tre
	  <a href="{$enbase}/gifs/powerlogo.gif">t&#233;l&#233;charg&#233;s</a> et affich&#233;s sur les pages
	  d'accueils de sites personnels ou commerciaux fonctionnant sous FreeBSD. L'utilisation de
	  ce logo ou des <a
	  href="../copyright/daemon.html">D&#233;mons BSD</a> dans un but lucratif
	  n&#233;cessite l'accord de <a href="mailto:taob@risc.org">Brian Tao</a>
	  (cr&#233;ateur du logo "Fonctionne gr&#226;ce &#224; FreeBSD") et de <a
	  href="mailto:mckusick@mckusick.com">Marshall Kirk McKusick</a>
	  (d&#233;tenteur de la marque relative &#224; l'image du D&#233;mon BSD).</p>

	  	</div> <!-- contentwrap -->
		<br class="clearboth" />
	
	</div> <!-- content -->
	
	<xsl:copy-of select="$footer"/>
	
        </div> <!-- container -->
   </div> <!-- containerwrap -->

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
