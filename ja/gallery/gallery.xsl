<?xml version="1.0" encoding="EUC-JP" ?>
<!-- Original revision: 1.2 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../includes.xsl"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="title" select="'The FreeBSD Gallery'"/>  
  <xsl:variable name="date" select="'$FreeBSD: www/ja/gallery/gallery.xsl,v 1.2 2002/02/28 11:22:53 kuriyama Exp $'"/>

  <xsl:output type="html" encoding="EUC-JP"/>

  <xsl:template match="gallery">
    <html>
      <xsl:copy-of select="$header1"/>
      <body xsl:use-attribute-sets="att.body">
	<xsl:copy-of select="$header2"/>

	<p>世界中で、革新的なインターネットアプリケーションやサービスが
	  FreeBSD で動作しています。このギャラリーは FreeBSD を利用している
	  <xsl:value-of select="count(//entry)"/> の組織や個人の一覧です。
	  ぜひ FreeBSD が <b>あなたのために</b>何ができるのかを
	  もっと調べてみて下さい!</p>

	<ul>
	  <li><a href="cgallery.html"><xsl:value-of 
              select="count(//entry[@type='commercial'])"/> の商業団体
	      </a></li>
	  <li><a href="npgallery.html"><xsl:value-of
              select="count(//entry[@type='nonprofit'])"/> の非営利団体
              </a></li>
          <li><a href="pgallery.html"><xsl:value-of
              select="count(//entry[@type='personal'])"/> の個人サイト
	      </a></li>
	</ul>

	<p>あなたのサイトをこのリストに追加するには、単に
	  <a href="http://www.FreeBSD.org/cgi/gallery.cgi">このフォーム</a>
	  を埋めるだけです。</p>

	<table width="100%" border="0">
	  <tr>
	    <td align="left"><img src="../../gifs/powerlogo.gif" alt=""
				  align="left" border="0"/></td>

	    <td align="left"><img src="../../gifs/power-button.gif" alt="" 
				  align="left" border="0"/></td>
	  </tr>

	  <tr>
	    <td align="right"><img src="../../gifs/pbfbsd2.gif" width="171" 
				   height="64" border="0"/></td>

	    <td align="right"><img src="../../gifs/powerani.gif" width="171"
				   height="64"/></td>

	    <td align="right"><img src="../../gifs/fhp_mini.jpg" width="171"
				   height="64"/></td>
	  </tr>
	</table>
	
	<p align="center"><img src="../../gifs/banner1.gif" alt="" 
			       width="446" height="63" border="0"/></p>

	<p align="center"><img src="../../gifs/banner2.gif" alt="" width="310" 
			       height="63" border="0"/></p>

	<p align="center"><img src="../../gifs/banner3.gif" alt="" width="250" 
			       height="35" border="0"/></p>

	<p align="center"><img src="../../gifs/banner4.gif" alt="" width="225" 
			       height="46" border="0"/></p>

	<p>上の "Powered by FreeBSD" のロゴは
	  <a href="../../gifs/powerlogo.gif">ダウンロードして</a> FreeBSD
	  を利用している個人や商用のホームページで表示させても構いません。
	  このロゴまたは <a href="../copyright/daemon.html">BSD デーモン</a>
	  およびその類似物を営利目的で使用する場合は
	  <a href="mailto:taob@risc.org">Brian Tao</a> ("power"ロゴの作者) や
	  <a href="mailto:mckusick@mckusick.com">Marshall Kirk McKusick</a>
	  (BSD デーモンの肖像の登録商標保持者) への承諾が必要です。</p>

	<xsl:copy-of select="$footer"/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
