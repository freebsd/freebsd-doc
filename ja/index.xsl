<?xml version="1.0" encoding="EUC-JP" ?>

<!-- $FreeBSD: www/ja/index.xsl,v 1.27 2003/07/07 21:10:41 hrs Exp $ -->
<!-- Original revision: 1.68 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="enbase" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/ja/index.xsl,v 1.27 2003/07/07 21:10:41 hrs Exp $'"/>
  <xsl:variable name="title" select="'The FreeBSD Project'"/>

  <xsl:output type="html" encoding="EUC-JP"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="$title"/></title>
    
	<meta name="description" content="The FreeBSD Project"/>
    
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Gallery,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs, 
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="/favicon.ico" type="image/x-icon"/>
      </head>
  
      <body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#840084"
	    alink="#0000FF">
    
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
	  <tr>
	    <td><a href="http://www.FreeBSD.org/index.html">
		<img src="../gifs/freebsd_1.gif" height="94" width="306"
		     alt="FreeBSD: このパワーをあなたのために" border="0"/></a></td>
	    
	    <td align="right" valign="bottom">
	      <form action="http://www.FreeBSD.org/cgi/mirror.cgi" 
		    method="get">
		
		<br/>
		
		<font color="#990000"><b>お近くのサーバをお選びください:</b></font>
		
		<br/>
	      
		<select name="goto">
		  <!--  Only list TRUE mirrrors here! Native language pages 
		        which are not mirrored should be listed in
		        support.sgml.  -->

		  <option value="http://www2.at.FreeBSD.org/">IPv6 オーストリア</option>
		  <option value="http://www.dk.FreeBSD.org/">IPv6 デンマーク</option>
		  <option value="http://www2.de.FreeBSD.org">IPv6 ドイツ</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">IPv6 (6Bone) 日本</option>
 		  <option value="http://www2.no.FreeBSD.org/">IPv6 ノルウェー</option>
		  <option value="http://www.ar.FreeBSD.org/">アルゼンチン</option>
		  <option value="http://www.au.FreeBSD.org/">オーストラリア/1</option>
		  <option value="http://www2.au.FreeBSD.org/">オーストラリア/2</option>
		  <option value="http://www3.au.FreeBSD.org/">オーストラリア/3</option>
		  <option value="http://www4.au.FreeBSD.org/">オーストラリア/4</option>
		  <option value="http://www5.au.FreeBSD.org/">オーストラリア/5</option>
		  <option value="http://www6.au.FreeBSD.org/">オーストラリア/6</option>
		  <option value="http://freebsd.itworks.com.au/">オーストラリア/8</option>
		  <option value="http://www.at.FreeBSD.org/">オーストリア/1</option>
		  <option value="http://www2.at.FreeBSD.org/">オーストリア/2</option>
		  <option value="http://freebsd.unixtech.be/">ベルギー</option>
		  <option value="http://www.br.FreeBSD.org/www.freebsd.org/">ブラジル/1</option>
		  <option value="http://www2.br.FreeBSD.org/www.freebsd.org/">ブラジル/2</option>
		  <option value="http://www3.br.FreeBSD.org/">ブラジル/3</option>
		  <option value="http://www.bg.FreeBSD.org/">ブルガリア</option>
		  <option value="http://www.ca.FreeBSD.org/">カナダ</option>
		  <option value="http://www2.ca.FreeBSD.org/">カナダ/2</option>
		  <!--
		  <option value="http://www3.ca.FreeBSD.org/">カナダ/3</option>
		  -->
		  <option value="http://www.cn.FreeBSD.org/">中国</option>
		  <option value="http://www.cz.FreeBSD.org/">チェコ</option>
		  <option value="http://www.dk.FreeBSD.org/">デンマーク</option>
		  <!--
		  <option value="http://www2.cz.FreeBSD.org/">チェコ/2</option>
		  -->
		  <option value="http://www.dk.FreeBSD.org/">デンマーク/1</option>
		  <option value="http://www3.dk.FreeBSD.org/">デンマーク/3</option>
		  <option value="http://www.ee.FreeBSD.org/">エストニア</option>
		  <option value="http://www.fi.FreeBSD.org/">フィンランド</option>
		  <option value="http://www2.fi.FreeBSD.org/">フィンランド/2</option>
		  <option value="http://www.fr.FreeBSD.org/">フランス</option>
		  <option value="http://www.de.FreeBSD.org/">ドイツ/1</option>
		  <option value="http://www1.de.FreeBSD.org/">ドイツ/2</option>
		  <option value="http://www2.de.FreeBSD.org/">ドイツ/3</option>
		  <option value="http://www.gr.FreeBSD.org/">ギリシア</option>
		  <option value="http://www.FreeBSD.gr/">ギリシア/1</option>
		  <option value="http://www.hk.FreeBSD.org/">香港</option>
		  <option value="http://www.hu.FreeBSD.org/">ハンガリー/1</option>
		  <option value="http://www2.hu.FreeBSD.org/">ハンガリー/2</option>
		  <option value="http://www.is.FreeBSD.org/">アイスランド</option>
		  <option value="http://www.ie.FreeBSD.org/">アイルランド/1</option>
		  <option value="http://www2.ie.FreeBSD.org/">アイルランド/2</option>
		  <option value="http://www.it.FreeBSD.org/">イタリア/1</option>
		  <option value="http://www.gufi.org/mirrors/www.freebsd.org/data/">イタリア/2</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">日本</option>
		  <option value="http://www.kr.FreeBSD.org/">韓国</option>
		  <option value="http://www2.kr.FreeBSD.org/">韓国/2</option>
		  <option value="http://www3.kr.FreeBSD.org/">韓国/3</option>
		  <option value="http://www.lv.FreeBSD.org/">ラトビア</option>
		  <option value="http://www.lt.FreeBSD.org/">リトアニア</option>
		  <option value="http://www.nl.FreeBSD.org/">オランダ/1</option>
		  <option value="http://www2.nl.FreeBSD.org/">オランダ/2</option>
		  <option value="http://www.nz.FreeBSD.org/">ニュージーランド</option>
		  <option value="http://www.no.FreeBSD.org/">ノルウェー/1</option>
		  <option value="http://www2.no.FreeBSD.org/">ノルウェー/2</option>
		  <option value="http://www.FreeBSD.org.ph/">フィリピン</option>
		  <option value="http://www2.no.FreeBSD.org/">ノルウェー</option>
		  <option value="http://www.pl.FreeBSD.org/">ポーランド/1</option>
		  <option value="http://www2.pl.FreeBSD.org/">ポーランド/2</option>
		  <!--
		  <option value="http://www.pt.FreeBSD.org/">ポルトガル/1</option>
		  -->
		  <option value="http://www2.pt.FreeBSD.org/">ポルトガル/2</option>
		  <option value="http://www4.pt.FreeBSD.org/">ポルトガル/4</option>
		  <option value="http://www.ro.FreeBSD.org/">ルーマニア</option>
		  <option value="http://www2.ro.FreeBSD.org/">ルーマニア/2</option>
		  <option value="http://www3.ro.FreeBSD.org/">ルーマニア/3</option>
		  <option value="http://www4.ro.FreeBSD.org/">ルーマニア/4</option>
		  <option value="http://www.ru.FreeBSD.org/">ロシア/1</option>
		  <option value="http://www2.ru.FreeBSD.org/">ロシア/2</option>
		  <option value="http://www3.ru.FreeBSD.org/">ロシア/3</option>
		  <option value="http://www4.ru.FreeBSD.org/">ロシア/4</option>
		  <option value="http://www.sm.FreeBSD.org/">サンマリノ</option>
		  <option value="http://www2.sg.FreeBSD.org/">シンガポール</option>
		  <option value="http://www.sk.FreeBSD.org/">スロバキア/1</option>
		  <option value="http://www2.sk.FreeBSD.org/">スロバキア/2</option>
		  <option value="http://www.si.FreeBSD.org/">スロベニア/1</option>
		  <option value="http://www2.si.FreeBSD.org/">スロベニア/2</option>
		  <option value="http://www.es.FreeBSD.org/">スペイン/1</option>
		  <option value="http://www2.es.FreeBSD.org/">スペイン/2</option>
		  <option value="http://www3.es.FreeBSD.org/">スペイン/3</option>
		  <option value="http://www.za.FreeBSD.org/">南アフリカ/1</option>
		  <option value="http://www2.za.FreeBSD.org/">南アフリカ/2</option>
		  <option value="http://www.se.FreeBSD.org/">スウェーデン/1</option>
		  <option value="http://www2.se.FreeBSD.org/">スウェーデン/2</option>
		  <option value="http://www.ch.FreeBSD.org/">スイス/1</option>
		  <option value="http://www2.ch.FreeBSD.org/">スイス/2</option>
		  <option value="http://www.tw.FreeBSD.org/">台湾/1</option>
		  <option value="http://www2.tw.FreeBSD.org/">台湾/2</option>
		  <option value="http://www3.tw.FreeBSD.org/">台湾/3</option>
		  <option value="http://www4.tw.FreeBSD.org/">台湾/4</option>
		  <option value="http://www.tr.FreeBSD.org/">トルコ/1</option>
		  <option value="http://www2.tr.FreeBSD.org/">トルコ/2</option>
		  <option value="http://www.enderunix.org/freebsd/">トルコ/3</option>
		  <option value="http://www.ua.FreeBSD.org/">ウクライナ/1</option>
		  <option value="http://www2.ua.FreeBSD.org/">ウクライナ/2</option> 
		  <option value="http://www4.ua.FreeBSD.org/">ウクライナ/クリミア</option> 
		  <option value="http://www5.ua.FreeBSD.org/">ウクライナ/5</option> 
		  <option value="http://www.uk.FreeBSD.org/">イギリス/1</option>
		  <option value="http://www2.uk.FreeBSD.org/">イギリス/2</option>
		  <option value="http://www3.uk.FreeBSD.org/">イギリス/3</option>
		  <option value="http://www4.uk.FreeBSD.org/">イギリス/4</option>
		  <option value="http://www.FreeBSD.org/">アメリカ/カリフォルニア</option>
		  <option value="http://www3.FreeBSD.org/">アメリカ/3</option>
		  <option value="http://www7.FreeBSD.org/">アメリカ/7</option>
		</select>
		
		<input type="submit" value=" Go "/>
		
		<br/>
		
		<font color="#990000"><b>言語: </b></font> 
		<a href="../">英語</a>、
		<a href="../it/index.html">イタリア語</a>、
		<a href="../ru/index.html">ロシア語</a>、
		<a href="../es/index.html">スペイン語</a>、
		<a href="support.html#web">その他</a>
	      </form>
	    </td>
	  </tr>
	</table>
	
	<br/>
	
	<hr size="1" noshade="noshade"/>

	<!-- Main layout table -->
	<table border="0" cellspacing="0" cellpadding="2">
	  <tr>
	    <td valign="top">
	      <table border="0" cellspacing="0" cellpadding="1"
		     bgcolor="#000000" width="100%">
		<tr>
		  <td>
		    <table cellpadding="4" cellspacing="0" border="0"
			   bgcolor="#ffcc66" width="100%">
		      <tr>
			<td>
			  <p><font size="+1" color="#990000"><b>ニュース</b></font>

	      
			    <small><br/>
			      ・<a href="news/newsflash.html">アナウンス</a><br/>
			      ・<a href="news/press.html">報道</a><br/>
			      ・<a href="news/index.html">さらに ...</a>
			    </small></p>
	    
			  <p><font size="+1" color="#990000"><b>ソフトウェア</b></font>
			    <small><br/>
			      ・<a href="{$enbase}/doc/ja_JP.eucJP/books/handbook/mirrors.html">FreeBSD を手に入れる</a><br/>
			      ・<a href="releases/index.html">リリース情報</a><br/>
			      ・<a href="{$base}/ports/index.html">Ports Collection</a><br/>
			    </small></p>
	    
			  <p><font size="+1" color="#990000"><b>ドキュメント</b></font>
		
			    <small><br/>
			      ・<a href="projects/newbies.html">初心者のために</a><br/>
			      ・<a href="{$enbase}/doc/ja_JP.eucJP/books/handbook/index.html">ハンドブック</a><br/>
			      ・<a href="{$enbase}/doc/ja_JP.eucJP/books/faq/index.html">FAQ</a><br/>
			      ・<a href="http://www.FreeBSD.org/cgi/man.cgi">マニュアルページ</a><br/>
			      ・<a href="{$base}/docproj/index.html">Doc. Project</a><br/>
			      ・<a href="docs.html">さらに...</a><br/>
			    </small></p>
			  
			  <p><font size="+1" color="#990000"><b>サポート</b></font>
	      
			    <small><br/>
			      ・<a href="{$base}/support.html#mailing-list">メーリングリスト</a><br/>
			      ・<a href="{$base}/support.html#newsgroups">ニュースグループ</a><br/>
			      ・<a href="{$base}/support.html#user">ユーザグループ</a><br/>
			      ・<a href="{$base}/support.html#web">Web 上の資料</a><br/>
			      ・<a href="security/index.html">セキュリティ</a><br/>
			      ・<a href="{$base}/support.html">さらに...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>障害報告</b></font>
			    <small><br/>
			      ・<a href="send-pr.html">障害報告の送付</a><br/>
			      ・<a href="http://www.FreeBSD.org/cgi/query-pr-summary.cgi">未解決の報告の閲覧</a><br/>
			      ・<a href="http://www.FreeBSD.org/cgi/query-pr.cgi">障害 ID で検索する</a><br/>
			      ・<a href="{$base}/support.html#gnats">さらに...</a><br/>
			    </small></p>

	      
			  <p><font size="+1" color="#990000"><b>開発</b></font>
		
			    <small><br/>
			      ・<a href="projects/index.html">プロジェクト</a><br/>
			      ・<a href="../releng/index.html">Release Engineering</a><br/>
			      ・<a href="{$base}/support.html#cvs">CVS リポジトリ</a><br/>
			    </small></p>
	      
			  <p><font size="+1" color="#990000"><b>ベンダ</b></font>
			    
			    <small><br/>
			      ・<a href="{$base}/../commercial/software_bycat.html">ソフトウェア</a><br/>
			      ・<a href="{$base}/../commercial/hardware.html">ハードウェア</a><br/>
			      ・<a href="{$base}/../commercial/consulting_bycat.html">コンサルティング</a><br/>
			      ・<a href="{$base}/../commercial/misc.html">その他</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>寄付・寄贈</b></font>
			    <small><br/>
			      ・<a href="{$enbase}/donations/index.html">寄付・寄贈品の受付</a><br/>
			      ・<a href="{$enbase}/donations/donors.html">現在の寄贈品</a><br/>
			      ・<a href="{$enbase}/donations/wantlist.html">寄付募集リスト</a><br/>
			    </small></p>
	      
			  <p><font size="+1" color="#990000"><b>このサイトについて</b></font>
		
			    <small><br/>
			      ・<a href="{$base}/search/index-site.html">サイトマップ</a><br/>
			      ・<a href="{$base}/search/search.html">検索</a><br/>
			      ・<a href="internal/index.html">さらに...</a><br/>
			    </small></p>
	      
			  <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
			    <small>検索:<br/>
			      <input type="text" name="words" size="10"/>
			      <input type="hidden" name="max" value="25"/>
			      <input type="hidden" name="source" value="www"/>
			      <input type="submit" value="実行"/></small>
			  </form></td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>
	    </td>
	    
	    <td></td>
	    
	    <!-- Main body column -->

	    <td align="left" valign="top" rowspan="2">
	      
	      <h2><font color="#990000">FreeBSD とは?</font></h2>
	
	      <p>FreeBSD は x86 互換機、DEC Alpha、IA-64、PC-98
		アーキテクチャ用の先進的なオペレーティングシステムです。
		カリフォルニア大学バークレイ校で開発された <xsl:value-of select="$unix"/>
		である BSD UNIX に由来し、
		<a href="{$enbase}/doc/ja_JP.eucJP/articles/contributors/index.html">多くの人たち</a>
		によって保守・開発されています。
		その他の<a href="{$base}/platforms/index.html">プラットフォーム
		</a> は現在開発中です。</p>
	      
	      <h2><font color="#990000">最先端の機能</font></h2>

	      <p>FreeBSD は (市販の最良のものも含めて) 他のオペレーティング
		システムに未だに欠けている最先端のネットワーク、パフォーマンス、
		セキュリティ、互換性といった <a href="{$base}/features.html">
		  機能</a> を今、提供しています。</p>
	      
	      <h2><font color="#990000">強力なインターネットサポート</font></h2>

	      <p>FreeBSD は理想的な <a href="{$base}/internet.html">
		  インターネットやイントラネット</a> サーバになります。負荷が
		極めて高くなった状態でさえ強固なネットワークサービスを提供し、
		ユーザプロセスが同時に何千になっても良好な反応時間を
		維持するようにメモリを効率的に利用します。
		FreeBSD を利用したアプリケーションやサービスの例を
		載せていますので、ぜひわたしたちの
		<a href="gallery/gallery.html">ギャラリー</a>
		をご覧になってみてください。</p>
	    
	      <h2><font color="#990000">数多くの対応アプリケーション</font></h2>

	      <p>高い品質を持つ FreeBSD と、今日の低価格で高速な
                PC ハードウェアの組み合わせは、
                市販の <xsl:value-of select="$unix"/> ワークステーションに匹敵する、
                非常に経済的な選択肢になるでしょう。
                デスクトップ用、サーバ用の両方について、膨大な数の
		<a href="{$base}/applications.html">アプリケーション</a>
		も用意されています。</p>
	    
	      <h2><font color="#990000">簡単インストール</font></h2>

	      <p>FreeBSD は CD-ROM や DVD-ROM、フロッピーディスク、磁気テープ、MS-DOS&#174;
		パーティションなどのさまざまなメディアからインストールすることが
		できます。ネットワークに接続しているなら、anonymous FTP や NFS
		を用いて <i>直接</i> インストールすることもできます。
		必要なのは 1.44MB の起動フロッピー 2 枚と、
		<a href="{$enbase}/doc/ja_JP.eucJP/books/handbook/install.html">これらの方法</a>
		だけです。</p>

	      <h2><font color="#990000"><i>無料</i>で使える FreeBSD</font></h2>
	    
	      <a href="copyright/daemon.html"><img src="../gifs/dae_up3.gif" 
						   alt=""
						   height="81" width="72" 
						   align="right" 
						   border="0"/></a>

	      <p>このような特色を持ったオペレーティングシステムは高い値段で
		販売されていると思われるかもしれませんが、FreeBSD
		は <a href="{$base}/copyright/index.html">無料</a> で入手でき、
		すべてのソースコードが付属しています。
		試してみようかな、という方は
		<a href="{$enbase}/doc/ja_JP.eucJP/books/handbook/mirrors.html">
		  より詳しい情報</a> を
		ご覧ください。</p>

	      <h2><font color="#990000">FreeBSD への貢献</font></h2>

	      <p>FreeBSD に貢献するのは簡単です。
		あなたが FreeBSD の中で改善できそうな部分を探し、
		その部分に変更を (注意深く、わかりやすく) 加えて
		FreeBSD プロジェクトに届けるだけです。
		その際には send-pr を使うか、
		もし知っているなら、コミッターに直接連絡しても OK です。
		変更は、FreeBSD の文書に対するものでも、FreeBSD
		ソースコードに対するものでも構いません。
		詳しくは、FreeBSD ハンドブックの
		<a href="{$enbase}/doc/ja_JP.eucJP/articles/contributing/index.html">
		  FreeBSD への貢献</a>
		(<a href="{$enbase}/doc/en_US.ISO8859-1/articles/contributing/index.html">原文</a>)
		というセクションをご覧ください。</p>

	      <p>もしあなたがプログラマでないとしても、いくつもの FreeBSD
		に貢献する方法があります。FreeBSD Foundation は非営利団体
		であり、直接の寄付は税金の控除対象となります。
		詳細に関しては <a href="mailto:bod@FreeBSDFoundation.org">
		  bod@FreeBSDFoundation.org</a> にメールを送るか、
		The FreeBSD Foundation、
		7321 Brockway Dr. Boulder, CO 80303.  USA
		まで手紙を書いてください。</p>

	      <p>Silicon Breeze 社は BSD デーモンの銅像を製作し、
		これらの売り上げの 15% を FreeBSD Foundation に還元しています。
		この BSD デーモンの詳細と注文方法については
		<a href="http://www.linuxjewellery.com/beastie/">このページ</a>
		を見てください。</p>
	    </td>

	    <td></td>

	    <!-- Right-most column -->
	    <td valign="top">
	      <!-- News / release info table -->
	      <table border="0" cellspacing="0" cellpadding="1"
		     bgcolor="#000000" width="100%">
		<tr>
		  <td>
		    <table cellpadding="4" cellspacing="0" border="0"
			   bgcolor="#ffcc66" width="100%">
		      <tr>
			<td valign="top"><p><font size="+1" color="#990000"><b>テクノロジリリース:
			    <xsl:value-of select="$rel.current"/></b></font><br/>
			
			    <small>・<a href="{$u.rel.announce}">アナウンス</a><br/>
			      ・<a href="{$enbase}/doc/ja_JP.eucJP/books/handbook/install.html">インストールガイド</a><br/>
			      ・<a href="{$u.rel.notes}">リリースノート</a><br/>
			      ・<a href="{$u.rel.hardware}">ハードウェアノート</a><br/>
			      ・<a href="{$u.rel.errata}">Errata</a><br/>
			      ・<a href="{$u.rel.early}">初期利用者のための手引き</a></small></p>

			<p><font size="+1" color="#990000"><b>プロダクションリリース:
			    <xsl:value-of select="$rel2.current"/></b></font><br/>
			
			    <small>・<a href="{$u.rel2.announce}">アナウンス</a><br/>
			      ・<a href="{$enbase}/doc/ja_JP.eucJP/books/handbook/install.html">インストールガイド</a><br/>
			      ・<a href="{$u.rel2.notes}">リリースノート</a><br/>
			      ・<a href="{$u.rel2.hardware}">ハードウェアリスト (英語)</a><br/>
			      ・<a href="{$u.rel2.errata}">Errata</a></small></p>

			  <p><font size="+1" color="#990000"><b>Project News</b></font><br/>
			    <font size="-1">
			      最終更新: 
			      <xsl:value-of
				select="format-number(number(descendant::year[position() = 1]/name),'0000')"/>
			      <xsl:text>/</xsl:text>
			      <xsl:value-of
				select="format-number(number(descendant::month[position() = 1]/name),'00')"/>
			      <xsl:text>/</xsl:text>
			      <xsl:value-of
				select="format-number(number(descendant::day[position() = 1]/name),'00')"/>:
			      <br/>
			      <!-- Pull in the 10 most recent news items -->
			      <xsl:for-each select="descendant::event[position() &lt;= 10]">
				・ <a>
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
			      <a href="news/newsflash.html">More...</a>
			    </font></p>
			  
			  <p><font size="+1" color="#990000"><b>FreeBSD Press</b></font><br/>

			    <font size="-1">
			      最終更新: 
			      <xsl:value-of
				select="format-number(number(document('news/press.xml')/descendant::year[position() = 1]/name),'0000')"/>
			      <xsl:text>/</xsl:text>
			      <xsl:value-of
				select="format-number(number(document('news/press.xml')/descendant::month[position() = 1]/name),'00')"/>:
			      <br/>
			      <!-- Pull in the 10 most recent press items -->
			      <xsl:for-each select="document('news/press.xml')/descendant::story[position() &lt; 10]">
				・ <a>
				  <xsl:attribute name="href">
				    news/press.html#<xsl:call-template name="generate-story-anchor"/>
				  </xsl:attribute>
				  <xsl:value-of select="name"/>
				</a><br/>
			      </xsl:for-each>
			      <a href="news/press.html">More...</a>
			    </font>
                          </p>

                          <p><font size="+1" color="#990000"><b>セキュリティ勧告</b></font><br/>

			    <font size="-1">
			      最終更新:
			      <xsl:value-of
				select="document('../en/security/advisories.xml')/descendant::month[position() = 1]/name"/>
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="document('../en/security/advisories.xml')/descendant::day[position() = 1]/name"/>
			      <xsl:text>, </xsl:text>
			      <xsl:value-of
				select="document('../en/security/advisories.xml')/descendant::year[position() = 1]/name"/>
			      <br/>
			      <!-- Pull in the 10 most recent security advisories -->
			      <xsl:for-each select="document('../en/security/advisories.xml')/descendant::advisory[position() &lt; 10]">
				・ <a>
				  <xsl:attribute name="href">ftp://ftp.freebsd.org/pub/FreeBSD/CERT/advisories/<xsl:value-of select="name"/>.asc</xsl:attribute>
				  <xsl:value-of select="name"/>
				</a><br/>
			      </xsl:for-each>
			      <a href="security/">More...</a>
                           </font>
			  </p>
			</td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>

	      <p>&#xa0;</p>

	      <table border="0" cellspacing="0" cellpadding="1"
		     bgcolor="#000000" width="100%">
		<tr>
		  <td>
		    <table cellpadding="4" cellspacing="0" border="0"
			   bgcolor="#FFFFFF" width="100%"><tr>
			<td>FreeBSD についてもっとよく知りたくなったら、
			  FreeBSD に関連する
			  <a href="{$base}/publish.html">出版物</a> や
			  <a href="news/press.html">FreeBSD 関係の報道</a> の
			  ギャラリーを訪ねたり、このウェブサイトを
			  見てみてください!</td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>
	    </td>
	  </tr>
	</table>

	<hr noshade="noshade" size="1" />

	<table width="100%" border="0" cellspacing="0" cellpadding="3">
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

	<p><small>このウェブサイトは毎日 8:00 UTC と 20:00 UTC に更新しています。
	  </small></p>
    
	<table width="100%" cellpadding="0" border="0" cellspacing="0">
	  <tr>
	    <td align="left" 
		valign="top"><small><a href="{$base}/mailto.html">お問い合わせ先</a> : <a href="jabout.html">日本語化について</a><br/>
		<xsl:value-of select="$date"/></small></td>

	    <td align="right" 
		valign="top"><small><a href="copyright/index.html">知的財産権について</a><br/> &#169; 1995-2003
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
