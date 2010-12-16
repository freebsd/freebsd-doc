<?xml version="1.0" encoding="EUC-JP" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY email "freebsd-ia64">
<!ENTITY title "FreeBSD/ia64 プロジェクト">
<!ENTITY % navinclude.developers "INCLUDE">
]>

<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: 1.7 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD'"/>

  <xsl:output doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    encoding="EUC-JP" method="html"/>
  <xsl:template match="/">
    <html>
      &header1;
      <body>

	<div id="CONTAINERWRAP">
	  <div id="CONTAINER">
	    &header2;

	    <div id="CONTENT">
	      <div id="SIDEWRAP">
                &nav;
              </div> <!-- SIDEWRAP -->

	      <div id="CONTENTWRAP">
		&header3;

		<img align="right" alt="McKinley die" src="&enbase;/platforms/ia64/mckinley-die.png"/>

		<p>freebsd-ia64 メーリングリストのアーカイブを検索:</p>

		<form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
		  <input name="words" size="50" type="text"/>
		  <input name="max" type="hidden" value="25"/>
		  <input name="source" type="hidden" value="freebsd-ia64"/>
		  <input type="submit" value="Go"/>
		</form>

		<h3><a name="toc">目次</a></h3>

		<ul>
		  <li>
		    <a href="#intro">はじめに</a>
		  </li>
		  <li>
		    <a href="#status">現在の状況</a>
		  </li>
		  <li>
		    <a href="todo.html">課題</a>
		  </li>
		  <li>
		    <a href="machines.html">ハードウェアリスト</a>
		  </li>
		  <li>
		    <a href="refs.html">参考文献</a>
		  </li>
		</ul>

		<h3><a name="intro">はじめに</a></h3>

		<p>FreeBSD/ia64 プロジェクトのページには、公式には Intel
		  Itanium&reg; プロセッサファミリ (IPF) として知られている Intel 
		  の IA-64 アーキテクチャへの FreeBSD の移植に関する情報が掲載されています。
		  移植そのものと同じく、このページはまだ大部分が作成中です。</p>

		<h3><a name="status">現在の状況</a></h3>

		<p>ia64 版 FreeBSD は、まだ tier 2 プラットフォームと見なされています。
		  つまり、セキュリティオフィサやリリースエンジニア、
		  ツールチェインメンテナの全面的なサポートはありません。しかしながら、実際の
		  (全面的にサポートされる) tier 1 プラットフォームと
		  tier 2 プラットフォームの違いは、
		  それほど厳密ではありません。ia64 版は、ほぼすべての側面において、
		  tier 1 プラットフォームと同等になっています。
		  <br/>
		  開発者の立場で考えると、ia64 版がもうしばらく tier 2
		  プラットフォームであることには有利な点があります。
		  まだいくつか ABI の非互換な変更が控えていて、
		  移植のこんなに初期から後方互換性を維持しなければならないというのは、
		  理想的とはとてもいえないからです。</p>

	      </div> <!-- CONTENTWRAP -->

	      <br class="clearboth" />
	    </div> <!-- CONTENT -->

            <div id="FOOTER">
               &copyright;<br />
               &date;
            </div> <!-- FOOTER -->
	  </div> <!-- CONTAINER -->
	</div> <!-- CONTAINERWRAP -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
