<!-- $Id: ports.inc,v 1.1.1.1 1997-11-23 22:23:06 max Exp $ -->
<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: 1.17 -->
<p>FreeBSD Ports コレクションは, ユーザや管理者が簡単にアプリケーショ
ンのインストールを簡単に行う方法を提供します.
ここに並べられている各 ``port'' には, FreeBSD でオリジナルのアプリケー
ションのソースコードをコンパイルし実行するために必要なパッチが全て含ま
れています.
アプリケーションのインストールは簡単で, port をダウンロードし, それを
展開し, port ディレクトリで <tt>make</tt> と打つだけです.
<tt>Makefile</tt>は自動的に, ローカルディスクか ftp 経由でアプリケーショ
ンのソースコードを取ってきて, あなたのシステム上で展開し, パッチをあて, 
コンパイルします. 
問題がないようなら, あとは<tt>make install</tt>と打つだけでアプリケー
ションをインストールできます. </p>

<p>ports についてもう少し詳しく知りたい場合には, 
<a href="../handbook/ports.html">ports コレクション</a> を参照してくだ
さい. 新しい ports を作るには, 
<a href="../handbook/porting.html">フリーソフトウェアの移植</a> を参照
してください. どちらも <a href="../handbook">FreeBSD ハンドブック</a> 
の一部です.</p>

<p>もしあなたが 2.2.1-release のユーザなら, 
<a href="ftp://ftp.freebsd.org/pub/FreeBSD/packages-2.2.2/221upgrade-97.07.21.tgz">
2.2.1 から 2.2-stable へのアップグレードキット</a> (最終更新: 1997 年 
7 月 21 日) をインストールしてください. 
もしあなたが 2.2.2-release のユーザなら, 
<a href="ftp://ftp.freebsd.org/pub/FreeBSD/packages-2.2.2/222upgrade-97.07.21.tgz">
2.2.2 から 2.2-stable へのアップグレードキット</a> (最終更新: 1997 年 
7 月 21 日) をインストールしてください.
(これらは FreeBSD のパッケージになっています. インストールには pkg_add 
を使ってください.)
これでここに載っている全ての ports を使うことができるようになります. 
このアップグレードキットは ports やパッケージを使うのに必要なファイル
だけを更新します. 2.2-stable への完全なアップグレードについては, ハン
ドブックの<a href="../handbook/synching.html">
インターネットを通じたソースツリーの同期</a>を参照してください. 
完全なアップグレードが(まだ 2.2.1-release を使っている
場合は特に)推奨されています.</p>

<p>多くの ports はコンパイルと実行に X Windows System を必要とします. 
ports は <a href="http://www.xfree86.org/">XFree86</a> 上でテ
ストされています. 最新のリリースは 3.3.1 です. いくつかの ports は古い
リリースでは動作しないかも知れません. </p>

<p>ports の追加, 更新, 削除についての情報や, アプリケーションの検索は
<a href="http://www.freebsd.org/cgi/ports.cgi">
FreeBSD Ports 更新</a> スクリプトを参照してください. </p>

<FORM METHOD="GET" ACTION="http://www.freebsd.org/cgi/ports.cgi">
検索:
<INPUT NAME="query" VALUE="">
<SELECT NAME="stype">
<OPTION VALUE="all">全て</OPTION>
<OPTION VALUE="name">パッケージ名</OPTION>
<OPTION VALUE="text">詳細</OPTION>
</SELECT>
<INPUT TYPE="submit" VALUE="Submit">
</FORM>

