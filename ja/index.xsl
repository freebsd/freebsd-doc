<?xml version="1.0" encoding="EUC-JP" ?>

<!-- $FreeBSD$ -->
<!-- Original revision: 1.1 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:variable name="title" select="'The FreeBSD Project'"/>

  <xsl:output type="html" encoding="EUC-JP"/>

  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="$title"/></title>
    
	<meta name="description" content="The FreeBSD Project"/>
    
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Gallery,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs, 
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
      </head>
  
      <body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#840084"
	    alink="#0000FF">
    
	<table border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td><a href="http://www.FreeBSD.org/index.html">
		<img src="../gifs/freebsd_1.gif" height="94" width="306"
		     alt="FreeBSD: このパワーをあなたのために" border="0"/></a></td>
	    
	    <td align="right" valign="bottom" width="300">
	      <form action="http://www.FreeBSD.org/cgi/mirror.cgi" 
		    method="GET">
		
		<br/>
		
		<font color="#990000"><b>お近くのサーバをお選びください:</b></font>
		
		<br/>
	      
		<select name="goto">
		  <!--  Only list TRUE mirrrors here! Native language pages 
		        which are not mirrored should be listed in
		        support.sgml.  -->

		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">6Bone(IPv6)</option>
		  <option value="http://www.au.FreeBSD.org/">オーストラリア/1</option>
		  <option value="http://www.br.FreeBSD.org/www.freebsd.org/">ブラジル/1</option>
		  <option value="http://www2.br.FreeBSD.org/www.freebsd.org/">ブラジル/2</option>
		  <option value="http://www3.br.FreeBSD.org/">ブラジル/3</option>
		  <option value="http://www.bg.FreeBSD.org/">ブルガリア</option>
		  <option value="http://www.ca.FreeBSD.org/">カナダ/1</option>
		  <option value="http://www.cn.FreeBSD.org/">中国</option>
		  <option value="http://www.cz.FreeBSD.org/">チェコ</option>
		  <option value="http://www.dk.FreeBSD.org/">デンマーク</option>
		  <option value="http://www.ee.FreeBSD.org/">エストニア</option>
		  <option value="http://www.fi.FreeBSD.org/">フィンランド</option>
		  <option value="http://www.fr.FreeBSD.org/">フランス</option>
		  <option value="http://www.de.FreeBSD.org/">ドイツ/1</option>
		  <option value="http://www1.de.FreeBSD.org/">ドイツ/2</option>
		  <option value="http://www2.de.FreeBSD.org/">ドイツ/3</option>
		  <option value="http://www.gr.FreeBSD.org/">ギリシア</option>
		  <option value="http://www.hu.FreeBSD.org/">ハンガリー</option>
		  <option value="http://www.ie.FreeBSD.org/">アイルランド</option>
		  <option value="http://www.it.FreeBSD.org/">イタリア/1</option>
		  <option value="http://www.gufi.org/mirrors/www.freebsd.org/data/">イタリア/2</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">日本</option>
		  <option value="http://www.kr.FreeBSD.org/">韓国</option>
		  <option value="http://www2.kr.FreeBSD.org/">韓国/2</option>
		  <option value="http://www.lv.FreeBSD.org/">ラトビア</option>
		  <option value="http://www.nl.FreeBSD.org/">オランダ</option>
		  <option value="http://www2.nl.FreeBSD.org/">オランダ/2</option>
		  <option value="http://www.nz.FreeBSD.org/">ニュージーランド</option>
		  <option value="http://www.no.FreeBSD.org/">ノルウェー</option>
		  <option value="http://www.pl.FreeBSD.org/">ポーランド/1</option>
		  <option value="http://www2.pl.FreeBSD.org/">ポーランド/2</option>
		  <option value="http://www.pt.FreeBSD.org/">ポルトガル/1</option>
		  <option value="http://www2.pt.FreeBSD.org/">ポルトガル/2</option>
		  <option value="http://www.ro.FreeBSD.org/">ルーマニア</option>
		  <option value="http://www.ru.FreeBSD.org/">ロシア/1</option>
		  <option value="http://www2.ru.FreeBSD.org/">ロシア/2</option>
		  <option value="http://www3.ru.FreeBSD.org/">ロシア/3</option>
		  <option value="http://www4.ru.FreeBSD.org/">ロシア/4</option>
		  <option value="http://www.sg.FreeBSD.org/">シンガポール</option>
		  <option value="http://www.sk.FreeBSD.org/">スロバキア</option>
		  <option value="http://www.si.FreeBSD.org/">スロベニア</option>
		  <option value="http://www.es.FreeBSD.org/">スペイン</option>
		  <option value="http://www.za.FreeBSD.org/">南アフリカ/1</option>
		  <option value="http://www2.za.FreeBSD.org/">南アフリカ/2</option>
		  <option value="http://www.se.FreeBSD.org/">スウェーデン</option>
		  <option value="http://www.ch.FreeBSD.org/">スイス</option>
		  <option value="http://www.tw.FreeBSD.org/www.freebsd.org/data/">台湾</option>
		  <option value="http://www.tr.FreeBSD.org/">トルコ</option>
		  <option value="http://www.enderunix.org/freebsd/">トルコ/2</option>
		  <option value="http://www.ua.FreeBSD.org/">ウクライナ/1</option>
		  <option value="http://www2.ua.FreeBSD.org/">ウクライナ/2</option> 
		  <option value="http://www4.ua.FreeBSD.org/">ウクライナ/クリミア</option> 
		  <option value="http://www.uk.FreeBSD.org/">イギリス/1</option>
		  <option value="http://www2.uk.FreeBSD.org/">イギリス/2</option>
		  <option value="http://www3.uk.FreeBSD.org/">イギリス/3</option>
		  <option value="http://www.FreeBSD.org/">アメリカ/カリフォルニア</option>
		</select>
		
		<input type="submit" value=" Go "/>
		
		<br/>
		<font color="#990000"><b>言語:</b></font> 
		<a href="../">英語</a>, 
		<a href="../es/index.html">スペイン語</a>, 
		<a href="../ru/index.html">ロシア語</a>, 
		<a href="support.html#web">その他</a>
	      </form>
	    </td>
	  </tr>
	</table>
	
	<br/>
	
	<!-- Security alert -->
	<table width="100%" bgcolor="#990000"
	       cellpadding="4" cellspacing="0" border="0">
	  <tr>
	    <td>
	      <h2 align="center">
		<font color="#FFFFFF">重要</font></h2>
	      <p><font color="#FFFFFF">
		2001 年 7 月 23 日以前の FreeBSD には,
		リモートからの影響を受けるセキュリティ上の問題を
		含む telnet デーモンが含まれています.
		詳細は
		<a href="ftp://ftp.FreeBSD.org/pub/FreeBSD/CERT/advisories/FreeBSD-SA-01:49.telnetd.v1.1.asc">セキュリティ勧告</a>
		をご覧下さい.</font></p>
	    </td>
	  </tr>
	</table>

	<hr size="1" noshade="noshade"/>

	<!-- Main layout table -->
	<table border="0" cellspacing="0" cellpadding="2">
	  <tr>
	    <!-- Red strip down left hand of sidebar -->
	    <td bgcolor="#990000">&#xa0;</td>
	    
	    <td bgcolor="#ffcc66">&#xa0;</td>
	    
	    <td></td>
	    
	    <!-- Main body column -->

	    <td rowspan="2" align="left" valign="top">
	      <!-- News / release info table -->
	      <table border="0" cellspacing="0" cellpadding="1"
		     bgcolor="#000000" width="100%">
		<tr>
		  <td>
		    <table cellpadding="4" cellspacing="0" border="0"
			   bgcolor="#ffcc66" width="100%">
		      <tr>
			<td valign="top"><b>最新ニュース</b><br/>
			  <font size="-1">
			    <!-- Code to pull in the most recent four news
			         items -->
			    <xsl:for-each select="descendant::event[position() &lt;= 4]">
			      >> <a>
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
			  </font>
			</td>

			<td valign="top"><b>最新リリース:
			    <xsl:value-of select="$rel.current"/></b><br/>
			
			  <small>>> <a href="{$u.rel.announce}">アナウンス</a><br/>
			    >> <a href="{$base}/doc/ja_JP.eucJP/books/handbook/install.html">インストールガイド</a><br/>
			  >> <a href="{$u.rel.notes}">リリースノート</a><br/>
			    >> <a href="{$u.rel.errata}">Errata</a></small></td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>

	      <h2><font color="#990000">FreeBSD とは?</font></h2>
	
	      <p>FreeBSD は Intel 互換機 (x86), DEC Alpha, PC-98
		アーキテクチャ用の先進的な BSD UNIX
		オペレーティングシステムであり,
		<a href="{$base}/handbook/staff.html">多くの人たち</a> によって
		によって保守・開発されています.
		その他の<a href="{$base}/platforms/index.html">プラットフォーム
		</a> は現在開発中です.</p>
	      
	      <h2><font color="#990000">最先端の機能</font></h2>

	      <p>FreeBSD は (市販の最良のものも含めて) 他のオペレーティング
		システムに未だに欠けている最先端のネットワーク, パフォーマンス,
		セキュリティ, 互換性といった <a href="{$base}/features.html">
		  機能</a> を今, 提供しています.</p>
	      
	      <h2><font color="#990000">強力なインターネットサポート</font></h2>

	      <p>FreeBSD は理想的な <a href="{$base}/internet.html">
		  インターネットやイントラネット</a> サーバになります. 負荷が
		極めて高くなった状態でさえ強固なネットワークサービスを提供し,
		ユーザプロセスが同時に何百, 何千になっても良好な反応時間を
		維持するようにメモリを効率的に利用します.
		FreeBSD を利用したアプリケーションやサービスの例を
		載せていますので, ぜひ我々の
		<a href="gallery/gallery.html">ギャラリー</a>
		を訪れてみてください.</p>
	    
	      <h2><font color="#990000">利用可能な, さまざまなアプリケーション
		</font></h2>

	      <p>FreeBSD の品質と今日の低価格で高速な PC ハードウェアが
		結びつくことによって, FreeBSD は市販の UNIX ワークステーションと
		比較してとても経済的な選択肢となります.
		非常に数多くのデスクトップ用やサーバ用の
		<a href="{$base}/applications.html">アプリケーション</a>
		が整っています.</p>
	    
	      <h2><font color="#990000">簡単インストール</font></h2>

	      <p>FreeBSD は CD-ROM やフロッピーディスク, 磁気テープ, MS-DOS
		パーティションなどのさまざまなメディアからインストールすることが
		できます. ネットワークに接続しているなら, anonymous FTP や NFS
		を用いて <i>直接</i> インストールすることもできます.
		必要なのは 1.44MB の起動フロッピー 2 枚と,
		<a href="{$base}/handbook/install.html">これらの方法</a>
		だけです.</p>

	      <h2><font color="#990000">FreeBSD は<i>無料</i>です</font></h2>
	    
	      <a href="copyright/daemon.html"><img src="../gifs/dae_up3.gif" 
						   alt=""
						   height="81" width="72" 
						   align="right" 
						   border="0"/></a>

	      <p>このような特色を持ったオペレーティングシステムは高い値段で
		販売されていると思われるかもしれませんが, FreeBSD
		は <a href="{$base}/copyright/index.html">無料</a> で入手でき,
		すべてのソースコードが付属しています.
		試してみようかな, という方は
		<a href="{$base}/doc/ja_JP.eucJP/books/handbook/mirrors.html">
		  より詳しい情報</a> を
		ご覧ください.</p>
	      
	      <h2><font color="#990000">FreeBSD への貢献</font></h2>

	      <p>FreeBSD に貢献するのは簡単です.
		あなたが FreeBSD の中で改善できそうな部分を探し,
		その部分に変更を (注意深く, わかりやすく) 加えて
		FreeBSD プロジェクトに届けるだけです.
		その際には send-pr を使うか,
		もし知っているなら, コミッターに直接連絡しても OK です.
		変更は, FreeBSD の文書に対するものでも, FreeBSD
		ソースコードに対するものでも構いません.
		詳しくは, FreeBSD ハンドブックの
		<a href="http://www.FreeBSD.org/ja/handbook/contrib.html">
		  FreeBSD への貢献</a>
		(<a href="http://www.FreeBSD.org/handbook/contrib.html">原文</a>)
		というセクションをご覧ください.</p>
	      
	      <br/>
	      
	      <table border="3" cellspacing="0" cellpadding="5">
		<tr>
		  <td>FreeBSD についてもっとよく知りたくなったら,
		    FreeBSD に関連する
		    <a href="{$base}/publish.html">出版物</a> や
		    <a href="news/press.html">FreeBSD 関係の報道</a> の
		    ギャラリーを訪ねたり, このウェブサイトを
		    見てみてください!</td>
		</tr>
	      </table>
	    </td>
	  </tr>
	
	  <!-- New row for the strip of links that normally runs down the
	       left hand side.  This is set up this way so that if you are
	       viewing the site in a browser that does not support tables
	       the main body copy will appear first, with the list of links
	       at the end.  It's not perfect, but it works. -->
	  <tr>
	    <td bgcolor="#990000">&#xa0;</td>
	    
	    <td align="left" valign="top" bgcolor="#ffcc66">
	      <p><big><font color="#990000"><b>ニュース</b></font></big>
	      
		<small><br/>
		  &#xa0;&#xa0;<a href="news/newsflash.html">アナウンス</a><br/>
		  &#xa0;&#xa0;<a href="news/press.html">報道</a><br/>
		  &#xa0;&#xa0;<a href="news/index.html">さらに ...</a>
		</small></p>
	    
	      <p><big><font color="#990000"><b>ソフトウェア</b></font></big>
	      
		<small><br/>
		  &#xa0;&#xa0;<a href="{$base}/doc/ja_JP.eucjP/books/handbook/mirrors.html">FreeBSD を手に入れる</a><br/>
		  &#xa0;&#xa0;<a href="releases/index.html">リリース情報</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/ports/index.html">Ports Collection</a><br/>
		</small></p>
	    
	      <p><big><font color="#990000"><b>ドキュメント</b></font></big>
		
		<small><br/>
		  &#xa0;&#xa0;<a href="projects/newbies.html">初心者のために</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/handbook/index.html">ハンドブック</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/FAQ/index.html">FAQ</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/docproj/index.html">Doc. Project</a><br/>
		  &#xa0;&#xa0;<a href="docs.html">さらに...</a><br/>
		</small></p>
	    
	      <p><big><font color="#990000"><b>サポート</b></font></big>
	      
		<small><br/>
		  &#xa0;&#xa0;<a href="{$base}/support.html#mailing-list">メーリングリスト</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/support.html#newsgroups">ニュースグループ</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/support.html#user">ユーザグループ</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/support.html#web">Web 上の資料</a><br/>
		  &#xa0;&#xa0;<a href="security/index.html">セキュリティ</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/support.html">さらに...</a>
		</small></p>
	      
	      <p><big><font color="#990000"><b>開発</b></font></big>
		
		<small><br/>
		  &#xa0;&#xa0;<a href="projects/index.html">プロジェクト</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/support.html#gnats">バグレポート</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/support.html#cvs">CVS リポジトリ</a><br/>
		</small></p>
	      
	      <p><big><font color="#990000"><b>ベンダ</b></font></big>
		
		<small><br/>
		  &#xa0;&#xa0;<a href="{$base}/commercial/software_bycat.html">ソフトウェア</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/commercial/hardware.html">ハードウェア</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/commercial/consulting_bycat.html">コンサルティング</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/commercial/misc.html">その他</a><br/>
		</small></p>
	      
	      <p><big><font color="#990000"><b>このサイトについて</b></font></big>
		
		<small><br/>
		  &#xa0;&#xa0;<a href="{$base}/search/index-site.html">サイトマップ</a><br/>
		  &#xa0;&#xa0;<a href="{$base}/search/search.html">検索</a><br/>
		  &#xa0;&#xa0;<a href="internal/index.html">さらに...</a><br/>
		</small></p>
	      
	      <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
		<small>&#xa0;&#xa0;検索:<br/>
		  <input type="text" name="words" size="10"/>
		  <input type="hidden" name="max" value="25"/>
		  <input type="hidden" name="source" value="www"/>
		  <input type="submit" value="実行"/></small>
	      </form>
	    </td>
	  </tr>
	</table>

	<hr/>
	
	<table border="0" cellspacing="0" cellpadding="3">
	  <tr>
	    <td><a href="http://www.freebsdmall.com/"><img
							   src="../gifs/mall_title_medium.gif" alt="[FreeBSD Mall]"
							   height="65" width="165" border="0"/></a></td>
	    
	    <td><a href="http://www.ugu.com/"><img src="../gifs/ugu_icon.gif"
						   alt="[Sponsor of Unix Guru Universe]" 
						   height="64" width="76"
						   border="0"/></a></td>
	  
	    <td><a href="http://www.daemonnews.org/"><img src="../gifs/darbylogo.gif"
		alt="[Daemon News]" height="45" width="130"
		border="0"/></a></td>
	  
	    <td><a href="{$base}/copyright/daemon.html"><img
							     src="../gifs/powerlogo.gif" 
							     alt="[Powered by FreeBSD]"
							     height="64" 
							     width="160" 
							     border="0"/></a></td>
	  </tr>
	</table>

	<p><small>このウェブサイトは毎日 8:00 UTC と 20:00 UTC に更新しています.
	  </small></p>
    
	<hr/>

	<table width="100%" cellpadding="0" border="0" cellspacing="0">
	  <tr>
	    <td align="left" 
		valign="top"><small><a href="{$base}/mailto.html">お問い合わせ先
		</a> : <a href="jabout.html">日本語化について</a><br/>
		<xsl:value-of select="$date"/></small></td>

	    <td align="right" 
		valign="top"><small><a href="copyright/index.html">Copyright</a> (c) 1995-2001
		The FreeBSD Project.<br/>
		All rights reserved.</small></td>
	  </tr>
	</table>	    
      </body>
    </html>  
  </xsl:template>    
</xsl:stylesheet>

<!-- 
     Local Variables:
     mode: xml
     sgml-indent-data: t
     sgml-omittag: nil
     sgml-always-quote-attributes: t
     End:
-->
