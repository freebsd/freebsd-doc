<?xml version="1.0" encoding="EUC-JP" ?>

<!-- $FreeBSD: www/ja/index.xsl,v 1.38 2004/12/09 19:48:57 rushani Exp $ -->
<!-- Original revision: 1.100 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="enbase" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD: www/ja/index.xsl,v 1.38 2004/12/09 19:48:57 rushani Exp $'"/>
  <xsl:variable name="title" select="'The FreeBSD Project'"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="advisories.xml" select="'none'"/>
  <xsl:param name="notices.xml" select="'none'"/>
  <xsl:param name="mirrors.xml" select="'none'"/>
  <xsl:param name="news.press.xml-master" select="'none'"/>
  <xsl:param name="news.press.xml" select="'none'"/>
  <xsl:param name="news.project.xml-master" select="'none'"/>
  <xsl:param name="news.project.xml" select="'none'"/>

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
	<!-- Formatted to be easy to spam harvest, please do not reformat. -->
	<xsl:comment>
	  Spamtrap, do not email:
	  &lt;a href="mailto:bruscar@freebsd.org"&gt;bruscar@freebsd.org&lt;/a&gt;
	</xsl:comment>
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
		  <!--  Only list TRUE mirrors here! Native language pages
		        which are not mirrored should be listed in
		        support.sgml.  -->

		  <xsl:call-template name="html-index-mirrors-options-list">
		    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
		  </xsl:call-template>
		</select>

		<input type="submit" value=" Go "/>

		<br/>

		<font color="#990000"><b>言語: </b></font>
		<a href="{$enbase}/de/index.html" title="ドイツ語">[de]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$enbase}/index.html" title="英語">[en]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$enbase}/es/index.html" title="スペイン語">[es]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$enbase}/fr/index.html" title="フランス語">[fr]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$enbase}/it/index.html" title="イタリア語">[it]</a>
		<xsl:text>&#160;</xsl:text>
		<span title="日本語">[ja]</span>
		<xsl:text>&#160;</xsl:text>
		<a href="{$enbase}/ru/index.html" title="ロシア語">[ru]</a>
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
			  <xsl:call-template name="html-index-navigation-link-list">
			    <xsl:with-param name="navigation.xml" select="$navigation.xml"/>
			  </xsl:call-template>

			  <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
			    <small>検索:<br/>
			      <input type="text" name="words" size="10"/>
			      <input type="hidden" name="max" value="25"/>
			      <input type="hidden" name="source" value="www"/>
			      <input type="submit" value="実行"/></small>
			  </form>
			</td>
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

	      <p>FreeBSD は x86 互換機、x86-64 互換機、Alpha/AXP,
		IA-64, PC-98, UltraSPARC&#174;
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
		維持するようにメモリを効率的に利用します。</p>

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
						   alt="The BSD Daemon"
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
		に貢献する方法があります。<a href="http://www.FreeBSDFoundation.org">FreeBSD Foundation</a> は非営利団体
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
			<td valign="top"><p>
			      <a href="{$u.rel.announce}">
			      <font size="+1" color="#990000"><b>プロダクションリリース:
			    <xsl:value-of select="$rel.current"/></b></font></a><br/>
			    <small>・<a href="{$enbase}/doc/ja_JP.eucJP/books/handbook/install.html">インストールガイド</a><br/>
			      ・<a href="{$u.rel.notes}">リリースノート</a><br/>
			      ・<a href="{$u.rel.hardware}">ハードウェアノート</a><br/>
			      ・<a href="{$u.rel.installation}">インストールノート</a><br/>
			      ・<a href="{$u.rel.errata}">Errata</a><br/>
			      ・<a href="{$u.rel.early}">Migration Guide</a></small></p>

			<p>
			      <a href="{$u.rel2.announce}">
			      <font size="+1" color="#990000"><b>プロダクションリリース (Legacy):
			    <xsl:value-of select="$rel2.current"/></b></font></a><br/>

			    <small>・<a href="{$enbase}/doc/ja_JP.eucJP/books/handbook/install.html">インストールガイド</a><br/>
			      ・<a href="{$u.rel2.notes}">リリースノート</a><br/>
			      ・<a href="{$u.rel2.hardware}">ハードウェアリスト (英語)</a><br/>
			      ・<a href="{$u.rel2.installation}">インストールノート</a><br/>
			      ・<a href="{$u.rel2.errata}">Errata (英語)</a></small></p>

			  <p><font size="+1" color="#990000"><b>Project News</b></font>
			    <xsl:text> </xsl:text>
			    <font color="#990000">(<a href="{$enbase}/news/news.rdf">RSS</a>)</font><br/>
			    <font size="-1">
			      最終更新:
			      <xsl:call-template name="html-index-news-project-items-lastmodified">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
			      </xsl:call-template>

			      <br/>

			      <xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			      </xsl:call-template>

			      <a href="news/newsflash.html">さらに...</a>
			    </font></p>

			  <p><font size="+1" color="#990000"><b>FreeBSD Press</b></font><br/>

			    <font size="-1">
			      最終更新:
			      <xsl:call-template name="html-index-news-press-items-lastmodified">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
			      </xsl:call-template>

			      <br/>

			      <xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			      </xsl:call-template>

			      <a href="news/press.html">さらに...</a>
			    </font>
			  </p>

			  <p><font size="+1" color="#990000"><b>セキュリティ勧告</b></font>
			    <xsl:text> </xsl:text>
			    <font color="#990000">(<a href="{$enbase}/security/advisories.rdf">RSS</a>)</font><br/>

			    <font size="-1">
			      最終更新:
			      <xsl:call-template name="html-index-advisories-items-lastmodified">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			      </xsl:call-template>

			      <br/>

			      <xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			      </xsl:call-template>

			      <a href="security/">さらに...</a>
			    </font>
			  </p>

			  <p><font size="+1" color="#990000"><b>Errata Notices</b></font>
			    <xsl:text> </xsl:text>
			    <br/>
			    <font size="-1">
			      最終更新:
			      <xsl:call-template name="html-index-advisories-items-lastmodified">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			      </xsl:call-template>

			      <br/>

			      <xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			      </xsl:call-template>
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

	    <td><a href="{$enbase}/art.html"><img
							     src="../gifs/powerlogo.gif"
							     alt="[Powered by FreeBSD]"
							     height="64"
							     width="160"
							     border="0"/></a></td>
	  </tr>
	</table>

	<table width="100%" cellpadding="0" border="0" cellspacing="0">
	  <tr>
	    <td align="left"
		valign="top"><small><a href="{$base}/mailto.html">お問い合わせ先</a> : <a href="jabout.html">日本語化について</a><br/>
		<xsl:value-of select="$date"/></small></td>

	    <td align="right"
		valign="top"><small><a href="copyright/index.html">知的財産権について</a><br/> &#169; 1995-2004
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
